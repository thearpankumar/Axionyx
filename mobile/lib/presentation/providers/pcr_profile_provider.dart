import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/pcr_profile.dart';
import '../../services/pcr_profile_service.dart';

final pcrProfileServiceProvider = Provider<PcrProfileService>(
  (_) => PcrProfileService(),
);

class PcrProfilesNotifier extends AsyncNotifier<List<PcrProfile>> {
  @override
  Future<List<PcrProfile>> build() async {
    return ref.read(pcrProfileServiceProvider).loadProfiles();
  }

  Future<void> saveProfile(PcrProfile profile) async {
    await ref.read(pcrProfileServiceProvider).saveProfile(profile);
    ref.invalidateSelf();
  }

  Future<void> deleteProfile(String id) async {
    await ref.read(pcrProfileServiceProvider).deleteProfile(id);
    ref.invalidateSelf();
  }
}

final pcrProfilesProvider =
    AsyncNotifierProvider<PcrProfilesNotifier, List<PcrProfile>>(
      PcrProfilesNotifier.new,
    );
