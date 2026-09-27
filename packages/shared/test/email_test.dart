import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  test('rendu des modèles : variables connues, absentes, espaces', () {
    expect(
      renderTemplate(
        'Bonjour {{contact.civility}} {{ contact.last_name }},\n'
        '{{organisation.name}} — {{inconnue}}',
        {'contact.civility': 'Mme', 'contact.last_name': 'Durand'},
      ),
      'Bonjour Mme Durand,\n — ',
    );
    expect(unknownVariables('{{contact.first_name}} {{contact.age}}'), {
      'contact.age',
    });
  });

  test('séquence : étapes valides', () {
    final template = newId();
    expect(
      validateSequenceRecord({
        'name': 'Relance collectivités',
        'steps': [
          {'delay_days': 0, 'template_id': template},
          {'delay_days': 7, 'template_id': template},
        ],
      }),
      isEmpty,
    );
    expect(
      validateSequenceRecord({
        'name': 'Vide',
        'steps': <Object?>[],
      }).single.field,
      'steps',
    );
    expect(
      validateSequenceRecord({
        'name': 'Délai',
        'steps': [
          {'delay_days': 400, 'template_id': template},
        ],
      }).single.field,
      'steps',
    );
  });

  test('inscription : statut énuméré', () {
    final spec = SyncEntities.sequenceEnrollments.fields['status']!;
    expect(spec.accepts('active'), isTrue);
    expect(spec.accepts('en_cours'), isFalse);
  });
}
