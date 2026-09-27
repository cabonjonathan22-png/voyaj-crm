import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../design_system/design_system.dart';
import '../../l10n/generated/app_localizations.dart';
import 'connectors_data.dart';

/// Création ou modification d'un connecteur (source, secret, mappage,
/// planification) avec aperçu. Retourne `true` si enregistré.
Future<bool?> showConnectorEditor(
  BuildContext context, {
  ConnectorInfo? connector,
}) => showVModal<bool>(
  context,
  builder: (_) => _ConnectorEditor(connector: connector),
);

/// Option de configuration d'une source.
typedef _ConfigField = ({
  String key,
  String label,
  String? hint,
  int lines,
  bool integer,
});

_ConfigField _f(
  String key,
  String label, {
  String? hint,
  int lines = 1,
  bool integer = false,
}) => (key: key, label: label, hint: hint, lines: lines, integer: integer);

List<_ConfigField> _configFields(AppLocalizations l10n, ConnectorKind kind) =>
    switch (kind) {
      ConnectorKind.rest => [
        _f('url', l10n.connectorUrl, hint: 'https://api.exemple.fr/v1/clients'),
        _f('records_path', l10n.connectorRecordsPath, hint: 'data.items'),
        _f('auth_header', l10n.connectorAuthHeader, hint: 'Authorization'),
        _f('page_param', l10n.connectorPageParam, hint: 'page'),
        _f('next_path', l10n.connectorNextPath, hint: 'links.next'),
      ],
      ConnectorKind.supabase => [
        _f('url', l10n.connectorProjectUrl, hint: 'https://xxxx.supabase.co'),
        _f('table', l10n.connectorTable),
        _f('select', l10n.connectorSelect, hint: '*'),
        _f('filter', l10n.connectorFilter, hint: 'statut=eq.actif'),
        _f('order', l10n.connectorOrder, hint: 'id'),
      ],
      ConnectorKind.firebase => [
        _f('project_id', l10n.connectorProject),
        _f('collection', l10n.connectorCollection),
        _f('database', l10n.connectorDatabase, hint: '(default)'),
      ],
      ConnectorKind.mysql => [
        _f('host', l10n.connectorHost),
        _f('port', l10n.connectorPort, hint: '3306', integer: true),
        _f('database', l10n.connectorDatabase),
        _f('user', l10n.connectorUser),
        _f('query', l10n.connectorQuery, hint: 'SELECT …', lines: 4),
      ],
      ConnectorKind.mongodb => [
        _f('collection', l10n.connectorCollection),
        _f('filter', l10n.connectorMongoFilter, hint: '{"actif": true}'),
      ],
      ConnectorKind.webhook => [
        _f('records_path', l10n.connectorRecordsPath, hint: 'contacts'),
      ],
    };

String? _secretLabel(AppLocalizations l10n, ConnectorKind kind) =>
    switch (kind) {
      ConnectorKind.rest => l10n.connectorSecretRest,
      ConnectorKind.supabase => l10n.connectorSecretSupabase,
      ConnectorKind.firebase => l10n.connectorSecretFirebase,
      ConnectorKind.mysql => l10n.connectorSecretMysql,
      ConnectorKind.mongodb => l10n.connectorSecretMongo,
      ConnectorKind.webhook => null,
    };

/// Ligne de mappage en cours de saisie.
final class _Row {
  _Row({
    this.target,
    String source = '',
    this.transform = 'none',
    String constant = '',
  }) : source = TextEditingController(text: source),
       constant = TextEditingController(text: constant);

  factory _Row.from(FieldMapping m) => _Row(
    target: m.target,
    source: m.source ?? '',
    transform: m.transform,
    constant: m.constant == null ? '' : '${m.constant}',
  );

  String? target;
  final TextEditingController source;
  String transform;
  final TextEditingController constant;

  FieldMapping? toMapping() {
    if (target == null) return null;
    final path = source.text.trim();
    final fixed = constant.text.trim();
    return FieldMapping(
      target: target!,
      source: path.isEmpty ? null : path,
      transform: transform,
      constant: path.isEmpty && fixed.isNotEmpty ? fixed : null,
    );
  }

  void dispose() {
    source.dispose();
    constant.dispose();
  }
}

