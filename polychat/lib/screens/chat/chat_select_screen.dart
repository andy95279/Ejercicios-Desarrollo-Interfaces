import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/chat_provider.dart';

class ChatSelectScreen extends StatefulWidget {
  const ChatSelectScreen({super.key});

  @override
  State<ChatSelectScreen> createState() => _ChatSelectScreenState();
}

class _ChatSelectScreenState extends State<ChatSelectScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ChatProvider>().loadChats();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Barra superior: Logo de PolyChat y botón de ajustes
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.forum_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              'PolyChat',
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
            ),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: chatProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            )
          : Column(
              children: [
                Divider(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                  height: 1,
                ),
                // Lista de Selección de Chat: Muestra todos los contactos disponibles para hablar
                Expanded(
                  child: ListView.builder(
                    itemCount: chatProvider.chats.length,
                    itemBuilder: (context, index) {
                      final chat = chatProvider.chats[index];
                      return Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.05),
                          highlightColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.02),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest
                                    .withOpacity(0.2),
                                child: chat.participantName == 'Emma Wilson'
                                    ? const ClipOval(
                                        child: Image(
                                          image: NetworkImage(
                                            'https://i.pravatar.cc/150?u=emma',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Text(
                                        chat.participantName[0],
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                              ),
                              if (chat.participantStatus != 'Desconectado')
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          title: Row(
                            children: [
                              Text(
                                chat.participantName,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              if (chat.participantLanguage != null) ...[
                                const SizedBox(width: 6),
                                Text(
                                  chat.participantLanguage!,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color
                                        ?.withOpacity(0.5),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              chat.lastMessage ?? 'No hay mensajes',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                chat.lastMessageTime != null
                                    ? DateFormat(
                                        'HH:mm',
                                      ).format(chat.lastMessageTime!)
                                    : '',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color
                                      ?.withOpacity(0.4),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (chat.id == '1') // Mock unread indicator
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          onTap: () => context.push('/chat/${chat.id}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
