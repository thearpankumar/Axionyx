import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../data/models/device_info.dart';
import '../../../data/models/pcr_profile.dart';
import '../../providers/device_state_provider.dart';
import '../../providers/pcr_profile_provider.dart';
import '../common/glass_card.dart';
import '../common/glass_button.dart';
import 'pcr_program_editor.dart';

/// Tabbed PCR program selector.
///
/// Tab 0 — "My Programs": locally saved [PcrProfile] list.
/// Tab 1 — "Templates": firmware-provided templates fetched from device.
///
/// Pops with [Map<String,dynamic>] (start params) on selection, or null on cancel.
/// Keeps class name [ProgramSelectorDialog] so [pcr_detail_screen.dart] needs no changes.
class ProgramSelectorDialog extends ConsumerStatefulWidget {
  final DeviceInfo device;

  const ProgramSelectorDialog({super.key, required this.device});

  @override
  ConsumerState<ProgramSelectorDialog> createState() =>
      _ProgramSelectorDialogState();
}

class _ProgramSelectorDialogState extends ConsumerState<ProgramSelectorDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Templates tab state
  List<Map<String, dynamic>>? _templates;
  bool _templatesLoading = true;
  String? _templatesError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadTemplates();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTemplates() async {
    setState(() {
      _templatesLoading = true;
      _templatesError = null;
    });
    try {
      final repository = ref.read(deviceRepositoryProvider(widget.device));
      final templates = await repository.getProgramTemplates();
      setState(() {
        _templates = templates.cast<Map<String, dynamic>>();
        _templatesLoading = false;
      });
    } catch (e) {
      setState(() {
        _templatesError = e.toString();
        _templatesLoading = false;
      });
    }
  }

  // ─── Start from a profile ─────────────────────────────────────────────────

  void _startProfile(PcrProfile profile) {
    Navigator.of(context).pop(profile.toStartParams());
  }

  // ─── Start from a template map ────────────────────────────────────────────

  void _startTemplate(Map<String, dynamic> template) {
    Navigator.of(context).pop(template);
  }

  // ─── Open editor ─────────────────────────────────────────────────────────

  Future<void> _openEditor({PcrProfile? existing}) async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(
        builder: (_) => PcrProgramEditor(initialProfile: existing),
        fullscreenDialog: true,
      ),
    );
    // If editor returned start params (Save & Start), propagate up
    if (result != null && mounted) {
      Navigator.of(context).pop(result);
    }
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select PCR Program',
                      style: AppTextStyles.titleLarge,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Tabs
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'My Programs'),
                Tab(text: 'Templates'),
              ],
              indicatorColor: AppColorSchemes.pcrAccent,
              labelColor: AppColorSchemes.pcrAccent,
              unselectedLabelColor: null,
            ),
            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _MyProgramsTab(
                    onStart: _startProfile,
                    onEdit: (p) => _openEditor(existing: p),
                    onNew: () => _openEditor(),
                  ),
                  _TemplatesTab(
                    templates: _templates,
                    isLoading: _templatesLoading,
                    error: _templatesError,
                    onRetry: _loadTemplates,
                    onStart: _startTemplate,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// My Programs Tab
// ═════════════════════════════════════════════════════════════════════════════

class _MyProgramsTab extends ConsumerWidget {
  final void Function(PcrProfile) onStart;
  final void Function(PcrProfile) onEdit;
  final VoidCallback onNew;

  const _MyProgramsTab({
    required this.onStart,
    required this.onEdit,
    required this.onNew,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(pcrProfilesProvider);

    return profilesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'Error loading profiles: $e',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (profiles) {
        if (profiles.isEmpty) {
          return _EmptyProfiles(onNew: onNew);
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                itemCount: profiles.length,
                itemBuilder: (context, i) => _ProfileCard(
                  profile: profiles[i],
                  onStart: () => onStart(profiles[i]),
                  onEdit: () => onEdit(profiles[i]),
                  onDelete: () async {
                    await ref
                        .read(pcrProfilesProvider.notifier)
                        .deleteProfile(profiles[i].id);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SizedBox(
                width: double.infinity,
                child: GlassButton(
                  label: 'New Program',
                  icon: Icons.add,
                  onPressed: onNew,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmptyProfiles extends StatelessWidget {
  final VoidCallback onNew;
  const _EmptyProfiles({required this.onNew});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.science_outlined,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 16),
            const Text('No Saved Programs', style: AppTextStyles.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Create a custom program with your own temperatures and times.',
              style: AppTextStyles.bodySmall.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.55),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GlassButton(
              label: 'Create Program',
              icon: Icons.add,
              isPrimary: true,
              onPressed: onNew,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends ConsumerWidget {
  final PcrProfile profile;
  final VoidCallback onStart;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ProfileCard({
    required this.profile,
    required this.onStart,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTwoStep = profile.mode == 'twostep';
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      child: Row(
        children: [
          // Mode icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColorSchemes.pcrAccent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isTwoStep ? Icons.bolt : Icons.science,
              color: AppColorSchemes.pcrAccent,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.name, style: AppTextStyles.titleMedium),
                const SizedBox(height: 3),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    _badge(isTwoStep ? 'Fast PCR' : 'Standard PCR'),
                    _badge('${profile.cycles} cycles'),
                    _badge('Den ${profile.denatureTemp.toStringAsFixed(0)}°C'),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          // Quick start
          IconButton(
            icon: const Icon(
              Icons.play_circle_fill,
              color: AppColorSchemes.pcrAccent,
            ),
            onPressed: onStart,
            tooltip: 'Start',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            onSelected: (v) {
              if (v == 'start') onStart();
              if (v == 'edit') onEdit();
              if (v == 'delete') onDelete();
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'start', child: Text('Start')),
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Delete',
                  style: TextStyle(color: AppColorSchemes.error),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(String label) {
    return Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Templates Tab
// ═════════════════════════════════════════════════════════════════════════════

class _TemplatesTab extends StatelessWidget {
  final List<Map<String, dynamic>>? templates;
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;
  final void Function(Map<String, dynamic>) onStart;

  const _TemplatesTab({
    required this.templates,
    required this.isLoading,
    required this.error,
    required this.onRetry,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 56,
                color: AppColorSchemes.error,
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed to load templates',
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error!,
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              GlassButton(
                label: 'Retry',
                icon: Icons.refresh,
                onPressed: onRetry,
              ),
            ],
          ),
        ),
      );
    }

    if (templates == null || templates!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.science_outlined,
                size: 56,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.25),
              ),
              const SizedBox(height: 16),
              const Text(
                'No Templates Available',
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: templates!.length,
      itemBuilder: (context, i) {
        final t = templates![i];
        final isTwoStep = t['type'] == 'twostep';
        return GlassCard(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColorSchemes.pcrAccent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isTwoStep ? Icons.bolt : Icons.science,
                  color: AppColorSchemes.pcrAccent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t['name'] ?? 'Unnamed',
                      style: AppTextStyles.titleMedium,
                    ),
                    if (t['description'] != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        t['description'],
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.55),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (t['cycles'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${t['cycles']} cycles',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.45),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.play_circle_fill,
                  color: AppColorSchemes.pcrAccent,
                ),
                onPressed: () => onStart(t),
                tooltip: 'Start',
              ),
            ],
          ),
        );
      },
    );
  }
}
