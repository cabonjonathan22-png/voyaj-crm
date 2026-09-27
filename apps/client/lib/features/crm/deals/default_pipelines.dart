import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../data/records/record_store.dart';

typedef _Stage = (String name, int probability, StageOutcome outcome);

const _collectivites = <_Stage>[
  ('Identifiée', 10, StageOutcome.open),
  ('Premier contact', 20, StageOutcome.open),
  ('Rendez-vous / présentation', 40, StageOutcome.open),
  ('Proposition envoyée', 60, StageOutcome.open),
  ('Négociation', 80, StageOutcome.open),
  ('Gagnée', 100, StageOutcome.won),
  ('Perdue', 0, StageOutcome.lost),
];

const _festivals = <_Stage>[
  ('À contacter', 10, StageOutcome.open),
  ('Contacté', 25, StageOutcome.open),
  ('Proposition', 50, StageOutcome.open),
  ('Négociation', 75, StageOutcome.open),
  ('Signé', 100, StageOutcome.won),
  ('Perdu', 0, StageOutcome.lost),
];

const _stageColors = [
  '#64748B',
  '#0EA5E9',
  '#6366F1',
  '#A855F7',
  '#F59E0B',
  '#22C55E',
  '#EF4444',
];

/// Couleur par défaut de la n-ième étape.
String stageColor(int index, StageOutcome outcome) => switch (outcome) {
  StageOutcome.won => '#22C55E',
  StageOutcome.lost => '#EF4444',
  StageOutcome.open => _stageColors[index % 5],
};

/// Crée les pipelines « Collectivités » et « Festivals » et leurs étapes.
/// Retourne l'identifiant du premier pipeline.
Future<String> createDefaultPipelines(RecordStore store) =>
    store.write((w) async {
      String? first;
      for (final (i, (name, kind, stages)) in [
        ('Collectivités', PipelineKind.collectivites, _collectivites),
        ('Festivals', PipelineKind.festivals, _festivals),
      ].indexed) {
        final pipeline = await w.create(SyncEntities.pipelines, {
          'name': name,
          'kind': kind.key,
          'sort_order': i.toDouble(),
        });
        first ??= pipeline;
        for (final (j, (stage, probability, outcome)) in stages.indexed) {
          await w.create(SyncEntities.pipelineStages, {
            'pipeline_id': pipeline,
            'name': stage,
            'sort_order': j.toDouble(),
            'probability': probability,
            'outcome': outcome.key,
            'color': stageColor(j, outcome),
          });
        }
      }
      return first!;
    });
