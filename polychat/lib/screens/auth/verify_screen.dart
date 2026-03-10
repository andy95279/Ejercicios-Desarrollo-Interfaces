import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _codeController = TextEditingController();

  Future<void> _verify() async {
    final success = await context.read<AuthProvider>().verify(
      _codeController.text,
    );
    if (success) {
      if (mounted) context.go('/home');
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Código incorrecto (Usa 123456)')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Barra superior con botón de retroceso transparente
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icono ilustrativo de verificación
            Icon(
              Icons.mark_email_unread_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 64,
            ),
            const SizedBox(height: 32),
            Text(
              'Verifica tu cuenta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Ingresa el código de 6 dígitos que enviamos a tu dispositivo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            // Campo de Entrada del Código: 6 dígitos con espaciado amplio
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                hintText: '000 000',
                hintStyle: TextStyle(
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                  letterSpacing: 8,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withOpacity(0.1),
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.4),
                  ),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              buildCounter:
                  (
                    context, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) => null,
            ),
            const SizedBox(height: 24),
            // Nota de Ayuda Demo: Muestra el código fijo para pruebas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber, size: 20),
                  SizedBox(width: 12),
                  Text(
                    'Usa el código 123456 para la demo',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            // Botón de Acción: Confirmar verificación del código
            authProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : ElevatedButton(
                    onPressed: _verify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Verificar ahora',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            // Opción de Reenvío: Para solicitar un nuevo código
            TextButton(
              onPressed: () {
                // Simular reenvío
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Código reenviado')),
                );
              },
              child: Text(
                '¿No recibiste el código? Reenviar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
