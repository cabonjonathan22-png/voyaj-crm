import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../data/sync/local_entities.dart';
import '../../../design_system/design_system.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../crm_data.dart';
import '../widgets/record_form.dart';
import 'import_mapping.dart';
import 'import_runner.dart';

/// Ouvre l'assistant d'import CSV pour [entity] (organisations ou
/// contacts).
Future<void> showImportWizard(BuildContext context, CrmEntity entity) =>
    showVModal<void>(
      context,
      dismissible: false,
      builder: (_) => ImportWizard(entity: entity),
    );

/// Libellé d'une cible d'import.
String importTargetLabel(AppLocalizations l10n, String key) => switch (key) {
  'name' => l10n.orgName,
  'kind' => l10n.orgKind,
  'status' => l10n.orgStatus,
  'siren' => l10n.orgSiren,
  'siret' => l10n.orgSiret,
  'insee_code' => l10n.orgInsee,
  'population' => l10n.orgPopulation,
  'address' => l10n.orgAddress,
  'postal_code' => l10n.orgPostalCode,
  'city' => l10n.orgCity,
  'departement_code' => l10n.orgDepartement,
  'region_code' => l10n.orgRegion,
  'phone' => l10n.orgPhone,
  'email' => l10n.orgEmail,
  'website' => l10n.orgWebsite,
  'description' => l10n.orgDescription,
  'latitude' => l10n.orgLatitude,
  'longitude' => l10n.orgLongitude,
  'civility' => l10n.contactCivility,
  'first_name' => l10n.contactFirstName,
  'last_name' => l10n.contactLastName,
  'job_title' => l10n.contactJobTitle,
  'service' => l10n.contactService,
  'mobile' => l10n.contactMobile,
  'notes' => l10n.contactNotes,
  'do_not_contact' => l10n.contactDoNotContact,
  importTags => l10n.navTags,
  importOrganisation => l10n.contactOrganisation,
  _ => key,
};

String _problemLabel(AppLocalizations l10n, (ImportProblem, String) p) =>
    switch (p.$1) {
      ImportProblem.kind => l10n.importProblemKind(p.$2),
      ImportProblem.status => l10n.importProblemStatus(p.$2),
      ImportProblem.population => l10n.importProblemNumber(p.$2),
      ImportProblem.coordinate => l10n.importProblemNumber(p.$2),
    };

enum _Step { pick, map, importing, done }

class ImportWizard extends ConsumerStatefulWidget {
  const ImportWizard({super.key, required this.entity});

  final CrmEntity entity;

  @override
  ConsumerState<ImportWizard> createState() => _ImportWizardState();
}

class _ImportWizardState extends ConsumerState<ImportWizard> {
  _Step _step = _Step.pick;
  String? _fileName;
  CsvTable? _table;
  final Map<int, String> _mapping = {};
  bool _skipDuplicates = true;
  String _defaultKind = OrganisationKind.commune.key;
  String _defaultStatus = OrganisationStatus.aProspecter.key;
  int _progress = 0;
  ImportReport? _report;
  String? _error;

  bool get _isOrganisations => widget.entity == CrmEntity.organisations;

  List<CustomFieldRow> get _customFields =>
      ref.read(customFieldsForProvider(widget.entity));

  List<ImportTarget> get _targets => [
    ...(_isOrganisations ? organisationTargets : contactTargets),
    for (final f in _customFields) ImportTarget('custom.${f.key}'),
  ];

  String _targetLabel(String key) {
    if (key.startsWith('custom.')) {
      return _customFields
              .where((f) => 'custom.${f.key}' == key)
              .firstOrNull
              ?.label ??
          key;
    }
    return importTargetLabel(context.l10n, key);
  }

  Future<void> _pick() async {
    final file = await openFile(
      acceptedTypeGroups: const [
        XTypeGroup(label: 'CSV', extensions: ['csv', 'txt', 'tsv']),
      ],
    );
    if (file == null) return;
    final table = parseCsv(decodeText(await file.readAsBytes()));
    if (!mounted) return;
    if (table.headers.isEmpty || table.rows.isEmpty) {
      setState(() => _error = context.l10n.importEmptyFile);
      return;
    }
    _mapping.clear();
    final used = <String>{};
    for (final (i, header) in table.headers.indexed) {
      final target = guessTarget(header, _targets);
      if (target != null && used.add(target)) _mapping[i] = target;
    }
    setState(() {
      _fileName = file.name;
      _table = table;
      _error = null;
      _step = _Step.map;
    });
  }

