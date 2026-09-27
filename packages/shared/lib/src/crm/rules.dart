/// Règles de validation des entités du CRM (enregistrement complet, clés
/// snake_case). Utilisées par le client avant écriture et par le serveur
/// après fusion.
library;

import '../ids.dart';
import '../validation/validation.dart';
import 'enums.dart';

final _digits9 = RegExp(r'^\d{9}$');
final _digits14 = RegExp(r'^\d{14}$');
final _insee = RegExp(r'^(\d{5}|2[AB]\d{3})$');
final _postalCode = RegExp(r'^\d{5}$');
final _deptCode = RegExp(r'^(\d{2,3}|2[AB])$');
final _url = RegExp(r'^https?://\S+\.\S+$');
final _hexColor = RegExp(r'^#[0-9a-fA-F]{6}$');
final _sha256 = RegExp(r'^[0-9a-f]{64}$');
final _fieldKey = RegExp(r'^[a-z][a-z0-9_]{0,39}$');

ValidationIssue _issue(String field, String code, String message) =>
    ValidationIssue(field: field, code: code, message: message);

ValidationIssue? _pattern(
  String field,
  Object? value,
  RegExp pattern,
  String message,
) {
  if (value == null || (value is String && value.isEmpty)) return null;
  if (value is String && pattern.hasMatch(value)) return null;
  return _issue(field, ValidationCodes.invalidFormat, message);
}

ValidationIssue? _range(
  String field,
  Object? value,
  num min,
  num max,
  String label,
) {
  if (value == null) return null;
  if (value is num && value >= min && value <= max) return null;
  return _issue(
    field,
    ValidationCodes.invalidFormat,
    '$label doit être compris entre $min et $max.',
  );
}

ValidationIssue? _optionalEmail(String field, Object? value) =>
    value == null || (value is String && value.isEmpty)
    ? null
    : validateEmail(field, value);

ValidationIssue? _optionalId(String field, Object? value, String label) {
  if (value == null) return null;
  if (value is String && isValidId(value)) return null;
  return _issue(field, ValidationCodes.invalidFormat, '$label invalide.');
}

ValidationIssue? _requiredId(String field, Object? value, String label) =>
    value == null
    ? _issue(field, ValidationCodes.required, '$label est obligatoire.')
    : _optionalId(field, value, label);

ValidationIssue? _dateOrder(
  String field,
  Object? start,
  Object? end,
  String message,
) {
  if (start is! String || end is! String) return null;
  final s = DateTime.tryParse(start);
  final e = DateTime.tryParse(end);
  if (s == null || e == null || !e.isBefore(s)) return null;
  return _issue(field, ValidationCodes.invalidFormat, message);
}

List<ValidationIssue> validateOrganisationRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText('name', r['name'], label: 'Le nom', max: 200),
      _pattern('siren', r['siren'], _digits9, 'Le SIREN compte 9 chiffres.'),
      _pattern('siret', r['siret'], _digits14, 'Le SIRET compte 14 chiffres.'),
      _pattern(
        'insee_code',
        r['insee_code'],
        _insee,
        'Code INSEE invalide (5 caractères).',
      ),
      _pattern(
        'postal_code',
        r['postal_code'],
        _postalCode,
        'Le code postal compte 5 chiffres.',
      ),
      _pattern(
        'departement_code',
        r['departement_code'],
        _deptCode,
        'Code de département invalide.',
      ),
      _range('population', r['population'], 0, 100000000, 'La population'),
      _range('latitude', r['latitude'], -90, 90, 'La latitude'),
      _range('longitude', r['longitude'], -180, 180, 'La longitude'),
      _optionalEmail('email', r['email']),
      _pattern(
        'website',
        r['website'],
        _url,
        "L'adresse du site doit commencer par http:// ou https://.",
      ),
      _optionalId('parent_id', r['parent_id'], 'Organisation parente'),
      if (r['parent_id'] != null && r['parent_id'] == r['id'])
        _issue(
          'parent_id',
          ValidationCodes.invalidFormat,
          'Une organisation ne peut pas être sa propre parente.',
        ),
      validateOptionalText(
        'description',
        r['description'],
        label: 'La description',
        max: 10000,
      ),
    ]);

List<ValidationIssue> validateContactRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText(
        'last_name',
        r['last_name'],
        label: 'Le nom',
        max: 120,
      ),
      validateOptionalText(
        'first_name',
        r['first_name'],
        label: 'Le prénom',
        max: 120,
      ),
      _optionalEmail('email', r['email']),
      _optionalId('organisation_id', r['organisation_id'], 'Organisation'),
      validateOptionalText('notes', r['notes'], label: 'Les notes', max: 10000),
    ]);