class _ConnectorEditor extends ConsumerStatefulWidget {
  const _ConnectorEditor({this.connector});

  final ConnectorInfo? connector;

  @override
  ConsumerState<_ConnectorEditor> createState() => _ConnectorEditorState();
}

class _ConnectorEditorState extends ConsumerState<_ConnectorEditor> {
  ConnectorInfo? get _c => widget.connector;

  late final _name = TextEditingController(text: _c?.name ?? '');
  late ConnectorKind _kind =
      enumByKey(ConnectorKind.values, _c?.kind ?? '') ?? ConnectorKind.rest;
  late bool _enabled = _c?.enabled ?? true;
  late int? _schedule = _c?.scheduleMinutes;
  late bool _secure = _c?.config['secure'] != false;
  final _secret = TextEditingController();
  final _config = <String, TextEditingController>{};
  late String _entity = _c?.mapping.entity ?? connectorEntities.first;
  late final _refPath = TextEditingController(
    text: _c?.mapping.refPath ?? 'id',
  );
  late String? _matchField = _c?.mapping.matchField;
  late final _lookupSource = TextEditingController(
    text: _c?.mapping.organisationLookup?.source ?? '',
  );
  late String _lookupField = _c?.mapping.organisationLookup?.field ?? 'siren';
  late final List<_Row> _rows = [
    for (final m in _c?.mapping.fields ?? const <FieldMapping>[]) _Row.from(m),
    if ((_c?.mapping.fields ?? const []).isEmpty) _Row(),
  ];
  ConnectorPreview? _preview;
  bool _previewing = false;
  bool _saving = false;
  Map<String, String> _errors = const {};

  @override
  void dispose() {
    for (final c in [
      _name,
      _secret,
      _refPath,
      _lookupSource,
      ..._config.values,
    ]) {
      c.dispose();
    }
    for (final r in _rows) {
      r.dispose();
    }
    super.dispose();
  }

  TextEditingController _configController(String key) =>
      _config.putIfAbsent(key, () {
        final value = _c?.config[key];
        return TextEditingController(text: value == null ? '' : '$value');
      });

  ConnectorInput _input() {
    final l10n = context.l10n;
    final config = <String, Object?>{};
    for (final field in _configFields(l10n, _kind)) {
      final text = _configController(field.key).text.trim();
      if (text.isEmpty) continue;
      config[field.key] = field.integer ? int.tryParse(text) ?? text : text;
    }
    if (_kind == ConnectorKind.mysql) config['secure'] = _secure;
    final secret = _secret.text.trim();
    return ConnectorInput(
      name: _name.text,
      kind: _kind.key,
      config: config,
      enabled: _enabled,
      scheduleMinutes: _kind == ConnectorKind.webhook ? null : _schedule,
      secret: secret.isEmpty ? null : secret,
      mapping: ConnectorMapping(
        entity: _entity,
        refPath: _refPath.text.trim(),
        matchField: _matchField,
        organisationLookup:
            _entity == 'contacts' && _lookupSource.text.trim().isNotEmpty
            ? OrganisationLookup(
                source: _lookupSource.text.trim(),
                field: _lookupField,
              )
            : null,
        fields: _rows.map((r) => r.toMapping()).nonNulls.toList(),
      ),
    );
  }

  Future<void> _runPreview() async {
    final api = ref.read(connectorsApiProvider);
    if (api == null) return;
    setState(() => _previewing = true);
    try {
      final preview = await api.preview(_input(), id: _c?.id);
      if (mounted) setState(() => _preview = preview);
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    } finally {
      if (mounted) setState(() => _previewing = false);
    }
  }

