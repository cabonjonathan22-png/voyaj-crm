import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';
import 'connector_editor.dart';
import 'connectors_data.dart';

/// Connecteurs : sources externes (REST, Supabase, Firebase, MySQL,
/// MongoDB, webhook entrant) importées en organisations ou contacts, et
/// webhooks sortants. Connexion au serveur requise.
class ConnectorsPage extends ConsumerStatefulWidget {
  const ConnectorsPage({super.key});

  @override
  ConsumerState<ConnectorsPage> createState() => _ConnectorsPageState();
}

class _ConnectorsPageState extends ConsumerState<ConnectorsPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final online = ref.watch(connectorsApiProvider) != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navConnectors,
          subtitle: l10n.connectorsSubtitle,
          icon: LucideIcons.plug,
          actions: [
            VButton(
              label: l10n.refresh,
              icon: LucideIcons.refreshCw,
              onPressed: () {
                ref
                  ..invalidate(connectorsProvider)
                  ..invalidate(webhooksProvider);
              },
            ),
            if (online)
              VButton.primary(
                label: _tab == 0 ? l10n.connectorNew : l10n.webhookNew,
                icon: LucideIcons.plus,
                onPressed: () async {
                  final saved = _tab == 0
                      ? await showConnectorEditor(context)
                      : await _editWebhook(context);
                  if (saved == true) {
                    ref
                      ..invalidate(connectorsProvider)
                      ..invalidate(webhooksProvider);
                  }
                },
              ),
          ],
        ),
        VTabBar(
          index: _tab,
          onChanged: (i) => setState(() => _tab = i),
          tabs: [
            VTab(l10n.connectorsTab, icon: LucideIcons.plug),
            VTab(l10n.webhooksTab, icon: LucideIcons.send),
          ],
        ),
        Expanded(
          child: !online
              ? Center(
                  child: EmptyState(
                    icon: LucideIcons.cloudOff,
                    title: l10n.billingSettingsOffline,
                  ),
                )
              : _tab == 0
              ? const _Connectors()
              : const _Webhooks(),
        ),
      ],
    );
  }
}

VTone _runTone(String? status) => switch (status) {
  'succeeded' => VTone.success,
  'failed' => VTone.danger,
  'running' => VTone.info,
  _ => VTone.neutral,
};

class _Connectors extends ConsumerStatefulWidget {
  const _Connectors();

  @override
  ConsumerState<_Connectors> createState() => _ConnectorsState();
}

