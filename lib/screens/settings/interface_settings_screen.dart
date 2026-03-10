import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/pattern_painter.dart';

class InterfaceSettingsScreen extends StatelessWidget {
  const InterfaceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopTabs(context),
                    const SizedBox(height: 32),
                    _buildThemeModeSection(context, settings),
                    const SizedBox(height: 32),
                    _buildAccentColorSection(context, settings),
                    const SizedBox(height: 32),
                    _buildChatBackgroundSection(context, settings),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ajustes',
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTabs(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabItem(
              context,
              'Perfil',
              Icons.person_outline,
              false,
            ),
          ),
          Expanded(
            child: _buildTabItem(
              context,
              'Apariencia',
              Icons.palette_outlined,
              true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    String title,
    IconData icon,
    bool isSelected,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(
                    context,
                  ).textTheme.bodySmall?.color?.withOpacity(0.5),
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  // Sección de Modo de Tema: Permite elegir entre Claro, Oscuro o Sistema
  Widget _buildThemeModeSection(
    BuildContext context,
    SettingsProvider settings,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modo de tema',
          style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Selecciona el tema de la aplicación',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildThemeCard(
                'Claro',
                Icons.wb_sunny_outlined,
                ThemeMode.light,
                context,
                settings,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildThemeCard(
                'Oscuro',
                Icons.nightlight_outlined,
                ThemeMode.dark,
                context,
                settings,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildThemeCard(
                'Auto',
                Icons.important_devices_outlined,
                ThemeMode.system,
                context,
                settings,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeCard(
    String label,
    IconData icon,
    ThemeMode mode,
    BuildContext context,
    SettingsProvider settings,
  ) {
    final isSelected = settings.themeMode == mode;
    return GestureDetector(
      onTap: () => settings.setThemeMode(mode),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.5),
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).textTheme.bodySmall?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sección de Color de Acento: Selector circular de colores para la identidad visual
  Widget _buildAccentColorSection(
    BuildContext context,
    SettingsProvider settings,
  ) {
    final colors = [
      const Color(0xFF3D8BFF),
      const Color(0xFF9E5EFF),
      const Color(0xFF2ECC71),
      const Color(0xFFFF8C00),
      const Color(0xFFFF5E9E),
      const Color(0xFFFF4D4D),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color de acento',
          style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Personaliza el color principal de la app',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final isSelected = settings.accentColorIndex == index;
              return GestureDetector(
                onTap: () => settings.setAccentColor(index),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 32)
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Sección de Fondo del Chat: Permite elegir entre diferentes patrones decorativos para los mensajes
  Widget _buildChatBackgroundSection(
    BuildContext context,
    SettingsProvider settings,
  ) {
    final patterns = ['Predeterminado', 'Patrón 1', 'Patrón 2'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fondo del chat',
          style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Personaliza el fondo de tus conversaciones',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(patterns.length, (index) {
          final isSelected = settings.chatBackgroundIndex == index;
          return GestureDetector(
            onTap: () => settings.setChatBackground(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).dividerColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: index > 0
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CustomPaint(
                              painter: PatternPainter(
                                index,
                                Theme.of(context).dividerColor.withOpacity(0.2),
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    patterns[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (isSelected)
                    Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
