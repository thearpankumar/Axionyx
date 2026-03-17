import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/models/pcr_profile.dart';
import '../../providers/pcr_profile_provider.dart';
import '../common/glass_card.dart';
import '../common/glass_button.dart';

/// Full-screen editor for creating or modifying a PCR program profile.
/// Opens as a modal route pushed over [ProgramSelectorDialog].
///
/// Pops with [Map<String,dynamic>] (start params) when the user taps
/// "Save & Start", or with null when they only save / cancel.
class PcrProgramEditor extends ConsumerStatefulWidget {
  /// null = create new profile; non-null = edit existing
  final PcrProfile? initialProfile;

  const PcrProgramEditor({super.key, this.initialProfile});

  @override
  ConsumerState<PcrProgramEditor> createState() => _PcrProgramEditorState();
}

class _PcrProgramEditorState extends ConsumerState<PcrProgramEditor> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _cyclesCtrl;
  late TextEditingController _initDenTempCtrl;
  late TextEditingController _initDenTimeCtrl;
  late TextEditingController _denTempCtrl;
  late TextEditingController _denTimeCtrl;
  // Standard mode
  late TextEditingController _annealTempCtrl;
  late TextEditingController _annealTimeCtrl;
  late TextEditingController _extendTempCtrl;
  late TextEditingController _extendTimeCtrl;
  // Two-step mode
  late TextEditingController _annealExtTempCtrl;
  late TextEditingController _annealExtTimeCtrl;

  late TextEditingController _finalExtTempCtrl;
  late TextEditingController _finalExtTimeCtrl;

  String _mode = 'standard';
  bool _isSaving = false;

  // Which tip is currently visible (null = none)
  String? _visibleTip;

  @override
  void initState() {
    super.initState();
    final p = widget.initialProfile;
    _mode = p?.mode ?? 'standard';
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _cyclesCtrl = TextEditingController(text: (p?.cycles ?? 35).toString());
    _initDenTempCtrl = TextEditingController(text: (p?.initialDenatureTemp ?? 95.0).toStringAsFixed(1));
    _initDenTimeCtrl = TextEditingController(text: (p?.initialDenatureTime ?? 180).toString());
    _denTempCtrl = TextEditingController(text: (p?.denatureTemp ?? 95.0).toStringAsFixed(1));
    _denTimeCtrl = TextEditingController(text: (p?.denatureTime ?? 30).toString());
    _annealTempCtrl = TextEditingController(text: (p?.annealTemp ?? 55.0).toStringAsFixed(1));
    _annealTimeCtrl = TextEditingController(text: (p?.annealTime ?? 30).toString());
    _extendTempCtrl = TextEditingController(text: (p?.extendTemp ?? 72.0).toStringAsFixed(1));
    _extendTimeCtrl = TextEditingController(text: (p?.extendTime ?? 60).toString());
    _annealExtTempCtrl = TextEditingController(text: (p?.annealExtendTemp ?? 68.0).toStringAsFixed(1));
    _annealExtTimeCtrl = TextEditingController(text: (p?.annealExtendTime ?? 30).toString());
    _finalExtTempCtrl = TextEditingController(text: (p?.finalExtendTemp ?? 72.0).toStringAsFixed(1));
    _finalExtTimeCtrl = TextEditingController(text: (p?.finalExtendTime ?? 300).toString());
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl, _cyclesCtrl, _initDenTempCtrl, _initDenTimeCtrl,
      _denTempCtrl, _denTimeCtrl, _annealTempCtrl, _annealTimeCtrl,
      _extendTempCtrl, _extendTimeCtrl, _annealExtTempCtrl, _annealExtTimeCtrl,
      _finalExtTempCtrl, _finalExtTimeCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  // ─── Temperature range helpers ──────────────────────────────────────────────

  static const double _tempMin = 37.0;
  static const double _tempMax = 110.0;

  Color _tempBorderColor(String phase, TextEditingController ctrl) {
    final val = double.tryParse(ctrl.text);
    if (val == null) return AppColorSchemes.error;
    if (val < _tempMin || val > _tempMax) return AppColorSchemes.error;
    switch (phase) {
      case 'denature':
        return (val >= 94 && val <= 98) ? AppColorSchemes.success : AppColorSchemes.warning;
      case 'anneal':
        return (val >= 45 && val <= 72) ? AppColorSchemes.success : AppColorSchemes.warning;
      case 'extend':
        return (val >= 68 && val <= 75) ? AppColorSchemes.success : AppColorSchemes.warning;
      case 'annealExtend':
        return (val >= 60 && val <= 75) ? AppColorSchemes.success : AppColorSchemes.warning;
      default:
        return AppColorSchemes.success;
    }
  }

  // ─── Tip content ─────────────────────────────────────────────────────────────

  static const Map<String, String> _tips = {
    'initDenTemp': 'Fully unwinds the DNA double helix before cycling begins. '
        '95°C for 2–5 min is standard. Lower temp may leave template partially double-stranded.',
    'initDenTime': 'Duration of initial denaturation. 180 s (3 min) works for most templates. '
        'GC-rich or long templates may need 300 s.',
    'cycles': '35 cycles is standard. Use 30 for abundant template, '
        '40 for low-copy or difficult templates. More cycles = higher risk of artefacts.',
    'denTemp': 'Separates DNA strands each cycle. 94–98°C for 15–30 s works for '
        'most templates. Higher temp helps denature GC-rich regions.',
    'denTime': 'Duration per denaturation step. 30 s is usually enough. '
        'Increase to 45–60 s for GC-rich templates.',
    'annealTemp': 'Temperature at which primers bind to the template. Typically '
        '5°C below the primer Tm. Lower = more product but less specific; '
        'higher = fewer but more specific bands.',
    'annealTime': 'Duration of annealing step. 30 s is sufficient for most primers. '
        'Longer primers (>25 nt) may benefit from 45–60 s.',
    'extendTemp': 'Temperature at which DNA polymerase synthesises the new strand. '
        '72°C is the Taq optimum. Allow ~1 min per 1 kb of expected product.',
    'extendTime': 'Duration of extension per cycle. Rule of thumb: 60 s per 1 kb for '
        'Taq, 30 s per 1 kb for high-fidelity polymerases.',
    'annealExtTemp': 'Combined annealing and extension temperature for Fast PCR (two-step). '
        '65–68°C works for most primer pairs and polymerases. Saves time vs. separate steps.',
    'annealExtTime': 'Duration of the combined anneal+extend step. '
        '30–45 s is typical for amplicons <500 bp.',
    'finalExtTemp': 'Temperature for final extension. 72°C ensures all partially '
        'extended strands are completed before the run ends.',
    'finalExtTime': '300 s (5 min) is standard. Use 600 s (10 min) for amplicons >1 kb.',
  };

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialProfile != null;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(isEdit),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      _buildNameAndMode(),
                      const SizedBox(height: 12),
                      _buildCyclesField(),
                      const SizedBox(height: 12),
                      _buildPhaseCard(
                        icon: Icons.thermostat,
                        title: 'Initial Denaturation',
                        color: AppColorSchemes.error,
                        tempCtrl: _initDenTempCtrl,
                        timeCtrl: _initDenTimeCtrl,
                        tempTipKey: 'initDenTemp',
                        timeTipKey: 'initDenTime',
                        tempPhase: 'denature',
                      ),
                      const SizedBox(height: 10),
                      _buildPhaseCard(
                        icon: Icons.local_fire_department,
                        title: 'Denaturation',
                        color: AppColorSchemes.error,
                        tempCtrl: _denTempCtrl,
                        timeCtrl: _denTimeCtrl,
                        tempTipKey: 'denTemp',
                        timeTipKey: 'denTime',
                        tempPhase: 'denature',
                        subtitle: 'Per cycle',
                      ),
                      const SizedBox(height: 10),
                      if (_mode == 'standard') ...[
                        _buildPhaseCard(
                          icon: Icons.blur_on,
                          title: 'Annealing',
                          color: AppColorSchemes.info,
                          tempCtrl: _annealTempCtrl,
                          timeCtrl: _annealTimeCtrl,
                          tempTipKey: 'annealTemp',
                          timeTipKey: 'annealTime',
                          tempPhase: 'anneal',
                          subtitle: 'Per cycle',
                        ),
                        const SizedBox(height: 10),
                        _buildPhaseCard(
                          icon: Icons.expand,
                          title: 'Extension',
                          color: AppColorSchemes.success,
                          tempCtrl: _extendTempCtrl,
                          timeCtrl: _extendTimeCtrl,
                          tempTipKey: 'extendTemp',
                          timeTipKey: 'extendTime',
                          tempPhase: 'extend',
                          subtitle: 'Per cycle',
                        ),
                      ] else ...[
                        _buildPhaseCard(
                          icon: Icons.fast_forward,
                          title: 'Anneal + Extend',
                          color: AppColorSchemes.warning,
                          tempCtrl: _annealExtTempCtrl,
                          timeCtrl: _annealExtTimeCtrl,
                          tempTipKey: 'annealExtTemp',
                          timeTipKey: 'annealExtTime',
                          tempPhase: 'annealExtend',
                          subtitle: 'Combined step, per cycle',
                        ),
                      ],
                      const SizedBox(height: 10),
                      _buildPhaseCard(
                        icon: Icons.done_all,
                        title: 'Final Extension',
                        color: AppColorSchemes.success,
                        tempCtrl: _finalExtTempCtrl,
                        timeCtrl: _finalExtTimeCtrl,
                        tempTipKey: 'finalExtTemp',
                        timeTipKey: 'finalExtTime',
                        tempPhase: 'extend',
                      ),
                      const SizedBox(height: 10),
                      // Hold phase is always 4°C - shown as info only
                      GlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Icon(Icons.ac_unit, color: Colors.blueAccent.shade100, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hold', style: AppTextStyles.bodyMedium),
                                  Text(
                                    '4°C — indefinite storage after program completes',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              _buildActionBar(),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader(bool isEdit) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Text(
              isEdit ? 'Edit Program' : 'New Program',
              style: AppTextStyles.titleLarge,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Name + Mode ─────────────────────────────────────────────────────────────

  Widget _buildNameAndMode() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Program Name',
              hintText: 'e.g. Colony PCR – 55°C anneal',
              prefixIcon: Icon(Icons.label_outline),
              border: OutlineInputBorder(),
            ),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          Text('Mode', style: AppTextStyles.bodySmall.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          )),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'standard',
                label: Text('Standard  (3-step)'),
                icon: Icon(Icons.looks_3_outlined, size: 18),
              ),
              ButtonSegment(
                value: 'twostep',
                label: Text('Fast  (2-step)'),
                icon: Icon(Icons.bolt, size: 18),
              ),
            ],
            selected: {_mode},
            onSelectionChanged: (sel) => setState(() {
              _mode = sel.first;
              _visibleTip = null;
            }),
          ),
        ],
      ),
    );
  }

  // ─── Cycles ──────────────────────────────────────────────────────────────────

  Widget _buildCyclesField() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.repeat, size: 20, color: AppColorSchemes.pcrAccent),
              const SizedBox(width: 8),
              const Text('Cycles', style: AppTextStyles.titleMedium),
              const Spacer(),
              _tipButton('cycles'),
            ],
          ),
          _tipExpansion('cycles'),
          const SizedBox(height: 12),
          TextFormField(
            controller: _cyclesCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Number of cycles',
              hintText: '35',
              border: OutlineInputBorder(),
              suffixText: 'cycles',
            ),
            validator: (v) {
              final n = int.tryParse(v ?? '');
              if (n == null || n < 1 || n > 100) return 'Must be 1–100';
              return null;
            },
          ),
        ],
      ),
    );
  }

  // ─── Phase card ──────────────────────────────────────────────────────────────

  Widget _buildPhaseCard({
    required IconData icon,
    required String title,
    required Color color,
    required TextEditingController tempCtrl,
    required TextEditingController timeCtrl,
    required String tempTipKey,
    required String timeTipKey,
    required String tempPhase,
    String? subtitle,
  }) {
    return StatefulBuilder(
      builder: (ctx, setLocal) {
        return GlassCard(
          padding: const EdgeInsets.all(16),
          border: Border.all(
            color: color.withValues(alpha: 0.25),
            width: 1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.titleMedium),
                        if (subtitle != null)
                          Text(subtitle, style: AppTextStyles.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                          )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Temperature field
              Row(
                children: [
                  Expanded(
                    child: _tempField(
                      ctrl: tempCtrl,
                      label: 'Temperature',
                      phase: tempPhase,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _tipButton(tempTipKey),
                ],
              ),
              _tipExpansion(tempTipKey),
              const SizedBox(height: 10),
              // Time field
              Row(
                children: [
                  Expanded(child: _timeField(ctrl: timeCtrl, label: 'Duration')),
                  const SizedBox(width: 6),
                  _tipButton(timeTipKey),
                ],
              ),
              _tipExpansion(timeTipKey),
            ],
          ),
        );
      },
    );
  }

  // ─── Temperature input ────────────────────────────────────────────────────────

  Widget _tempField({
    required TextEditingController ctrl,
    required String label,
    required String phase,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: ctrl,
      builder: (context, value, _) {
        final borderColor = _tempBorderColor(phase, ctrl);
        return TextFormField(
          controller: ctrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
          decoration: InputDecoration(
            labelText: label,
            suffixText: '°C',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
          ),
          validator: (v) {
            final t = double.tryParse(v ?? '');
            if (t == null) return 'Enter a number';
            if (t < _tempMin || t > _tempMax) return '$_tempMin–$_tempMax °C';
            return null;
          },
          onChanged: (_) => setState(() {}),
        );
      },
    );
  }

  // ─── Time input ───────────────────────────────────────────────────────────────

  Widget _timeField({
    required TextEditingController ctrl,
    required String label,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        suffixText: 's',
        border: const OutlineInputBorder(),
        helperText: ctrl.text.isNotEmpty
            ? _fmtSeconds(int.tryParse(ctrl.text) ?? 0)
            : null,
        helperStyle: AppTextStyles.bodySmall.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
      validator: (v) {
        final t = int.tryParse(v ?? '');
        if (t == null || t < 1) return 'Min 1 s';
        if (t > 3600) return 'Max 3600 s';
        return null;
      },
      onChanged: (_) => setState(() {}),
    );
  }

  String _fmtSeconds(int s) {
    if (s <= 0) return '';
    final m = s ~/ 60;
    final rem = s % 60;
    if (m == 0) return '${s}s';
    if (rem == 0) return '${m}m';
    return '${m}m ${rem}s';
  }

  // ─── Tip button + inline expansion ───────────────────────────────────────────

  Widget _tipButton(String key) {
    final isOpen = _visibleTip == key;
    return GestureDetector(
      onTap: () => setState(() => _visibleTip = isOpen ? null : key),
      child: Icon(
        isOpen ? Icons.info : Icons.info_outline,
        size: 20,
        color: isOpen
            ? AppColorSchemes.info
            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35),
      ),
    );
  }

  Widget _tipExpansion(String key) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: _visibleTip == key
          ? Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColorSchemes.info.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColorSchemes.info.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  _tips[key] ?? '',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // ─── Action bar ───────────────────────────────────────────────────────────────

  Widget _buildActionBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: GlassButton(
              label: 'Save Profile',
              icon: Icons.bookmark_outline,
              isLoading: _isSaving,
              onPressed: _onSave,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GlassButton(
              label: 'Save & Start',
              icon: Icons.play_arrow,
              isPrimary: true,
              isLoading: _isSaving,
              onPressed: _onSaveAndStart,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Actions ─────────────────────────────────────────────────────────────────

  PcrProfile? _buildProfile() {
    if (!_formKey.currentState!.validate()) return null;

    final existing = widget.initialProfile;
    final profile = PcrProfile(
      id: existing?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      mode: _mode,
      cycles: int.parse(_cyclesCtrl.text),
      initialDenatureTemp: double.parse(_initDenTempCtrl.text),
      initialDenatureTime: int.parse(_initDenTimeCtrl.text),
      denatureTemp: double.parse(_denTempCtrl.text),
      denatureTime: int.parse(_denTimeCtrl.text),
      annealTemp: _mode == 'standard' ? double.parse(_annealTempCtrl.text) : null,
      annealTime: _mode == 'standard' ? int.parse(_annealTimeCtrl.text) : null,
      extendTemp: _mode == 'standard' ? double.parse(_extendTempCtrl.text) : null,
      extendTime: _mode == 'standard' ? int.parse(_extendTimeCtrl.text) : null,
      annealExtendTemp: _mode == 'twostep' ? double.parse(_annealExtTempCtrl.text) : null,
      annealExtendTime: _mode == 'twostep' ? int.parse(_annealExtTimeCtrl.text) : null,
      finalExtendTemp: double.parse(_finalExtTempCtrl.text),
      finalExtendTime: int.parse(_finalExtTimeCtrl.text),
      createdAt: existing?.createdAt ?? DateTime.now(),
    );
    return profile;
  }

  Future<void> _onSave() async {
    final profile = _buildProfile();
    if (profile == null) return;
    setState(() => _isSaving = true);
    try {
      await ref.read(pcrProfilesProvider.notifier).saveProfile(profile);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${profile.name}" saved'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop(); // back to selector dialog
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _onSaveAndStart() async {
    final profile = _buildProfile();
    if (profile == null) return;
    setState(() => _isSaving = true);
    try {
      await ref.read(pcrProfilesProvider.notifier).saveProfile(profile);
      if (mounted) {
        // Pop the editor, then pop the selector dialog, returning start params
        Navigator.of(context).pop(profile.toStartParams());
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