class _ConnectorsState extends ConsumerState<_Connectors> {
  Timer? _poll;

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  ConnectorsApi get _api => ref.read(connectorsApiProvider)!;

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    }
  }

  Future<void> _run(ConnectorInfo connector) => _guard(() async {
    await _api.run(connector.id);
    ref.read(toastProvider).info(context.l10n.connectorStarted);
    ref.invalidate(connectorsProvider);
  });

  Future<void> _delete(ConnectorInfo connector) async {
    final l10n = context.l10n;
    final ok = await confirm(
      context,
      title: l10n.connectorDeleteTitle(connector.name),
      message: l10n.connectorDeleteMessage,
      confirmLabel: l10n.delete,
      destructive: true,
    );
    if (!ok) return;
    await _guard(() async {
      await _api.delete(connector.id);
      ref.invalidate(connectorsProvider);
    });
  }

  Future<void> _token(ConnectorInfo connector) async {
    final l10n = context.l10n;
    if (connector.hasWebhookToken) {
      final ok = await confirm(
        context,
        title: l10n.connectorTokenRenewTitle,
        message: l10n.connectorTokenRenewMessage,
        confirmLabel: l10n.connectorTokenRenew,
      );
      if (!ok) return;
    }
    await _guard(() async {
      final token = await _api.webhookToken(connector.id);
      ref.invalidate(connectorsProvider);
      if (mounted) await _showToken(context, token);
    });
  }

  Future<void> _history(ConnectorInfo connector) => _guard(() async {
    final runs = await _api.runs(connector.id);
    if (mounted) await _showRuns(context, connector, runs);
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final async = ref.watch(connectorsProvider);
    final running = (async.value ?? const <ConnectorInfo>[]).any(
      (c) => c.lastRun?.status == 'running',
    );
    _poll?.cancel();
    if (running) {
      _poll = Timer(
        const Duration(seconds: 3),
        () => ref.invalidate(connectorsProvider),
      );
    }
    return async.when(
      loading: () => const Center(child: VSpinner()),
      error: (e, _) => Center(
        child: EmptyState(
          icon: LucideIcons.triangleAlert,
          title: e is ApiFailure ? e.message : '$e',
        ),
      ),
      data: (connectors) => ListView(
        padding: const EdgeInsets.all(VSpace.x6),
        children: [
          if (connectors.isEmpty)
            EmptyState(
              icon: LucideIcons.plug,
              title: l10n.connectorsEmpty,
              message: l10n.connectorsEmptyMessage,
            ),
          for (final connector in connectors)
            Padding(
              padding: const EdgeInsets.only(bottom: VSpace.x3),
              child: VCard(
                title: connector.name,
                description: [
                  enumByKey(ConnectorKind.values, connector.kind)?.label ??
                      connector.kind,
                  connector.mapping.entity == 'contacts'
                      ? l10n.navContacts
                      : l10n.navOrganisations,
                  if (connector.scheduleMinutes case final m?)
                    m < 60
                        ? l10n.connectorEveryMinutes(m)
                        : l10n.connectorEveryHours(m ~/ 60),
                  if (!connector.enabled) l10n.connectorDisabled,
                ].join(' · '),
                actions: [
                  if (connector.kind == ConnectorKind.webhook.key)
                    VButton(
                      label: l10n.connectorToken,
                      icon: LucideIcons.keyRound,
                      size: VButtonSize.sm,
                      onPressed: () => unawaited(_token(connector)),
                    )
                  else
                    VButton(
                      label: l10n.connectorRun,
                      icon: LucideIcons.play,
                      size: VButtonSize.sm,
                      onPressed: connector.lastRun?.status == 'running'
                          ? null
                          : () => unawaited(_run(connector)),
                    ),
                  VIconButton(
                    icon: LucideIcons.history,
                    tooltip: l10n.connectorHistory,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(_history(connector)),
                  ),
                  VIconButton(
                    icon: LucideIcons.pencil,
                    tooltip: l10n.edit,
                    size: VButtonSize.sm,
                    onPressed: () async {
                      final saved = await showConnectorEditor(
                        context,
                        connector: connector,
                      );
                      if (saved == true) ref.invalidate(connectorsProvider);
                    },
                  ),
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(_delete(connector)),
                  ),
                ],
                child: switch (connector.lastRun) {
                  null => Text(l10n.connectorNeverRun, style: t.small),
                  final run => _RunLine(run: run),
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _RunLine extends StatelessWidget {
  const _RunLine({required this.run});

  final ConnectorRun run;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            VBadge(switch (run.status) {
              'succeeded' => l10n.connectorRunSucceeded,
              'failed' => l10n.connectorRunFailed,
              _ => l10n.connectorRunRunning,
            }, tone: _runTone(run.status)),
            const SizedBox(width: VSpace.x2),
            Expanded(
              child: Text(
                '${formatDateTime(run.startedAt.toLocal())} · '
                '${l10n.connectorRunStats(run.fetched, run.created, run.updated, run.unchanged, run.rejected)}',
                style: t.small,
              ),
            ),
          ],
        ),
        if (run.error != null) ...[
          const SizedBox(height: VSpace.x1),
          Text(
            run.error!,
            style: t.small.copyWith(color: context.colors.danger),
          ),
        ],
      ],
    );
  }
}

Future<void> _showRuns(
  BuildContext context,
  ConnectorInfo connector,
  List<ConnectorRun> runs,
) => showVModal<void>(
  context,
  builder: (context) {
    final l10n = context.l10n;
    final t = context.text;
    return VModal(
      title: l10n.connectorHistoryOf(connector.name),
      icon: LucideIcons.history,
      width: 720,
      actions: [
        VButton(
          label: l10n.close,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (runs.isEmpty) Text(l10n.connectorNeverRun, style: t.small),
          for (final run in runs)
            Padding(
              padding: const EdgeInsets.only(bottom: VSpace.x3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RunLine(run: run),
                  for (final problem in run.problems.take(5))
                    Text('• $problem', style: t.small),
                ],
              ),
            ),
        ],
      ),
    );
  },
);

Future<void> _showToken(BuildContext context, WebhookToken token) =>
    showVModal<void>(
      context,
      builder: (context) {
        final l10n = context.l10n;
        final t = context.text;
        Widget copyRow(String label, String value) => Padding(
          padding: const EdgeInsets.only(bottom: VSpace.x3),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: t.label),
                    SelectableText(value, style: t.mono),
                  ],
                ),
              ),
              VIconButton(
                icon: LucideIcons.copy,
                tooltip: l10n.copy,
                onPressed: () =>
                    unawaited(Clipboard.setData(ClipboardData(text: value))),
              ),
            ],
          ),
        );
        return VModal(
          title: l10n.connectorToken,
          icon: LucideIcons.keyRound,
          width: 640,
          actions: [
            VButton.primary(
              label: l10n.close,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              VBanner(message: l10n.connectorTokenOnce, tone: VTone.warning),
              const SizedBox(height: VSpace.x3),
              copyRow(l10n.connectorTokenUrl, token.url),
              copyRow(l10n.connectorTokenValue, token.token),
              Text(l10n.connectorTokenUsage, style: t.small),
            ],
          ),
        );
      },
    );

// ── Webhooks sortants ────────────────────────────────────────────────────

Future<bool?> _editWebhook(BuildContext context, {WebhookInfo? webhook}) =>
    showVModal<bool>(context, builder: (_) => _WebhookForm(webhook: webhook));

class _WebhookForm extends ConsumerStatefulWidget {
  const _WebhookForm({this.webhook});

  final WebhookInfo? webhook;

  @override
  ConsumerState<_WebhookForm> createState() => _WebhookFormState();
}

