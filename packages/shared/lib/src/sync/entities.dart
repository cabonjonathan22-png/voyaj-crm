import '../auth/permission.dart';
import '../crm/enums.dart';
import '../crm/rules.dart';
import '../models/tag.dart';
import 'entity_schema.dart';

/// Registre des entités synchronisées entre clients et serveur.
///
/// Ajouter une entité : définir son schéma ici, créer sa table (migration
/// serveur + table Drift client) avec les colonnes de [SyncColumns] ; le
/// reste (push, pull, fusion, stockage local) est générique.
abstract final class SyncEntities {
  static const _text = FieldSpec(FieldType.text);
  static const _requiredText = FieldSpec(FieldType.text, nullable: false);
  static const _int = FieldSpec(FieldType.integer);
  static const _decimal = FieldSpec(FieldType.decimal);
  static const _bool = FieldSpec(FieldType.boolean);
  static const _dateTime = FieldSpec(FieldType.dateTime);
  static const _date = FieldSpec(FieldType.date);
  static const _json = FieldSpec(FieldType.json);

  /// Champs de traçabilité des données importées (RGPD : source et date de
  /// collecte).
  static const _provenance = {
    'source': _text,
    'source_ref': _text,
    'collected_at': _dateTime,
  };

  static final tags = EntitySchema(
    name: 'tags',
    fields: const {
      'name': _requiredText,
      'color': _requiredText,
      'description': _text,
    },
    readPermission: Permission.tagRead,
    writePermission: Permission.tagWrite,
    validate: validateTagRecord,
  );

  static final organisations = EntitySchema(
    name: 'organisations',
    fields: {
      'name': _requiredText,
      'kind': FieldSpec.oneOf(keysOf(OrganisationKind.values), nullable: false),
      'status': FieldSpec.oneOf(
        keysOf(OrganisationStatus.values),
        nullable: false,
      ),
      'siren': _text,
      'siret': _text,
      'insee_code': _text,
      'population': _int,
      'parent_id': _text,
      'departement_code': _text,
      'region_code': _text,
      'address': _text,
      'postal_code': _text,
      'city': _text,
      'latitude': _decimal,
      'longitude': _decimal,
      'phone': _text,
      'email': _text,
      'website': _text,
      'description': _text,
      'owner_id': _text,
      'custom_fields': _json,
      ..._provenance,
    },
    readPermission: Permission.organisationRead,
    writePermission: Permission.organisationWrite,
    validate: validateOrganisationRecord,
  );

  static final contacts = EntitySchema(
    name: 'contacts',
    fields: {
      'civility': _text,
      'first_name': _text,
      'last_name': _requiredText,
      'email': _text,
      'phone': _text,
      'mobile': _text,
      'organisation_id': _text,
      'job_title': _text,
      'service': FieldSpec.oneOf(keysOf(ContactService.values)),
      'notes': _text,
      'do_not_contact': _bool,
      'owner_id': _text,
      'custom_fields': _json,
      ..._provenance,
    },
    readPermission: Permission.contactRead,
    writePermission: Permission.contactWrite,
    validate: validateContactRecord,
  );

  /// Postes et mandats (historique) d'un contact dans une organisation.
  static final positions = EntitySchema(
    name: 'positions',
    fields: {
      'contact_id': _requiredText,
      'organisation_id': _requiredText,
      'job_title': _text,
      'service': FieldSpec.oneOf(keysOf(ContactService.values)),
      'is_elected': const FieldSpec(FieldType.boolean, nullable: false),
      'mandate_role': FieldSpec.oneOf(keysOf(MandateRole.values)),
      'delegation': _text,
      'start_date': _date,
      'end_date': _date,
      ..._provenance,
    },
    readPermission: Permission.contactRead,
    writePermission: Permission.contactWrite,
    validate: validatePositionRecord,
  );

  static final pipelines = EntitySchema(
    name: 'pipelines',
    fields: {
      'name': _requiredText,
      'kind': FieldSpec.oneOf(keysOf(PipelineKind.values), nullable: false),
      'sort_order': _decimal,
      'archived': _bool,
    },
    readPermission: Permission.dealRead,
    writePermission: Permission.pipelineManage,
    validate: validatePipelineRecord,
  );

