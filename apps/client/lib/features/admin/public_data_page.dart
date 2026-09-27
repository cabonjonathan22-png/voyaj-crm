import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';
import '../../l10n/generated/app_localizations.dart';

/// Données publiques : sources importées en organisations (régions,
/// départements, EPCI, communes, AOM, festivals), périmètre, import
/// quotidien et historique. Connexion au serveur requise.
class PublicDataPage extends ConsumerStatefulWidget {
  const PublicDataPage({super.key});

  @override
  ConsumerState<PublicDataPage> createState() => _PublicDataPageState();
}

class _PublicDataPageState extends ConsumerState<PublicDataPage> {
  List<PublicSourceStatus>? _sources;
  List<PublicDataRun> _runs = const [];
  String? _error;
  bool _loading = false;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  ApiClient get _api => ref.read(apiClientProvider)!;

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final sources = await _api.get('/api/v1/public-data');
      final runs = await _api.get('/api/v1/public-data/runs?limit=20');
      if (!mounted) return;
      setState(() {
        _sources = [
          for (final s in sources! as List<dynamic>)
            PublicSourceStatus.fromJson(s as Map<String, dynamic>),
        ];
        _runs = [
          for (final r in runs! as List<dynamic>)
            PublicDataRun.fromJson(r as Map<String, dynamic>),
        ];
        _error = null;
      });
      // Import en cours : actualisation automatique.
      final running = _sources!.any(
        (s) => s.lastRun?.status == PublicRunStatus.running,
      );
      _poll?.cancel();
      if (running) {
        _poll = Timer(const Duration(seconds: 3), () => unawaited(_load()));
      }
    } on ApiFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _configure(
    PublicSourceStatus status, {
    bool? enabled,
    List<String>? departements,
  }) async {
    try {
      await _api.put(
        '/api/v1/public-data/${status.source}',
        ConfigurePublicSourceRequest(
          enabled: enabled ?? status.enabled,
          departements: departements ?? status.departements,
        ).toJson(),
      );
      await _load();
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    }
  }

  Future<void> _run(PublicSourceStatus status) async {
    final l10n = context.l10n;
    try {
      await _api.post('/api/v1/public-data/${status.source}/run');
      ref.read(toastProvider).info(l10n.publicDataStarted);
      await _load();
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    }
  }

  Future<void> _editScope(PublicSourceStatus status) async {
    final result = await showVModal<List<String>>(
      context,
      builder: (_) => _ScopeModal(initial: status.departements),
    );
    if (result != null) await _configure(status, departements: result);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sources = _sources;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navPublicData,
          subtitle: l10n.publicDataSubtitle,
          icon: LucideIcons.landmark,
          actions: [
            VButton(
              label: l10n.refresh,
              icon: LucideIcons.refreshCw,
              loading: _loading,
              onPressed: () => unawaited(_load()),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(VSpace.x6),
            children: [
              if (_error != null) ...[
                VBanner(message: _error!, tone: VTone.danger),
                const SizedBox(height: VSpace.x4),
              ],
              VBanner(message: l10n.publicDataHelp, icon: LucideIcons.info),
              const SizedBox(height: VSpace.x4),
              if (sources == null && _error == null) const SkeletonRows(),
              for (final status in sources ?? const <PublicSourceStatus>[])
                Padding(
                  padding: const EdgeInsets.only(bottom: VSpace.x4),
                  child: _SourceCard(
                    status: status,
                    onEnabled: (v) => unawaited(_configure(status, enabled: v)),
                    onEditScope: () => unawaited(_editScope(status)),
                    onRun: () => unawaited(_run(status)),
                  ),
                ),
              if (_runs.isNotEmpty) ...[
                const SizedBox(height: VSpace.x2),
                VCard(
                  title: l10n.publicDataHistory,
                  child: Column(
                    children: [for (final run in _runs) _RunRow(run: run)],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

String _sourceLabel(String key) =>
    enumByKey(PublicSource.values, key)?.label ?? key;

String _runSummary(AppLocalizations l10n, PublicDataRun run) =>
    run.status == PublicRunStatus.running
    ? l10n.publicDataRunning
    : l10n.publicDataCounts(
        run.fetched,
        run.created,
        run.updated,
        run.unchanged,
      );

VBadge _statusBadge(AppLocalizations l10n, PublicRunStatus status) =>
    switch (status) {
      PublicRunStatus.running => VBadge(
        l10n.publicDataStatusRunning,
        tone: VTone.info,
        icon: LucideIcons.loader,
      ),
      PublicRunStatus.succeeded => VBadge(
        l10n.publicDataStatusSucceeded,
        tone: VTone.success,
        icon: LucideIcons.circleCheck,
      ),
      PublicRunStatus.failed => VBadge(
        l10n.publicDataStatusFailed,
        tone: VTone.danger,
        icon: LucideIcons.circleAlert,
      ),
    };

class _SourceCard extends StatelessWidget {
  const _SourceCard({
    required this.status,
    required this.onEnabled,
    required this.onEditScope,
    required this.onRun,
  });

  final PublicSourceStatus status;
  final ValueChanged<bool> onEnabled;
  final VoidCallback onEditScope;
  final VoidCallback onRun;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final source = enumByKey(PublicSource.values, status.source);
    final run = status.lastRun;
    final running = run?.status == PublicRunStatus.running;
    final scoped = source != PublicSource.regions;

    return VCard(
      title: _sourceLabel(status.source),
      description: l10n.publicDataProvider(source?.provider ?? ''),
      actions: [
        Text(l10n.publicDataDaily, style: t.small),
        Switch(value: status.enabled, onChanged: onEnabled),
        const SizedBox(width: VSpace.x2),
        VButton.primary(
          label: l10n.publicDataRunNow,
          icon: LucideIcons.download,
          size: VButtonSize.sm,
          loading: running,
          onPressed: running ? null : onRun,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (scoped)
            VInfoRow(
              l10n.publicDataScope,
              null,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      status.departements.isEmpty
                          ? l10n.publicDataScopeAll
                          : status.departements.join(', '),
                      style: t.body,
                    ),
                  ),
                  VButton.ghost(
                    label: l10n.edit,
                    icon: LucideIcons.pencil,
                    size: VButtonSize.sm,
                    onPressed: onEditScope,
                  ),
                ],
              ),
            ),
          if (source == PublicSource.communes && status.departements.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: VSpace.x2),
              child: VBanner(
                message: l10n.publicDataCommunesWarning,
                tone: VTone.warning,
              ),
            ),
          VInfoRow(
            l10n.publicDataLastRun,
            null,
            child: run == null
                ? Text(l10n.publicDataNever, style: t.small)
                : Wrap(
                    spacing: VSpace.x2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _statusBadge(l10n, run.status),
                      Text(formatDateTime(run.startedAt), style: t.small),
                      Text(_runSummary(l10n, run), style: t.small),
                    ],
                  ),
          ),
          if (run?.error != null)
            Padding(
              padding: const EdgeInsets.only(top: VSpace.x2),
              child: VBanner(
                message: run!.error!,
                tone: run.status == PublicRunStatus.failed
                    ? VTone.danger
                    : VTone.warning,
              ),
            ),
        ],
      ),
    );
  }
}

