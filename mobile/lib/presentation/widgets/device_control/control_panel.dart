import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/text_styles.dart';
import '../common/glass_card.dart';
import '../common/glass_button.dart';

/// Control panel for device operations
class ControlPanel extends StatelessWidget {
  final String state;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final bool isLoading;
  final String deviceType;

  const ControlPanel({
    super.key,
    required this.state,
    required this.onStart,
    required this.onStop,
    required this.onPause,
    required this.onResume,
    this.isLoading = false,
    this.deviceType = 'device',
  });

  bool get _isRunning => state == 'RUNNING';
  bool get _isPaused => state == 'PAUSED';
  bool get _isIdle => state == 'IDLE';

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Controls',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 16),
          _buildControlButtons(context),
        ],
      ),
    );
  }

  Widget _buildControlButtons(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Row(
      children: [
        // Start button - shown when IDLE or COMPLETE
        if (_isIdle || state == 'COMPLETE')
          Expanded(
            child: GlassButton(
              label: 'Start',
              icon: Icons.play_arrow,
              isPrimary: true,
              onPressed: () {
                HapticFeedback.mediumImpact();
                onStart();
              },
            ),
          ),

        // Spacing between buttons
        if ((_isIdle || state == 'COMPLETE') && (_isRunning || _isPaused))
          const SizedBox(width: 12),

        // Pause button - shown when RUNNING
        if (_isRunning)
          Expanded(
            child: GlassButton(
              label: 'Pause',
              icon: Icons.pause,
              onPressed: () {
                HapticFeedback.lightImpact();
                onPause();
              },
            ),
          ),

        // Resume button - shown when PAUSED
        if (_isPaused)
          Expanded(
            child: GlassButton(
              label: 'Resume',
              icon: Icons.play_arrow,
              isPrimary: true,
              onPressed: () {
                HapticFeedback.mediumImpact();
                onResume();
              },
            ),
          ),

        // Spacing before stop button
        if (_isRunning || _isPaused) const SizedBox(width: 12),

        // Stop button - shown when RUNNING or PAUSED
        if (_isRunning || _isPaused)
          Expanded(
            child: GlassButton(
              label: 'Stop',
              icon: Icons.stop,
              onPressed: () async {
                HapticFeedback.heavyImpact();
                final confirmed = await _showStopConfirmation(context);
                if (confirmed == true) {
                  onStop();
                }
              },
            ),
          ),
      ],
    );
  }

  Future<bool?> _showStopConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stop Device'),
        content: Text(
          'Are you sure you want to stop the $deviceType? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Stop'),
          ),
        ],
      ),
    );
  }
}
