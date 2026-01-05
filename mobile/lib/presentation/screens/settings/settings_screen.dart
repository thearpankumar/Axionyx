import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/text_styles.dart';
import '../../widgets/common/glass_card.dart';
import '../../providers/theme_provider.dart';
import '../../providers/settings_provider.dart';

/// Settings screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: AppTextStyles.headlineSmall,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Appearance Section
              Text(
                'Appearance',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),

              // Theme Mode
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Theme',
                      style: AppTextStyles.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.system,
                          label: Text('System'),
                          icon: Icon(Icons.brightness_auto),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.light,
                          label: Text('Light'),
                          icon: Icon(Icons.light_mode),
                        ),
                        ButtonSegment<ThemeMode>(
                          value: ThemeMode.dark,
                          label: Text('Dark'),
                          icon: Icon(Icons.dark_mode),
                        ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (Set<ThemeMode> newSelection) {
                        ref
                            .read(themeModeProvider.notifier)
                            .setThemeMode(newSelection.first);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // About Section
              Text(
                'About',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),

              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      context,
                      'App Name',
                      'Axionyx Mobile',
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      'Version',
                      '1.0.0',
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      'Build',
                      '1',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Device Settings Section
              Text(
                'Device Settings',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),

              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Auto-reconnect'),
                      subtitle: const Text(
                        'Automatically reconnect to devices on connection loss',
                      ),
                      value: settings.autoReconnect,
                      onChanged: (value) {
                        ref
                            .read(settingsProvider.notifier)
                            .setAutoReconnect(value);
                      },
                    ),
                    const Divider(),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Show notifications'),
                      subtitle: const Text(
                        'Receive alerts for device status changes',
                      ),
                      value: settings.notificationsEnabled,
                      onChanged: (value) {
                        ref
                            .read(settingsProvider.notifier)
                            .setNotificationsEnabled(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
