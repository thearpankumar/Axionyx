import 'package:flutter/material.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/glass_button.dart';
import '../../../core/theme/text_styles.dart';

/// Home screen showing discovered devices
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'My Devices',
          style: AppTextStyles.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search devices...',
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),
                      ),
                    ),
                    onChanged: (value) {
                      // TODO: Implement search
                    },
                  ),
                ),
              ),

              // Device list placeholder
              Expanded(
                child: _buildEmptyState(context),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Trigger mDNS scan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Scanning for devices...')),
          );
        },
        icon: const Icon(Icons.wifi_find),
        label: const Text('Scan Devices'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.devices_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No devices found',
            style: AppTextStyles.titleMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the button below to scan for devices',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 24),
          GlassButton(
            label: 'Add Device Manually',
            icon: Icons.add,
            onPressed: () {
              // TODO: Show manual device entry dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Manual entry coming soon...')),
              );
            },
          ),
        ],
      ),
    );
  }
}
