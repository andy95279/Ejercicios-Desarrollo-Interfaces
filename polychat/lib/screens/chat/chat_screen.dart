import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/chat_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/pattern_painter.dart';
import '../../models/message.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      context.read<ChatProvider>().sendMessage(
        widget.chatId,
        _messageController.text,
      );
      _messageController.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _showAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Compartir',
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 24,
              crossAxisSpacing: 16,
              children: [
                _buildAttachmentOption(
                  context,
                  Icons.photo_outlined,
                  'Fotos',
                  Colors.blue,
                ),
                _buildAttachmentOption(
                  context,
                  Icons.location_on_outlined,
                  'Ubicación',
                  Colors.green,
                ),
                _buildAttachmentOption(
                  context,
                  Icons.person_outline,
                  'Contacto',
                  Colors.orange,
                ),
                _buildAttachmentOption(
                  context,
                  Icons.insert_drive_file_outlined,
                  'Documentos',
                  Colors.purple,
                ),
                _buildAttachmentOption(
                  context,
                  Icons.poll_outlined,
                  'Encuesta',
                  Colors.yellow,
                ),
                _buildAttachmentOption(
                  context,
                  Icons.event_outlined,
                  'Eventos',
                  Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Función "$label" próximamente disponible'),
            backgroundColor: color.withOpacity(0.8),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  void _showSchedulingDialog(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).brightness == Brightness.dark
              ? const ColorScheme.dark(
                  primary: Colors.blueAccent,
                  surface: Color(0xFF151515),
                )
              : ColorScheme.fromSeed(
                  seedColor: Colors.blueAccent,
                  brightness: Brightness.light,
                ),
        ),
        child: child!,
      ),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).brightness == Brightness.dark
                ? const ColorScheme.dark(
                    primary: Colors.blueAccent,
                    surface: Color(0xFF151515),
                  )
                : ColorScheme.fromSeed(
                    seedColor: Colors.blueAccent,
                    brightness: Brightness.light,
                  ),
          ),
          child: child!,
        ),
      );

      if (time != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mensaje programado correctamente'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _handleMicAction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Presiona y mantén para grabar audio'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final chat = chatProvider.chats.firstWhere((c) => c.id == widget.chatId);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Barra superior: Muestra el avatar, nombre, idioma y estado del contacto
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      chat.participantName,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      chat.participantLanguage ?? '',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).textTheme.bodySmall?.color?.withOpacity(0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  chat.participantStatus ?? 'Desconectado',
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Área de Mensajes: Lista de burbujas de chat con fondo decorativo opcional
          Expanded(
            child: Stack(
              children: [
                if (context.watch<SettingsProvider>().chatBackgroundIndex > 0)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PatternPainter(
                        context.watch<SettingsProvider>().chatBackgroundIndex,
                        Theme.of(context).dividerColor.withOpacity(
                          Theme.of(context).brightness == Brightness.dark
                              ? 0.05
                              : 0.1,
                        ),
                      ),
                    ),
                  ),
                ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: chat.messages.length,
                  itemBuilder: (context, index) {
                    final message = chat.messages[index];
                    return MessageBubble(
                      message: message,
                      onToggleOriginal: () {
                        chatProvider.toggleOriginal(chat.id, message.id);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          _buildInputArea(context, chat.participantLanguage ?? 'GB'),
        ],
      ),
    );
  }

  // Barra de Entrada de Mensajes: Incluye adjuntos, campo de texto, programador, voz y enviar
  Widget _buildInputArea(BuildContext context, String targetLang) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.attach_file,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
                ),
                onPressed: () => _showAttachmentMenu(context),
              ),
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Escribe en ES...',
                            hintStyle: TextStyle(
                              color: Theme.of(
                                context,
                              ).hintColor.withOpacity(0.3),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        'ES',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.access_time,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
                ),
                onPressed: () => _showSchedulingDialog(context),
              ),
              IconButton(
                icon: Icon(
                  Icons.mic_none,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
                ),
                onPressed: () => _handleMicAction(context),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'Tu mensaje será traducido automáticamente a $targetLang',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).textTheme.bodySmall?.color?.withOpacity(0.4),
                  fontSize: 11,
                ),
              ),
              Positioned(
                left: 0,
                child: Text(
                  '0',
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final VoidCallback onToggleOriginal;

  const MessageBubble({
    super.key,
    required this.message,
    required this.onToggleOriginal,
  });

  @override
  Widget build(BuildContext context) {
    // Burbuja de mensaje individual: Diferencia visual entre mensajes propios y recibidos
    final isMe = message.senderId == '1';
    final timeStr = DateFormat('HH:mm').format(message.timestamp);

    if (isMe) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFCC4422),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '12',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: message.isAudio
                      ? _buildAudioPlayer(context, true)
                      : Text(
                          message.text,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 15,
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              timeStr,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.4),
                fontSize: 11,
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=emma'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: message.isAudio
                        ? _buildAudioPlayer(context, false)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (message.sourceLanguage != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.translate,
                                        size: 14,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Traducido de ${message.sourceLanguage}',
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Text(
                                message.showOriginal
                                    ? (message.originalText ?? message.text)
                                    : message.text,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        timeStr,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).textTheme.bodySmall?.color?.withOpacity(0.4),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (message.originalText != null)
                        GestureDetector(
                          onTap: onToggleOriginal,
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                size: 14,
                                color: Colors.white.withOpacity(0.6),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                message.showOriginal
                                    ? 'Ver traducción'
                                    : 'Ver original',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      );
    }
  }

  Widget _buildAudioPlayer(BuildContext context, bool isMe) {
    final color = isMe
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        Icon(Icons.play_arrow_rounded, color: color, size: 32),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(1),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0:12',
                    style: TextStyle(
                      color: color.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    message.audioDuration ?? '0:30',
                    style: TextStyle(
                      color: color.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
