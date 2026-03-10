import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'profile_settings_screen.dart';
import 'interface_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
              ),
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Cabecera de Ajustes: Título de la sección y botón de cerrar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ajustes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(
                              context,
                            ).textTheme.titleLarge?.color,
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Barra de Pestañas: Selector entre ajustes de Perfil y Apariencia
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceVariant.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelColor: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer,
                        unselectedLabelColor: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        tabs: const [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_outline, size: 18),
                                SizedBox(width: 8),
                                Text('Perfil'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.palette_outlined, size: 18),
                                SizedBox(width: 8),
                                Text('Apariencia'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Contenido de la Pestaña: Muestra la pantalla correspondiente según la selección
                  const Expanded(
                    child: TabBarView(
                      children: [
                        ProfileSettingsScreen(),
                        InterfaceSettingsScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