  Future<void> _save() async {
    final api = ref.read(connectorsApiProvider);
    if (api == null) return;
    setState(() {
      _saving = true;
      _errors = const {};
    });
    try {
      await api.save(_c?.id, _input());
      if (mounted) Navigator.of(context).pop(true);
    } on ApiFailure catch (e) {
      if (!mounted) return;
      setState(() {
        _errors = {for (final i in e.issues) i.field: i.message};
        _saving = false;
      });
      if (e.issues.isEmpty) ref.read(toastProvider).error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final c = context.colors;
    final fields = mappableFields(_entity);
    final secretLabel = _secretLabel(l10n, _kind);

    Widget pair(Widget a, Widget b) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: a),
        const SizedBox(width: VSpace.x3),
        Expanded(child: b),
      ],
    );

    return VModal(
      title: _c == null ? l10n.connectorNew : l10n.connectorEdit,
      icon: LucideIcons.plug,
      width: 920,
      actions: [
        if (_kind != ConnectorKind.webhook)
          VButton(
            label: l10n.connectorPreview,
            icon: LucideIcons.eye,
            loading: _previewing,
            onPressed: () => unawaited(_runPreview()),
          ),
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(
          label: _c == null ? l10n.create : l10n.save,
          loading: _saving,
          onPressed: () => unawaited(_save()),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          pair(
            VTextField(
              controller: _name,
              label: l10n.connectorName,
              autofocus: _c == null,
              error: _errors['name'],
            ),
            VSelect<ConnectorKind>(
              label: l10n.connectorKind,
              value: _kind,
              width: double.infinity,
              options: [
                for (final k in ConnectorKind.values) VSelectOption(k, k.label),
              ],
              onChanged: (v) => setState(() {
                _kind = v;
                _preview = null;
              }),
            ),
          ),
          const SizedBox(height: VSpace.x3),
          Text(l10n.connectorSource, style: t.heading),
          const SizedBox(height: VSpace.x2),
          Wrap(
            spacing: VSpace.x3,
            runSpacing: VSpace.x3,
            children: [
              for (final field in _configFields(l10n, _kind))
                SizedBox(
                  width: field.lines > 1 ? 872 : 430,
                  child: VTextField(
                    controller: _configController(field.key),
                    label: field.label,
                    hint: field.hint,
                    maxLines: field.lines,
                    minLines: field.lines > 1 ? 2 : null,
                  ),
                ),
              if (secretLabel != null)
                SizedBox(
                  width: 430,
                  child: VTextField(
                    controller: _secret,
                    label: secretLabel,
                    hint: _c?.hasSecret == true ? l10n.secretUnchanged : null,
                    obscure: true,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _enabled,
                onChanged: (v) => setState(() => _enabled = v ?? true),
              ),
              Text(l10n.webhookEnabled, style: t.body),
            ],
          ),
          if (_kind == ConnectorKind.mysql)
            Row(
              children: [
                Checkbox(
                  value: _secure,
                  onChanged: (v) => setState(() => _secure = v ?? true),
                ),
                Text(l10n.connectorSecure, style: t.body),
              ],
            ),
          if (_kind == ConnectorKind.webhook) ...[
            const SizedBox(height: VSpace.x2),
            VBanner(
              icon: LucideIcons.webhook,
              message: l10n.connectorWebhookHelp,
            ),
          ],
          const SizedBox(height: VSpace.x4),
          Text(l10n.connectorMapping, style: t.heading),
          const SizedBox(height: VSpace.x2),
          pair(
            VSelect<String>(
              label: l10n.connectorEntity,
              value: _entity,
              width: double.infinity,
              options: [
                VSelectOption('organisations', l10n.navOrganisations),
                VSelectOption('contacts', l10n.navContacts),
              ],
              onChanged: (v) => setState(() {
                _entity = v;
                _matchField = null;
                for (final r in _rows) {
                  if (!mappableFields(v).contains(r.target)) r.target = null;
                }
              }),
            ),
            VTextField(
              controller: _refPath,
              label: l10n.connectorRefPath,
              helper: l10n.connectorRefPathHelp,
              error: _errors['mapping'],
            ),
          ),
          const SizedBox(height: VSpace.x3),
          pair(
            VSelect<String?>(
              label: l10n.connectorMatchField,
              value: _matchField,
              width: double.infinity,
              options: [
                VSelectOption(null, l10n.formNone),
                for (final f
                    in connectorMatchFields[_entity] ?? const <String>[])
                  VSelectOption(f, f),
              ],
              onChanged: (v) => setState(() => _matchField = v),
            ),
            VSelect<int?>(
              label: l10n.connectorSchedule,
              value: _schedule,
              width: double.infinity,
              options: [
                VSelectOption(null, l10n.connectorScheduleManual),
                VSelectOption(15, l10n.connectorEveryMinutes(15)),
                VSelectOption(60, l10n.connectorEveryHours(1)),
                VSelectOption(360, l10n.connectorEveryHours(6)),
                VSelectOption(1440, l10n.connectorEveryHours(24)),
              ],
              onChanged: _kind == ConnectorKind.webhook
                  ? null
                  : (v) => setState(() => _schedule = v),
            ),
          ),
          if (_entity == 'contacts') ...[
            const SizedBox(height: VSpace.x3),
            pair(
              VTextField(
                controller: _lookupSource,
                label: l10n.connectorLookupSource,
                helper: l10n.connectorLookupHelp,
              ),
              VSelect<String>(
                label: l10n.connectorLookupField,
                value: _lookupField,
                width: double.infinity,
                options: [
                  for (final f in [
                    'siren',
                    'siret',
                    'insee_code',
                    'name',
                    'email',
                  ])
                    VSelectOption(f, f),
                ],
                onChanged: (v) => setState(() => _lookupField = v),
              ),
            ),
          ],
          const SizedBox(height: VSpace.x3),
          Row(
            children: [
              Expanded(child: Text(l10n.connectorTarget, style: t.label)),
              const SizedBox(width: VSpace.x2),
              Expanded(child: Text(l10n.connectorSourcePath, style: t.label)),
              const SizedBox(width: VSpace.x2),
              SizedBox(
                width: 190,
                child: Text(l10n.connectorTransform, style: t.label),
              ),
              const SizedBox(width: VSpace.x2),
              SizedBox(
                width: 150,
                child: Text(l10n.connectorConstant, style: t.label),
              ),
              const SizedBox(width: 36),
            ],
          ),
          const SizedBox(height: VSpace.x1),
          for (final (i, row) in _rows.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: VSpace.x2),
              child: Row(
                children: [
                  Expanded(
                    child: VSelect<String?>(
                      value: row.target,
                      width: double.infinity,
                      placeholder: l10n.connectorChooseField,
                      options: [for (final f in fields) VSelectOption(f, f)],
                      onChanged: (v) => setState(() => row.target = v),
                    ),
                  ),
                  const SizedBox(width: VSpace.x2),
                  Expanded(
                    child: VTextField(
                      controller: row.source,
                      dense: true,
                      hint: 'adresse.ville',
                    ),
                  ),
                  const SizedBox(width: VSpace.x2),
                  VSelect<String>(
                    value: row.transform,
                    width: 190,
                    options: [
                      for (final tr in MappingTransform.values)
                        VSelectOption(tr.key, tr.label),
                    ],
                    onChanged: (v) => setState(() => row.transform = v),
                  ),
                  const SizedBox(width: VSpace.x2),
                  SizedBox(
                    width: 150,
                    child: VTextField(controller: row.constant, dense: true),
                  ),
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    size: VButtonSize.sm,
                    onPressed: _rows.length == 1
                        ? null
                        : () => setState(() => _rows.removeAt(i).dispose()),
                  ),
                ],
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: VButton.ghost(
              label: l10n.connectorAddField,
              icon: LucideIcons.plus,
              size: VButtonSize.sm,
              onPressed: () => setState(() => _rows.add(_Row())),
            ),
          ),
          if (_preview case final preview?) ...[
            const SizedBox(height: VSpace.x4),
            Text(
              l10n.connectorPreviewTitle(preview.raw.length),
              style: t.heading,
            ),
            const SizedBox(height: VSpace.x1),
            Text(
              l10n.connectorPaths(preview.paths.join(' · ')),
              style: t.small,
            ),
            const SizedBox(height: VSpace.x2),
            for (final record in preview.mapped.take(10))
              Container(
                margin: const EdgeInsets.only(bottom: VSpace.x1_5),
                padding: const EdgeInsets.all(VSpace.x2),
                decoration: BoxDecoration(
                  borderRadius: VRadius.mdAll,
                  border: Border.all(
                    color: record.problems.isEmpty ? c.border : c.danger,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(record.ref ?? '—', style: t.bodyStrong),
                    Text(
                      [
                        for (final MapEntry(:key, :value)
                            in record.fields.entries)
                          if (value != null) '$key : $value',
                      ].join(' · '),
                      style: t.small,
                    ),
                    for (final problem in record.problems)
                      Text(problem, style: t.small.copyWith(color: c.danger)),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
