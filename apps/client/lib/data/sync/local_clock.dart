import 'package:voyaj_shared/voyaj_shared.dart';

import '../local/database.dart';

/// Identité du poste et horloge HLC persistée (les horodatages restent
/// croissants même après un redémarrage ou un recul de l'horloge système).
final class LocalClock {
  LocalClock._(this._db, this.deviceId, this._clock);

  static Future<LocalClock> load(AppDatabase db) async {
    var deviceId = await db.readSetting<String>(SettingKeys.deviceId);
    if (deviceId == null) {
      deviceId = newId();
      await db.writeSetting(SettingKeys.deviceId, deviceId);
    }
    final saved = await db.readSetting<String>(SettingKeys.hlc);
    final clock = HybridClock(
      deviceId,
      last: saved == null ? null : Hlc.parse(saved),
    );
    return LocalClock._(db, deviceId, clock);
  }

  final AppDatabase _db;
  final String deviceId;
  final HybridClock _clock;

  /// Horodatage d'une écriture locale (à appeler dans la transaction qui
  /// écrit l'opération).
  Future<Hlc> tick() async {
    final hlc = _clock.now();
    await _db.writeSetting(SettingKeys.hlc, hlc.toString());
    return hlc;
  }

  /// Intègre les horloges reçues du serveur.
  void observe(Iterable<String> hlcs) {
    for (final text in hlcs) {
      try {
        _clock.observe(Hlc.parse(text));
      } on ClockDriftException {
        // Horloge distante aberrante : ignorée (le serveur l'a déjà filtrée).
      } on FormatException {
        // Valeur invalide : ignorée.
      }
    }
  }
}
