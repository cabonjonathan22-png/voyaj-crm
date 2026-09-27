import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';
import '../crm/deals/deal_form.dart';

final _tendersProvider = FutureProvider.autoDispose
    .family<List<TenderInfo>, String?>((ref, status) async {
      final query = status == null ? '' : '?status=$status';
      final json = await ref
          .watch(apiClientProvider)!
          .get('/api/v1/tenders$query');
      return [
        for (final t in json! as List)
          TenderInfo.fromJson(t as Map<String, dynamic>),
      ];
    });

final _watchProvider = FutureProvider.autoDispose<TenderWatch>((ref) async {
  final json = await ref.watch(apiClientProvider)!.get('/api/v1/tenders/watch');
  return TenderWatch.fromJson(json! as Map<String, dynamic>);
});

/// Organisation dont le nom correspond à l'acheteur d'un avis.
OrganisationRow? matchBuyer(
  String? buyer,
  Iterable<OrganisationRow> organisations,
) {
  if (buyer == null) return null;
  final key = normalizeName(buyer);
  return organisations.where((o) => normalizeName(o.name) == key).firstOrNull;
}

/// Veille des appels d'offres publics (BOAMP) : avis repérés selon les
/// mots-clés et départements, suivis en affaires ou ignorés.
class TendersPage extends ConsumerStatefulWidget {
  const TendersPage({super.key});

  @override
  ConsumerState<TendersPage> createState() => _TendersPageState();
}

class _TendersPageState extends ConsumerState<TendersPage> {
  String? _status = TenderStatus.fresh.key;
  bool _searching = false;

  Future<void> _guard(Future<void> Function(ApiClient api) action) async {
    try {
      await action(ref.read(apiClientProvider)!);
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    }
  }

  Future<void> _search() async {
    setState(() => _searching = true);
    await _guard((api) async {
      final json = await api.post('/api/v1/tenders/run');
      final added = (json! as Map<String, dynamic>)['added'] as int;
      if (mounted) {
        ref.read(toastProvider).success(context.l10n.tendersFound(added));
      }
      ref
        ..invalidate(_tendersProvider)
        ..invalidate(_watchProvider);
    });
    if (mounted) setState(() => _searching = false);
  }

  Future<void> _setStatus(
    TenderInfo tender,
    TenderStatus status, {
    String? dealId,
  }) => _guard((api) async {
    await api.patch(
      '/api/v1/tenders/${tender.id}',
      UpdateTenderRequest(status: status.key, dealId: dealId).toJson(),
    );
    ref.invalidate(_tendersProvider);
  });

  Future<void> _follow(TenderInfo tender) async {
    final l10n = context.l10n;
    final organisation = matchBuyer(
      tender.buyer,
      ref.read(organisationsProvider).value ?? const [],
    );
    final dealId = await showDealForm(
      context,
      ref,
      organisationId: organisation?.id,
      prefill: {
        'title': tender.title.length > 200
            ? tender.title.substring(0, 200)
            : tender.title,
        'description': [
          l10n.tenderDealDescription(tender.ref, tender.buyer ?? ''),
          ?tender.url,
        ].join('\n'),
        if (tender.deadline case final d?)
          'expected_close_date': formatDateOnly(d.toLocal()),
      },
    );
    if (dealId == null) return;
    await _setStatus(tender, TenderStatus.followed, dealId: dealId);
    ref.read(toastProvider).success(l10n.tenderFollowed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final online = ref.watch(apiClientProvider) != null;
    final canConfigure = ref.watch(
      permissionProvider(Permission.publicDataManage),
    );
    final canWrite = ref.watch(permissionProvider(Permission.dealWrite));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navTenders,
          subtitle: l10n.tendersSubtitle,
          icon: LucideIcons.gavel,
          actions: [
            if (online && canConfigure)
              VButton(
                label: l10n.tendersConfigure,
                icon: LucideIcons.settings2,
                onPressed: () async {
                  final watch = await ref.read(_watchProvider.future);
                  if (!context.mounted) return;
                  final saved = await showVModal<bool>(
                    context,
                    builder: (_) => _WatchForm(watch: watch),
                  );
                  if (saved == true) ref.invalidate(_watchProvider);
                },
              ),
            if (online && canWrite)
              VButton.primary(
                label: l10n.tendersSearch,
                icon: LucideIcons.search,
                loading: _searching,
                onPressed: () => unawaited(_search()),
              ),
          ],
        ),
        if (!online)
          Expanded(
            child: Center(
              child: EmptyState(
                icon: LucideIcons.cloudOff,
                title: l10n.billingSettingsOffline,
              ),
            ),
          )
        else ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              VSpace.x6,
              VSpace.x4,
              VSpace.x6,
              0,
            ),
            child: Row(
              children: [
                VSegmented<String?>(
                  value: _status,
                  options: [
                    for (final s in TenderStatus.values)
                      VSelectOption(s.key, s.label),
                    VSelectOption(null, l10n.tendersAll),
                  ],
                  onChanged: (v) => setState(() => _status = v),
                ),
                const SizedBox(width: VSpace.x4),
                Expanded(
                  child: switch (ref.watch(_watchProvider).value) {
                    final w? => Text(
                      w.keywords.isEmpty
                          ? l10n.tendersNotConfigured
                          : [
                              l10n.tendersKeywords(w.keywords.join(', ')),
                              if (w.departements.isNotEmpty)
                                l10n.tendersDepartements(
                                  w.departements.join(', '),
                                ),
                              if (w.lastRunAt case final at?)
                                l10n.tendersLastRun(formatRelative(at)),
                            ].join(' · '),
                      style: t.small,
                      overflow: TextOverflow.ellipsis,
                    ),
                    null => const SizedBox.shrink(),
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ref
                .watch(_tendersProvider(_status))
                .when(
                  loading: () => const Center(child: VSpinner()),
                  error: (e, _) => Center(
                    child: EmptyState(
                      icon: LucideIcons.triangleAlert,
                      title: e is ApiFailure ? e.message : '$e',
                    ),
                  ),
                  data: (list) => ListView(
                    padding: const EdgeInsets.all(VSpace.x6),
                    children: [
                      if (list.isEmpty)
                        EmptyState(
                          icon: LucideIcons.gavel,
                          title: l10n.tendersEmpty,
                        ),
                      for (final tender in list)
                        _TenderCard(
                          tender: tender,
                          onFollow: canWrite && tender.status != 'followed'
                              ? () => unawaited(_follow(tender))
                              : null,
                          onIgnore: canWrite && tender.status == 'new'
                              ? () => unawaited(
                                  _setStatus(tender, TenderStatus.ignored),
                                )
                              : null,
                        ),
                    ],
                  ),
                ),
          ),
        ],
      ],
    );
  }
}