  static final pipelineStages = EntitySchema(
    name: 'pipeline_stages',
    fields: {
      'pipeline_id': _requiredText,
      'name': _requiredText,
      'sort_order': _decimal,
      'probability': _int,
      'color': _text,
      'outcome': FieldSpec.oneOf(keysOf(StageOutcome.values), nullable: false),
    },
    readPermission: Permission.dealRead,
    writePermission: Permission.pipelineManage,
    validate: validateStageRecord,
  );

  static final deals = EntitySchema(
    name: 'deals',
    fields: {
      'title': _requiredText,
      'pipeline_id': _requiredText,
      'stage_id': _requiredText,
      'organisation_id': _text,
      'contact_id': _text,
      'amount_cents': _int,
      'probability': _int,
      'expected_close_date': _date,
      'status': FieldSpec.oneOf(keysOf(StageOutcome.values), nullable: false),
      'closed_at': _dateTime,
      'sort_order': _decimal,
      'owner_id': _text,
      'description': _text,
      'custom_fields': _json,
    },
    readPermission: Permission.dealRead,
    writePermission: Permission.dealWrite,
    validate: validateDealRecord,
  );

  static final activities = EntitySchema(
    name: 'activities',
    fields: {
      'kind': FieldSpec.oneOf(keysOf(ActivityKind.values), nullable: false),
      'subject': _requiredText,
      'body': _text,
      'organisation_id': _text,
      'contact_id': _text,
      'deal_id': _text,
      'starts_at': _dateTime,
      'ends_at': _dateTime,
      'due_at': _dateTime,
      'remind_at': _dateTime,
      'done_at': _dateTime,
      'assignee_id': _text,
      'owner_id': _text,
    },
    readPermission: Permission.activityRead,
    writePermission: Permission.activityWrite,
    validate: validateActivityRecord,
  );

  static final attachments = EntitySchema(
    name: 'attachments',
    fields: {
      'file_id': _requiredText,
      'file_name': _requiredText,
      'size': const FieldSpec(FieldType.integer, nullable: false),
      'mime_type': _text,
      'organisation_id': _text,
      'contact_id': _text,
      'deal_id': _text,
      'activity_id': _text,
    },
    readPermission: Permission.activityRead,
    writePermission: Permission.activityWrite,
    validate: validateAttachmentRecord,
  );

  /// Tags appliqués aux fiches (organisations, contacts, affaires).
  static final taggings = EntitySchema(
    name: 'taggings',
    fields: {
      'tag_id': _requiredText,
      'entity': FieldSpec.oneOf(keysOf(CrmEntity.values), nullable: false),
      'record_id': _requiredText,
    },
    readPermission: Permission.tagRead,
    writePermission: Permission.tagApply,
    validate: validateTaggingRecord,
  );

  static final customFields = EntitySchema(
    name: 'custom_fields',
    fields: {
      'entity': FieldSpec.oneOf(keysOf(CrmEntity.values), nullable: false),
      'key': _requiredText,
      'label': _requiredText,
      'type': FieldSpec.oneOf(keysOf(CustomFieldType.values), nullable: false),
      'options': _json,
      'sort_order': _decimal,
    },
    readPermission: Permission.organisationRead,
    writePermission: Permission.customFieldManage,
    validate: validateCustomFieldRecord,
  );

  /// Segments dynamiques partagés (filtres enregistrés).
  static final segments = EntitySchema(
    name: 'segments',
    fields: {
      'name': _requiredText,
      'entity': FieldSpec.oneOf(keysOf(CrmEntity.values), nullable: false),
      'description': _text,
      'config': const FieldSpec(FieldType.json, nullable: false),
    },
    readPermission: Permission.organisationRead,
    writePermission: Permission.segmentWrite,
    validate: validateSegmentRecord,
  );

  static final emailTemplates = EntitySchema(
    name: 'email_templates',
    fields: const {
      'name': _requiredText,
      'subject': _requiredText,
      'body': _requiredText,
      'description': _text,
    },
    readPermission: Permission.emailUse,
    writePermission: Permission.emailTemplateWrite,
    validate: validateEmailTemplateRecord,
  );

  /// Séquence : étapes `[{"delay_days": 3, "template_id": "…"}]`.
  static final emailSequences = EntitySchema(
    name: 'email_sequences',
    fields: const {
      'name': _requiredText,
      'description': _text,
      'steps': FieldSpec(FieldType.json, nullable: false),
      'active': _bool,
    },
    readPermission: Permission.emailUse,
    writePermission: Permission.emailTemplateWrite,
    validate: validateSequenceRecord,
  );