  List<ImportedRow> _convert() {
    final customTypes = {for (final f in _customFields) f.key: f.type};
    return [
      for (final (i, cells) in _table!.rows.indexed)
        convertRow(
          widget.entity,
          cells,
          _mapping,
          line: i + 2,
          customTypes: customTypes,
        ),
    ];
  }

  ImportContext _context() {
    return ImportContext(
      existingKeys: _isOrganisations
          ? {
              for (final o
                  in ref.read(organisationsProvider).value ??
                      const <OrganisationRow>[])
                ...organisationDuplicateKeys(
                  rowToWire(SyncEntities.organisations, o),
                ),
            }
          : {
              for (final c
                  in ref.read(contactsProvider).value ?? const <ContactRow>[])
                ...contactDuplicateKeys(rowToWire(SyncEntities.contacts, c)),
            },
      tagsByName: {
        for (final t in ref.read(tagsProvider).value ?? const <Tag>[])
          normalizeName(t.name).isEmpty
                  ? searchText(t.name)
                  : normalizeName(t.name):
              t.id,
      },
      organisationsByName: {
        for (final o
            in ref.read(organisationsProvider).value ??
                const <OrganisationRow>[])
          normalizeName(o.name): o.id,
      },
    );
  }

  Future<void> _run() async {
    final rows = _convert();
    setState(() {
      _step = _Step.importing;
      _progress = 0;
    });
    final report = await runImport(
      ref.read(recordStoreProvider),
      entity: widget.entity,
      rows: rows,
      context: _context(),
      options: ImportOptions(
        source: context.l10n.importSource(_fileName ?? ''),
        skipDuplicates: _skipDuplicates,
        defaultKind: _defaultKind,
        defaultStatus: _defaultStatus,
        createMissingTags: ref.read(permissionProvider(Permission.tagWrite)),
        createMissingOrganisations: ref.read(
          permissionProvider(Permission.organisationWrite),
        ),
        ownerId: ref.read(currentUserProvider)?.id,
      ),
      onProgress: (done) {
        if (mounted) setState(() => _progress = done);
      },
    );
    if (mounted) {
      setState(() {
        _report = report;
        _step = _Step.done;
      });
    }
  }