class _WebhookFormState extends ConsumerState<_WebhookForm> {
  late final _name = TextEditingController(text: widget.webhook?.name ?? '');
  late final _url = TextEditingController(text: widget.webhook?.url ?? '');
  final _secret = TextEditingController();
  late final Set<String> _entities = {
    ...?widget.webhook?.entities,
    if (widget.webhook == null) 'organisations',
  };
  late bool _enabled = widget.webhook?.enabled ?? true;
  Map<String, String> _errors = const {};
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _url.dispose();
    _secret.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(connectorsApiProvider)!
          .saveWebhook(
            widget.webhook?.id,
            WebhookInput(
              name: _name.text,
              url: _url.text,
              entities: _entities.toList(),
              enabled: _enabled,
              secret: _secret.text.isEmpty ? null : _secret.text,
            ),
          );
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
    return VModal(
      title: widget.webhook == null ? l10n.webhookNew : l10n.webhookEdit,
      icon: LucideIcons.send,
      width: 620,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(
          label: widget.webhook == null ? l10n.create : l10n.save,
          loading: _saving,
          onPressed: () => unawaited(_save()),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          VTextField(
            controller: _name,
            label: l10n.connectorName,
            autofocus: widget.webhook == null,
            error: _errors['name'],
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(
            controller: _url,
            label: l10n.webhookUrl,
            hint: 'https://…',
            error: _errors['url'],
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(
            controller: _secret,
            label: l10n.webhookSecret,
            helper: l10n.webhookSecretHelp,
            hint: widget.webhook?.hasSecret == true
                ? l10n.secretUnchanged
                : null,
            obscure: true,
          ),
          const SizedBox(height: VSpace.x3),
          Text(l10n.webhookEntities, style: t.label),
          if (_errors['entities'] != null)
            Text(
              _errors['entities']!,
              style: t.small.copyWith(color: context.colors.danger),
            ),
          Wrap(
            spacing: VSpace.x2,
            children: [
              for (final schema in SyncEntities.all)
                VChip(
                  schema.name,
                  icon: _entities.contains(schema.name)
                      ? LucideIcons.check
                      : LucideIcons.plus,
                  onPressed: () => setState(() {
                    if (!_entities.remove(schema.name)) {
                      _entities.add(schema.name);
                    }
                  }),
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
        ],
      ),
    );
  }
}

class _Webhooks extends ConsumerWidget {
  const _Webhooks();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final t = context.text;
    final async = ref.watch(webhooksProvider);
    Future<void> guard(Future<void> Function() action) async {
      try {
        await action();
      } on ApiFailure catch (e) {
        ref.read(toastProvider).error(e.message);
      }
    }

    return async.when(
      loading: () => const Center(child: VSpinner()),
      error: (e, _) => Center(
        child: EmptyState(
          icon: LucideIcons.triangleAlert,
          title: e is ApiFailure ? e.message : '$e',
        ),
      ),
      data: (webhooks) => ListView(
        padding: const EdgeInsets.all(VSpace.x6),
        children: [
          VBanner(icon: LucideIcons.info, message: l10n.webhooksHelp),
          const SizedBox(height: VSpace.x4),
          if (webhooks.isEmpty)
            EmptyState(icon: LucideIcons.send, title: l10n.webhooksEmpty),
          for (final webhook in webhooks)
            Padding(
              padding: const EdgeInsets.only(bottom: VSpace.x3),
              child: VCard(
                title: webhook.name,
                description: '${webhook.url} · ${webhook.entities.join(', ')}',
                actions: [
                  VButton(
                    label: l10n.webhookPing,
                    icon: LucideIcons.zap,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(
                      guard(() async {
                        final status = await ref
                            .read(connectorsApiProvider)!
                            .ping(webhook.id);
                        ref
                            .read(toastProvider)
                            .success(l10n.webhookPingOk(status));
                      }),
                    ),
                  ),
                  VIconButton(
                    icon: LucideIcons.pencil,
                    tooltip: l10n.edit,
                    size: VButtonSize.sm,
                    onPressed: () async {
                      final saved = await _editWebhook(
                        context,
                        webhook: webhook,
                      );
                      if (saved == true) ref.invalidate(webhooksProvider);
                    },
                  ),
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(
                      guard(() async {
                        await ref
                            .read(connectorsApiProvider)!
                            .deleteWebhook(webhook.id);
                        ref.invalidate(webhooksProvider);
                      }),
                    ),
                  ),
                ],
                child: Row(
                  children: [
                    VBadge(
                      !webhook.enabled
                          ? l10n.connectorDisabled
                          : webhook.failures > 0
                          ? l10n.webhookFailing(webhook.failures)
                          : l10n.webhookHealthy,
                      tone: !webhook.enabled
                          ? VTone.neutral
                          : webhook.failures > 0
                          ? VTone.danger
                          : VTone.success,
                    ),
                    const SizedBox(width: VSpace.x2),
                    Expanded(
                      child: Text(
                        [
                          if (webhook.lastDeliveryAt case final at?)
                            l10n.webhookLastDelivery(
                              formatDateTime(at.toLocal()),
                            ),
                          ?webhook.lastError,
                        ].join(' · '),
                        style: t.small,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