List<ValidationIssue> validatePositionRecord(Map<String, Object?> r) =>
    collectIssues([
      _requiredId('contact_id', r['contact_id'], 'Le contact'),
      _requiredId('organisation_id', r['organisation_id'], "L'organisation"),
      if (r['is_elected'] == true && r['mandate_role'] == null)
        _issue(
          'mandate_role',
          ValidationCodes.required,
          'La fonction élective est obligatoire pour un mandat.',
        ),
      _dateOrder(
        'end_date',
        r['start_date'],
        r['end_date'],
        'La date de fin doit suivre la date de début.',
      ),
    ]);

List<ValidationIssue> validatePipelineRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText('name', r['name'], label: 'Le nom', max: 80),
    ]);

List<ValidationIssue> validateStageRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText('name', r['name'], label: 'Le nom', max: 60),
      _requiredId('pipeline_id', r['pipeline_id'], 'Le pipeline'),
      _range('probability', r['probability'], 0, 100, 'La probabilité'),
      _pattern(
        'color',
        r['color'],
        _hexColor,
        'La couleur doit être au format #RRGGBB.',
      ),
    ]);

List<ValidationIssue> validateDealRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText('title', r['title'], label: "L'intitulé", max: 200),
      _requiredId('pipeline_id', r['pipeline_id'], 'Le pipeline'),
      _requiredId('stage_id', r['stage_id'], "L'étape"),
      _optionalId('organisation_id', r['organisation_id'], 'Organisation'),
      _optionalId('contact_id', r['contact_id'], 'Contact'),
      _range('amount_cents', r['amount_cents'], 0, 1e13, 'Le montant'),
      _range('probability', r['probability'], 0, 100, 'La probabilité'),
    ]);

List<ValidationIssue> validateActivityRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText('subject', r['subject'], label: "L'objet", max: 300),
      validateOptionalText('body', r['body'], label: 'Le contenu', max: 50000),
      _optionalId('organisation_id', r['organisation_id'], 'Organisation'),
      _optionalId('contact_id', r['contact_id'], 'Contact'),
      _optionalId('deal_id', r['deal_id'], 'Affaire'),
      _dateOrder(
        'ends_at',
        r['starts_at'],
        r['ends_at'],
        'La fin doit suivre le début.',
      ),
    ]);

List<ValidationIssue> validateAttachmentRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText(
        'file_name',
        r['file_name'],
        label: 'Le nom du fichier',
        max: 255,
      ),
      _pattern('file_id', r['file_id'], _sha256, 'Fichier invalide.'),
      _range('size', r['size'], 0, 1e10, 'La taille'),
    ]);

List<ValidationIssue> validateTaggingRecord(Map<String, Object?> r) =>
    collectIssues([
      _requiredId('tag_id', r['tag_id'], 'Le tag'),
      _requiredId('record_id', r['record_id'], "L'élément"),
    ]);

List<ValidationIssue> validateCustomFieldRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText('label', r['label'], label: 'Le libellé', max: 80),
      if (r['key'] is! String || !_fieldKey.hasMatch(r['key']! as String))
        _issue(
          'key',
          ValidationCodes.invalidFormat,
          'Identifiant : lettres minuscules, chiffres et _ (40 max).',
        ),
      if (r['type'] == CustomFieldType.select.key &&
          (r['options'] is! List || (r['options']! as List).isEmpty))
        _issue(
          'options',
          ValidationCodes.required,
          'Une liste de choix doit avoir au moins une option.',
        ),
    ]);

List<ValidationIssue> validateSegmentRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText('name', r['name'], label: 'Le nom', max: 120),
    ]);

List<ValidationIssue> validateEmailTemplateRecord(Map<String, Object?> r) =>
    collectIssues([
      validateRequiredText('name', r['name'], label: 'Le nom', max: 120),
      validateRequiredText('subject', r['subject'], label: "L'objet", max: 250),
      validateRequiredText('body', r['body'], label: 'Le message', max: 50000),
    ]);

List<ValidationIssue> validateSequenceRecord(Map<String, Object?> r) {
  final steps = r['steps'];
  return collectIssues([
    validateRequiredText('name', r['name'], label: 'Le nom', max: 120),
    if (steps is! List || steps.isEmpty)
      _issue('steps', ValidationCodes.required, 'Ajoutez au moins une étape.')
    else if (!steps.every(
      (s) =>
          s is Map &&
          s['delay_days'] is int &&
          (s['delay_days'] as int) >= 0 &&
          (s['delay_days'] as int) <= 365 &&
          s['template_id'] is String &&
          isValidId(s['template_id'] as String),
    ))
      _issue(
        'steps',
        ValidationCodes.invalidFormat,
        'Chaque étape indique un délai (0 à 365 jours) et un modèle.',
      ),
  ]);
}

List<ValidationIssue> validateEnrollmentRecord(Map<String, Object?> r) =>
    collectIssues([
      _requiredId('sequence_id', r['sequence_id'], 'La séquence'),
      _requiredId('contact_id', r['contact_id'], 'Le contact'),
      _requiredId('owner_id', r['owner_id'], "L'expéditeur"),
      _range('step', r['step'], 0, 1000, "L'étape"),
    ]);
