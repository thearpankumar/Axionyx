import 'package:freezed_annotation/freezed_annotation.dart';

part 'pcr_profile.freezed.dart';
part 'pcr_profile.g.dart';

/// A user-saved PCR program profile stored locally on the device.
/// Supports Standard (3-step) and Fast/Two-Step (2-step) modes.
@freezed
abstract class PcrProfile with _$PcrProfile {
  const PcrProfile._();

  const factory PcrProfile({
    required String id,
    required String name,

    /// 'standard' or 'twostep'
    required String mode,

    required int cycles,
    required double initialDenatureTemp,
    required int initialDenatureTime,
    required double denatureTemp,
    required int denatureTime,

    // Standard mode fields (null for twostep)
    double? annealTemp,
    int? annealTime,
    double? extendTemp,
    int? extendTime,

    // Two-step mode field (null for standard)
    double? annealExtendTemp,
    int? annealExtendTime,

    required double finalExtendTemp,
    required int finalExtendTime,

    required DateTime createdAt,
    @Default(false) bool isDefault,
  }) = _PcrProfile;

  factory PcrProfile.fromJson(Map<String, dynamic> json) =>
      _$PcrProfileFromJson(json);

  /// Returns the JSON map that the firmware start endpoint expects.
  Map<String, dynamic> toStartParams() {
    final params = <String, dynamic>{
      'name': name,
      'type': mode,
      'cycles': cycles,
      'initialDenatureTemp': initialDenatureTemp,
      'initialDenatureTime': initialDenatureTime,
      'denatureTemp': denatureTemp,
      'denatureTime': denatureTime,
      'finalExtendTemp': finalExtendTemp,
      'finalExtendTime': finalExtendTime,
    };

    if (mode == 'twostep') {
      if (annealExtendTemp != null) params['annealExtendTemp'] = annealExtendTemp;
      if (annealExtendTime != null) params['annealExtendTime'] = annealExtendTime;
      params['twoStepEnabled'] = true;
    } else {
      if (annealTemp != null) params['annealTemp'] = annealTemp;
      if (annealTime != null) params['annealTime'] = annealTime;
      if (extendTemp != null) params['extendTemp'] = extendTemp;
      if (extendTime != null) params['extendTime'] = extendTime;
    }

    return params;
  }

  /// Create a new profile with a generated ID from current timestamp.
  static PcrProfile create({
    required String name,
    required String mode,
    required int cycles,
    required double initialDenatureTemp,
    required int initialDenatureTime,
    required double denatureTemp,
    required int denatureTime,
    double? annealTemp,
    int? annealTime,
    double? extendTemp,
    int? extendTime,
    double? annealExtendTemp,
    int? annealExtendTime,
    required double finalExtendTemp,
    required int finalExtendTime,
  }) {
    return PcrProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      mode: mode,
      cycles: cycles,
      initialDenatureTemp: initialDenatureTemp,
      initialDenatureTime: initialDenatureTime,
      denatureTemp: denatureTemp,
      denatureTime: denatureTime,
      annealTemp: annealTemp,
      annealTime: annealTime,
      extendTemp: extendTemp,
      extendTime: extendTime,
      annealExtendTemp: annealExtendTemp,
      annealExtendTime: annealExtendTime,
      finalExtendTemp: finalExtendTemp,
      finalExtendTime: finalExtendTime,
      createdAt: DateTime.now(),
    );
  }
}