class _TenderCard extends StatelessWidget {
  const _TenderCard({required this.tender, this.onFollow, this.onIgnore});

  final TenderInfo tender;
  final VoidCallback? onFollow;
  final VoidCallback? onIgnore;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final deadline = tender.deadline?.toLocal();
    final daysLeft = deadline?.difference(DateTime.now()).inDays;
    return Padding(
      padding: const EdgeInsets.only(bottom: VSpace.x3),
      child: VCard(
        title: tender.title,
        description: [
          ?tender.buyer,
          l10n.tenderPublished(formatDay(tender.publishedOn)),
          if (tender.departements.isNotEmpty) tender.departements.join(', '),
          ?tender.nature,
          ?tender.procedure,
        ].join(' · '),
        actions: [
          if (tender.url case final url?)
            VIconButton(
              icon: LucideIcons.externalLink,
              tooltip: l10n.tenderOpen,
              size: VButtonSize.sm,
              onPressed: () => unawaited(launchUrl(Uri.parse(url))),
            ),
          if (onIgnore != null)
            VButton(
              label: l10n.tenderIgnore,
              size: VButtonSize.sm,
              onPressed: onIgnore,
            ),
          if (onFollow != null)
            VButton.primary(
              label: l10n.tenderFollow,
              icon: LucideIcons.handCoins,
              size: VButtonSize.sm,
              onPressed: onFollow,
            ),
        ],
        child: Row(
          children: [
            VBadge(
              enumByKey(TenderStatus.values, tender.status)?.label ??
                  tender.status,
              tone: switch (tender.status) {
                'followed' => VTone.success,
                'ignored' => VTone.neutral,
                _ => VTone.info,
              },
            ),
            const SizedBox(width: VSpace.x2),
            if (deadline != null)
              Text(
                l10n.tenderDeadline(
                  formatDateTime(deadline),
                  daysLeft! < 0 ? 0 : daysLeft,
                ),
                style: t.small.copyWith(color: daysLeft < 7 ? c.danger : null),
              ),
            const Spacer(),
            for (final d in tender.descriptors.take(4))
              Padding(
                padding: const EdgeInsets.only(left: VSpace.x1),
                child: VBadge(d),
              ),
          ],
        ),
      ),
    );
  }
}

class _WatchForm extends ConsumerStatefulWidget {
  const _WatchForm({required this.watch});

  final TenderWatch watch;

  @override
  ConsumerState<_WatchForm> createState() => _WatchFormState();
}

class _WatchFormState extends ConsumerState<_WatchForm> {
  late final _keywords = TextEditingController(
    text: widget.watch.keywords.join(', '),
  );
  late final _departements = TextEditingController(
    text: widget.watch.departements.join(', '),
  );
  late bool _enabled = widget.watch.enabled;
  Map<String, String> _errors = const {};

  @override
  void dispose() {
    _keywords.dispose();
    _departements.dispose();
    super.dispose();
  }

  static List<String> _split(String text) => [
    for (final part in text.split(RegExp('[,;\n]')))
      if (part.trim().isNotEmpty) part.trim(),
  ];

  Future<void> _save() async {
    try {
      await ref
          .read(apiClientProvider)!
          .put(
            '/api/v1/tenders/watch',
            TenderWatch(
              enabled: _enabled,
              keywords: _split(_keywords.text),
              departements: _split(_departements.text),
            ).toJson(),
          );
      if (mounted) Navigator.of(context).pop(true);
    } on ApiFailure catch (e) {
      setState(() => _errors = {for (final i in e.issues) i.field: i.message});
      if (e.issues.isEmpty) ref.read(toastProvider).error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    return VModal(
      title: l10n.tendersConfigure,
      icon: LucideIcons.settings2,
      width: 560,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(label: l10n.save, onPressed: () => unawaited(_save())),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          VTextField(
            controller: _keywords,
            label: l10n.tendersKeywordsLabel,
            hint: 'transport de voyageurs, navette, transport scolaire',
            helper: l10n.tendersKeywordsHelp,
            maxLines: 2,
            error: _errors['keywords'],
            autofocus: true,
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(
            controller: _departements,
            label: l10n.tendersDepartementsLabel,
            hint: '12, 81, 46',
            helper: l10n.tendersDepartementsHelp,
          ),
          Row(
            children: [
              Checkbox(
                value: _enabled,
                onChanged: (v) => setState(() => _enabled = v ?? false),
              ),
              Text(l10n.tendersDaily, style: t.body),
            ],
          ),
        ],
      ),
    );
  }
}
