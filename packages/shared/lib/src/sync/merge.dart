import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'field_stamp.dart';
import 'hlc.dart';

const _equality = DeepCollectionEquality();

/// Conflit détecté sur un champ : deux écritures concurrentes (aucune n'avait
/// vu l'autre) avec des valeurs différentes. La plus récente (HLC) gagne ;
/// le conflit est journalisé pour pouvoir être consulté et corrigé.
@immutable
final class FieldConflict {
  const FieldConflict({
    required this.field,
    required this.winningValue,
    required this.losingValue,
    required this.winningHlc,
    required this.losingHlc,
    required this.winnerUserId,
    required this.loserUserId,
    required this.incomingWon,
  });

  final String field;
  final Object? winningValue;
  final Object? losingValue;
  final String winningHlc;
  final String losingHlc;
  final String? winnerUserId;
  final String? loserUserId;

  /// `true` si l'écriture entrante a gagné (elle a écrasé une écriture
  /// concurrente), `false` si elle a été rejetée.
  final bool incomingWon;
}

/// Résultat de la fusion d'une opération entrante dans un enregistrement.
@immutable
final class MergeResult {
  const MergeResult({
    required this.applied,
    required this.stamps,
    required this.rejectedFields,
    required this.conflicts,
  });

  /// Champs effectivement modifiés, avec leur nouvelle valeur.
  final Map<String, Object?> applied;

  /// Métadonnées complètes après fusion (à persister dans `field_meta`).
  final Map<String, FieldStamp> stamps;

  /// Champs ignorés car une écriture plus récente existe déjà.
  final List<String> rejectedFields;

  final List<FieldConflict> conflicts;

  bool get changed => applied.isNotEmpty;
}

/// Fusion « last-write-wins » champ par champ.
///
/// - [current] : valeurs actuelles des champs synchronisés (vide si création).
/// - [stamps] : métadonnées actuelles par champ.
/// - [incoming] : champs modifiés par l'opération.
/// - [hlc] : horodatage HLC de l'opération.
/// - [baseVersion] : version de l'enregistrement connue par l'émetteur au
///   moment de l'écriture (0 pour une création).
/// - [nextVersion] : version qui sera attribuée si un champ est appliqué.
///
/// Un champ entrant est appliqué si son HLC est plus récent que celui de la
/// dernière écriture du champ. Il y a conflit si la dernière écriture est
/// concurrente (version > [baseVersion]) et que les valeurs diffèrent.
MergeResult mergeFields({
  required Map<String, Object?> current,
  required Map<String, FieldStamp> stamps,
  required Map<String, Object?> incoming,
  required Hlc hlc,
  required int baseVersion,
  required int nextVersion,
  required String? userId,
}) {
  final applied = <String, Object?>{};
  final newStamps = Map<String, FieldStamp>.of(stamps);
  final rejected = <String>[];
  final conflicts = <FieldConflict>[];
  final hlcText = hlc.toString();

  for (final MapEntry(key: field, value: value) in incoming.entries) {
    final stamp = stamps[field];
    final currentValue = current[field];
    final sameValue = _equality.equals(currentValue, value);

    if (stamp == null) {
      if (!sameValue || !current.containsKey(field)) {
        applied[field] = value;
        newStamps[field] = FieldStamp(
          hlc: hlcText,
          version: nextVersion,
          userId: userId,
        );
      }
      continue;
    }

    final stored = Hlc.parse(stamp.hlc);
    final concurrent = stamp.version > baseVersion;

    if (hlc > stored) {
      if (sameValue) continue;
      applied[field] = value;
      newStamps[field] = FieldStamp(
        hlc: hlcText,
        version: nextVersion,
        userId: userId,
      );
      if (concurrent) {
        conflicts.add(
          FieldConflict(
            field: field,
            winningValue: value,
            losingValue: currentValue,
            winningHlc: hlcText,
            losingHlc: stamp.hlc,
            winnerUserId: userId,
            loserUserId: stamp.userId,
            incomingWon: true,
          ),
        );
      }
    } else {
      if (sameValue) continue;
      rejected.add(field);
      conflicts.add(
        FieldConflict(
          field: field,
          winningValue: currentValue,
          losingValue: value,
          winningHlc: stamp.hlc,
          losingHlc: hlcText,
          winnerUserId: stamp.userId,
          loserUserId: userId,
          incomingWon: false,
        ),
      );
    }
  }

  return MergeResult(
    applied: applied,
    stamps: newStamps,
    rejectedFields: rejected,
    conflicts: conflicts,
  );
}
