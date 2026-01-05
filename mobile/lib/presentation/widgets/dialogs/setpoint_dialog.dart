import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/text_styles.dart';

/// Setpoint adjustment dialog
class SetpointDialog extends StatefulWidget {
  final String label;
  final double currentValue;
  final double minValue;
  final double maxValue;
  final Color color;

  const SetpointDialog({
    super.key,
    required this.label,
    required this.currentValue,
    this.minValue = 0,
    this.maxValue = 100,
    this.color = Colors.blue,
  });

  @override
  State<SetpointDialog> createState() => _SetpointDialogState();
}

class _SetpointDialogState extends State<SetpointDialog> {
  late double _value;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _value = widget.currentValue;
    _controller = TextEditingController(
      text: _value.toStringAsFixed(1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set ${widget.label}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Large temperature display
          Text(
            '${_value.toStringAsFixed(1)}°C',
            style: AppTextStyles.getTemperatureStyle(fontSize: 48).copyWith(
              color: widget.color,
            ),
          ),
          const SizedBox(height: 24),

          // Slider
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: widget.color,
              thumbColor: widget.color,
              overlayColor: widget.color.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: _value,
              min: widget.minValue,
              max: widget.maxValue,
              divisions: ((widget.maxValue - widget.minValue) * 2).toInt(),
              label: '${_value.toStringAsFixed(1)}°C',
              onChanged: (value) {
                setState(() {
                  _value = value;
                  _controller.text = value.toStringAsFixed(1);
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Manual input
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              labelText: 'Enter value',
              suffixText: '°C',
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.color, width: 2),
              ),
            ),
            onChanged: (value) {
              final parsed = double.tryParse(value);
              if (parsed != null &&
                  parsed >= widget.minValue &&
                  parsed <= widget.maxValue) {
                setState(() {
                  _value = parsed;
                });
              }
            },
          ),
          const SizedBox(height: 8),

          // Range info
          Text(
            'Range: ${widget.minValue.toStringAsFixed(0)}°C - ${widget.maxValue.toStringAsFixed(0)}°C',
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_value),
          style: FilledButton.styleFrom(
            backgroundColor: widget.color,
          ),
          child: const Text('Set'),
        ),
      ],
    );
  }
}