  Widget _pickStep() {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.importPickHelp, style: context.text.body),
        const SizedBox(height: VSpace.x2),
        Text(
          [for (final t in _targets.take(8)) _targetLabel(t.key)].join(', '),
          style: context.text.small,
        ),
        if (_error != null) ...[
          const SizedBox(height: VSpace.x3),
          VBanner(message: _error!, tone: VTone.danger),
        ],
        const SizedBox(height: VSpace.x4),
        Center(
          child: VButton.primary(
            label: l10n.importChooseFile,
            icon: LucideIcons.fileSpreadsheet,
            onPressed: () => unawaited(_pick()),
          ),
        ),
      ],
    );
  }

  Widget _mapStep() {
    final l10n = context.l10n;
    final t = context.text;
    final c = context.colors;
    final table = _table!;
    final rows = _convert();
    final ctx = _context();
    final keysOf = _isOrganisations
        ? organisationDuplicateKeys
        : contactDuplicateKeys;
    final seen = {...ctx.existingKeys};
    var duplicates = 0;
    for (final row in rows) {
      final keys = keysOf(row.fields);
      if (keys.any(seen.contains)) duplicates++;
      seen.addAll(keys);
    }
    final problems = [
      for (final row in rows)
        for (final p in row.problems)
          l10n.importLine(row.line, _problemLabel(l10n, p)),
    ];
    final required = _isOrganisations ? 'name' : 'last_name';
    final hasRequired = _mapping.containsValue(required);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.importFileSummary(_fileName ?? '', table.rows.length),
          style: t.bodyStrong,
        ),
        const SizedBox(height: VSpace.x3),
        Text(l10n.importMappingHelp, style: t.small),
        const SizedBox(height: VSpace.x2),
        for (final (i, header) in table.headers.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: VSpace.x1_5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(header.isEmpty ? '—' : header, style: t.bodyStrong),
                      Text(
                        table.rows
                            .map((r) => r[i])
                            .where((v) => v.isNotEmpty)
                            .take(2)
                            .join(' · '),
                        overflow: TextOverflow.ellipsis,
                        style: t.small,
                      ),
                    ],
                  ),
                ),
                Icon(LucideIcons.arrowRight, size: 14, color: c.textSubtle),
                const SizedBox(width: VSpace.x2),
                VSelect<String?>(
                  value: _mapping[i],
                  width: 220,
                  options: [
                    VSelectOption(null, l10n.importIgnore),
                    for (final target in _targets)
                      if (_mapping[i] == target.key ||
                          !_mapping.containsValue(target.key))
                        VSelectOption(target.key, _targetLabel(target.key)),
                  ],
                  onChanged: (v) => setState(() {
                    if (v == null) {
                      _mapping.remove(i);
                    } else {
                      _mapping[i] = v;
                    }
                  }),
                ),
              ],
            ),
          ),
        const SizedBox(height: VSpace.x3),
        if (_isOrganisations)
          Row(
            children: [
              Expanded(
                child: VSelect<String>(
                  label: l10n.importDefaultKind,
                  value: _defaultKind,
                  width: double.infinity,
                  options: enumOptions(OrganisationKind.values),
                  onChanged: (v) => setState(() => _defaultKind = v),
                ),
              ),
              const SizedBox(width: VSpace.x3),
              Expanded(
                child: VSelect<String>(
                  label: l10n.importDefaultStatus,
                  value: _defaultStatus,
                  width: double.infinity,
                  options: enumOptions(OrganisationStatus.values),
                  onChanged: (v) => setState(() => _defaultStatus = v),
                ),
              ),
            ],
          ),
        const SizedBox(height: VSpace.x2),
        Row(
          children: [
            Checkbox(
              value: _skipDuplicates,
              onChanged: (v) => setState(() => _skipDuplicates = v ?? true),
            ),
            Expanded(
              child: Text(l10n.importSkipDuplicates(duplicates), style: t.body),
            ),
          ],
        ),
        if (!hasRequired) ...[
          const SizedBox(height: VSpace.x2),
          VBanner(
            message: l10n.importRequiredMissing(_targetLabel(required)),
            tone: VTone.warning,
          ),
        ],
        if (problems.isNotEmpty) ...[
          const SizedBox(height: VSpace.x2),
          VBanner(
            message: [
              l10n.importProblems(problems.length),
              ...problems.take(5),
            ].join('\n'),
            tone: VTone.warning,
          ),
        ],
        const SizedBox(height: VSpace.x2),
        Text(l10n.importRgpdNotice, style: t.small),
      ],
    );
  }

  Widget _doneStep() {
    final l10n = context.l10n;
    final report = _report!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        VBanner(
          message: l10n.importDone(report.created),
          tone: VTone.success,
          icon: LucideIcons.circleCheck,
        ),
        const SizedBox(height: VSpace.x3),
        VInfoRow(l10n.importDuplicatesSkipped, '${report.duplicates}'),
        if (report.organisationsCreated > 0)
          VInfoRow(
            l10n.importOrganisationsCreated,
            '${report.organisationsCreated}',
          ),
        if (report.tagsCreated > 0)
          VInfoRow(l10n.importTagsCreated, '${report.tagsCreated}'),
        VInfoRow(l10n.importRejected, '${report.rejected.length}'),
        for (final (line, message) in report.rejected.take(8))
          Text(l10n.importLine(line, message), style: context.text.small),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final total = _table?.rows.length ?? 0;
    final required = _isOrganisations ? 'name' : 'last_name';

    return VModal(
      title: _isOrganisations
          ? l10n.importTitleOrganisations
          : l10n.importTitleContacts,
      icon: LucideIcons.upload,
      width: 680,
      actions: switch (_step) {
        _Step.pick => [
          VButton(
            label: l10n.cancel,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        _Step.map => [
          VButton(
            label: l10n.importBack,
            onPressed: () => setState(() => _step = _Step.pick),
          ),
          VButton.primary(
            label: l10n.importRun(total),
            icon: LucideIcons.upload,
            onPressed: _mapping.containsValue(required)
                ? () => unawaited(_run())
                : null,
          ),
        ],
        _Step.importing => const [],
        _Step.done => [
          VButton.primary(
            label: l10n.close,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      },
      child: switch (_step) {
        _Step.pick => _pickStep(),
        _Step.map => _mapStep(),
        _Step.importing => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(
              value: total == 0 ? null : _progress / total,
            ),
            const SizedBox(height: VSpace.x3),
            Text(l10n.importProgress(_progress, total)),
          ],
        ),
        _Step.done => _doneStep(),
      },
    );
  }
}