  /// Inscription d'un contact à une séquence ; les emails partent du
  /// compte de `owner_id` (envoyés par le serveur).
  static final sequenceEnrollments = EntitySchema(
    name: 'sequence_enrollments',
    fields: {
      'sequence_id': _requiredText,
      'contact_id': _requiredText,
      'owner_id': _requiredText,
      'step': const FieldSpec(FieldType.integer, nullable: false),
      'next_send_at': _dateTime,
      'status': FieldSpec.oneOf(
        keysOf(EnrollmentStatus.values),
        nullable: false,
      ),
      'last_error': _text,
    },
    readPermission: Permission.emailUse,
    writePermission: Permission.emailUse,
    validate: validateEnrollmentRecord,
  );

  static final products = EntitySchema(
    name: 'products',
    fields: const {
      'name': _requiredText,
      'description': _text,
      'unit_price_cents': _int,
      'vat_rate': _int,
      'unit': _text,
      'account_code': _text,
      'active': _bool,
    },
    readPermission: Permission.invoiceRead,
    writePermission: Permission.invoiceWrite,
    validate: validateProductRecord,
  );

  /// Champs d'un document attribués par le serveur à l'émission.
  static const invoiceServerFields = {
    'number',
    'issue_date',
    'vat_breakdown',
    'buyer',
    'seller',
    'pdf_file_id',
    'chorus_flux',
    'chorus_status',
  };

  /// Devis, factures et avoirs. Brouillons préparés hors ligne ;
  /// l'émission (numéro, totaux, PDF Factur-X) est faite par le serveur,
  /// après quoi seul l'état reste modifiable.
  static final invoices = EntitySchema(
    name: 'invoices',
    fields: {
      'kind': FieldSpec.oneOf(keysOf(DocumentKind.values), nullable: false),
      'status': FieldSpec.oneOf(keysOf(DocumentStatus.values), nullable: false),
      'number': _text,
      'subject': _text,
      'organisation_id': _text,
      'contact_id': _text,
      'deal_id': _text,
      'quote_id': _text,
      'original_invoice_id': _text,
      'issue_date': _date,
      'service_date': _date,
      'due_date': _date,
      'valid_until': _date,
      'lines': const FieldSpec(FieldType.json, nullable: false),
      'total_ht_cents': _int,
      'total_vat_cents': _int,
      'total_ttc_cents': _int,
      'vat_breakdown': _json,
      'buyer': _json,
      'seller': _json,
      'notes': _text,
      'payment_terms': _text,
      'buyer_reference': _text,
      'service_code': _text,
      'pdf_file_id': _text,
      'chorus_flux': _text,
      'chorus_status': _text,
      'sent_at': _dateTime,
      'owner_id': _text,
    },
    readPermission: Permission.invoiceRead,
    writePermission: Permission.invoiceWrite,
    validate: validateInvoiceRecord,
    serverFields: invoiceServerFields,
    lockedFields: (current) => current['number'] == null
        ? const {}
        : {
            for (final field in [
              'kind',
              'subject',
              'organisation_id',
              'contact_id',
              'deal_id',
              'quote_id',
              'original_invoice_id',
              'service_date',
              'due_date',
              'valid_until',
              'lines',
              'total_ht_cents',
              'total_vat_cents',
              'total_ttc_cents',
              'notes',
              'payment_terms',
              'buyer_reference',
              'service_code',
              SyncColumns.deletedAt,
            ])
              field,
          },
  );

  static final payments = EntitySchema(
    name: 'payments',
    fields: {
      'invoice_id': _requiredText,
      'amount_cents': const FieldSpec(FieldType.integer, nullable: false),
      'paid_on': _date,
      'method': FieldSpec.oneOf(keysOf(PaymentMethod.values)),
      'reference': _text,
      'notes': _text,
    },
    readPermission: Permission.invoiceRead,
    writePermission: Permission.invoiceWrite,
    validate: validatePaymentRecord,
  );

  static final List<EntitySchema> all = [
    tags,
    organisations,
    contacts,
    positions,
    pipelines,
    pipelineStages,
    deals,
    activities,
    attachments,
    taggings,
    customFields,
    segments,
    emailTemplates,
    emailSequences,
    sequenceEnrollments,
    products,
    invoices,
    payments,
  ];

  static final Map<String, EntitySchema> _byName = {
    for (final e in all) e.name: e,
  };

  static EntitySchema? byName(String name) => _byName[name];
}