class _RunRow extends StatelessWidget {
  const _RunRow({required this.run});

  final PublicDataRun run;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: VSpace.x1_5),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(formatDateTime(run.startedAt), style: t.small),
          ),
          SizedBox(
            width: 240,
            child: Text(
              _sourceLabel(run.source),
              overflow: TextOverflow.ellipsis,
              style: t.body,
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              run.trigger == PublicRunTrigger.schedule
                  ? l10n.publicDataTriggerSchedule
                  : l10n.publicDataTriggerManual,
              style: t.small,
            ),
          ),
          _statusBadge(l10n, run.status),
          const SizedBox(width: VSpace.x3),
          Expanded(
            child: Text(
              run.error ?? _runSummary(l10n, run),
              overflow: TextOverflow.ellipsis,
              style: t.small,
            ),
          ),
        ],
      ),
    );
  }
}

/// Saisie du périmètre (codes de départements).
class _ScopeModal extends StatefulWidget {
  const _ScopeModal({required this.initial});

  final List<String> initial;

  @override
  State<_ScopeModal> createState() => _ScopeModalState();
}

class _ScopeModalState extends State<_ScopeModal> {
  late final _codes = TextEditingController(text: widget.initial.join(', '));
  String? _error;

  @override
  void dispose() {
    _codes.dispose();
    super.dispose();
  }

  void _save() {
    final codes = [
      for (final c in _codes.text.split(RegExp(r'[\s,;]+')))
        if (c.trim().isNotEmpty) c.trim().toUpperCase(),
    ];
    final invalid = codes.where(
      (c) => !RegExp(r'^(\d{2,3}|2[AB])$').hasMatch(c),
    );
    if (invalid.isNotEmpty) {
      setState(
        () => _error = context.l10n.publicDataScopeInvalid(invalid.join(', ')),
      );
      return;
    }
    Navigator.of(context).pop({...codes}.toList()..sort());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return VModal(
      title: l10n.publicDataScope,
      description: l10n.publicDataScopeHelp,
      icon: LucideIcons.mapPinned,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(label: l10n.save, onPressed: _save),
      ],
      child: VTextField(
        controller: _codes,
        autofocus: true,
        label: l10n.publicDataScopeCodes,
        hint: '12, 46, 48, 81, 82',
        error: _error,
        onSubmitted: (_) => _save(),
      ),
    );
  }
}
