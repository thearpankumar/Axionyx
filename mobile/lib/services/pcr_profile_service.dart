import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/pcr_profile.dart';

/// Persists and retrieves PCR profiles using SharedPreferences.
/// Profiles are stored as a JSON-encoded list under [_key].
class PcrProfileService {
  static const String _key = 'pcr_profiles';

  Future<List<PcrProfile>> loadProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => PcrProfile.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveProfile(PcrProfile profile) async {
    final profiles = await loadProfiles();
    final idx = profiles.indexWhere((p) => p.id == profile.id);
    if (idx >= 0) {
      profiles[idx] = profile;
    } else {
      profiles.add(profile);
    }
    await _persist(profiles);
  }

  Future<void> deleteProfile(String id) async {
    final profiles = await loadProfiles();
    profiles.removeWhere((p) => p.id == id);
    await _persist(profiles);
  }

  Future<void> _persist(List<PcrProfile> profiles) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(profiles.map((p) => p.toJson()).toList());
    await prefs.setString(_key, encoded);
  }
}
