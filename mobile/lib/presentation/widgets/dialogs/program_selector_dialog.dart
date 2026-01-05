import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../data/models/device_info.dart';
import '../../providers/device_state_provider.dart';
import '../common/glass_card.dart';
import '../common/glass_button.dart';

/// Program template selector dialog for PCR
class ProgramSelectorDialog extends ConsumerStatefulWidget {
  final DeviceInfo device;

  const ProgramSelectorDialog({
    super.key,
    required this.device,
  });

  @override
  ConsumerState<ProgramSelectorDialog> createState() =>
      _ProgramSelectorDialogState();
}

class _ProgramSelectorDialogState extends ConsumerState<ProgramSelectorDialog> {
  List<Map<String, dynamic>>? _templates;
  bool _isLoading = true;
  String? _error;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final repository = ref.read(deviceRepositoryProvider(widget.device));
      final templates = await repository.getProgramTemplates();

      setState(() {
        _templates = templates.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select PCR Program',
                    style: AppTextStyles.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: _buildContent(),
            ),

            // Action buttons
            if (!_isLoading && _error == null && _selectedIndex != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: GlassButton(
                        label: 'Cancel',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GlassButton(
                        label: 'Start Program',
                        icon: Icons.play_arrow,
                        isPrimary: true,
                        onPressed: () {
                          final selected = _templates![_selectedIndex!];
                          Navigator.of(context).pop(selected);
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColorSchemes.error,
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed to load programs',
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              GlassButton(
                label: 'Retry',
                icon: Icons.refresh,
                onPressed: _loadTemplates,
              ),
            ],
          ),
        ),
      );
    }

    if (_templates == null || _templates!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.science_outlined,
                size: 64,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.3),
              ),
              const SizedBox(height: 16),
              const Text(
                'No Programs Available',
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'No PCR programs found on this device',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _templates!.length,
      itemBuilder: (context, index) {
        final template = _templates![index];
        final isSelected = _selectedIndex == index;

        return GlassCard(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: [
                // Selection indicator
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColorSchemes.pcrAccent
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.3),
                      width: 2,
                    ),
                    color: isSelected
                        ? AppColorSchemes.pcrAccent
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 16),

                // Program info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        template['name'] ?? 'Unnamed Program',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: isSelected ? AppColorSchemes.pcrAccent : null,
                        ),
                      ),
                      if (template['description'] != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          template['description'],
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (template['cycles'] != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.repeat,
                              size: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.5),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${template['cycles']} cycles',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
