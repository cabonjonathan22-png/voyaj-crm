import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../crm/activities/activity_form.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';

/// Date d'agenda d'une activité (début, sinon échéance), locale.
DateTime? agendaDate(ActivityRow a) => (a.startsAt ?? a.dueAt)?.toLocal();

/// Premier jour (lundi) de la grille du mois de [month].
DateTime gridStart(DateTime month) {
  final first = DateTime(month.year, month.month);
  return first.subtract(Duration(days: first.weekday - 1));
}

/// Agenda : rendez-vous, appels et tâches datés, par mois (données
/// locales) ; abonnement ICS pour Outlook ou Google Agenda.
class AgendaPage extends ConsumerStatefulWidget {
  const AgendaPage({super.key});

  @override
  ConsumerState<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends ConsumerState<AgendaPage> {
  late DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  late DateTime _selected = _today;
  bool _mine = true;

  static DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _shift(int months) =>
      setState(() => _month = DateTime(_month.year, _month.month + months));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final userId = ref.watch(currentUserProvider.select((u) => u?.id));
    final canWrite = ref.watch(permissionProvider(Permission.activityWrite));
    final all = ref.watch(activitiesProvider).value ?? const <ActivityRow>[];
    final byDay = <DateTime, List<ActivityRow>>{};
    for (final a in all) {
      final date = agendaDate(a);
      if (date == null || a.kind == ActivityKind.note.key) continue;
      if (_mine && (a.assigneeId ?? a.ownerId ?? a.createdBy) != userId) {
        continue;
      }
      byDay
          .putIfAbsent(DateTime(date.year, date.month, date.day), () => [])
          .add(a);
    }
    for (final list in byDay.values) {
      list.sort((a, b) => agendaDate(a)!.compareTo(agendaDate(b)!));
    }
    final start = gridStart(_month);
    final days = [
      for (var i = 0; i < 42; i++)
        DateTime(start.year, start.month, start.day + i),
    ];
    final title = toBeginningOfSentenceCase(
      DateFormat('MMMM yyyy', 'fr').format(_month),
    );
    final selectedEvents = byDay[_selected] ?? const <ActivityRow>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navAgenda,
          subtitle: title,
          icon: LucideIcons.calendarDays,
          actions: [
            VSegmented<bool>(
              value: _mine,
              options: [
                VSelectOption(true, l10n.agendaMine),
                VSelectOption(false, l10n.agendaEveryone),
              ],
              onChanged: (v) => setState(() => _mine = v),
            ),
            VIconButton(
              icon: LucideIcons.chevronLeft,
              tooltip: l10n.agendaPrevious,
              onPressed: () => _shift(-1),
            ),
            VButton(
              label: l10n.agendaToday,
              onPressed: () => setState(() {
                _month = DateTime(_today.year, _today.month);
                _selected = _today;
              }),
            ),
            VIconButton(
              icon: LucideIcons.chevronRight,
              tooltip: l10n.agendaNext,
              onPressed: () => _shift(1),
            ),
            VButton(
              label: l10n.agendaSubscribe,
              icon: LucideIcons.calendarSync,
              onPressed: ref.watch(apiClientProvider) == null
                  ? null
                  : () => unawaited(_showSubscription(context, ref)),
            ),
          ],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(VSpace.x4),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          for (final name in const [
                            'lun.',
                            'mar.',
                            'mer.',
                            'jeu.',
                            'ven.',
                            'sam.',
                            'dim.',
                          ])
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: VSpace.x1,
                                ),
                                child: Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  style: t.label,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            for (var week = 0; week < 6; week++)
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    for (final day
                                        in days.skip(week * 7).take(7))
                                      Expanded(
                                        child: _DayCell(
                                          day: day,
                                          events: byDay[day] ?? const [],
                                          inMonth: day.month == _month.month,
                                          today: _sameDay(day, _today),
                                          selected: _sameDay(day, _selected),
                                          onTap: () =>
                                              setState(() => _selected = day),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 320,
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: c.border)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(VSpace.x4),
                  children: [
                    Text(
                      toBeginningOfSentenceCase(
                        DateFormat('EEEE d MMMM', 'fr').format(_selected),
                      ),
                      style: t.heading,
                    ),
                    const SizedBox(height: VSpace.x3),
                    if (canWrite)
                      Wrap(
                        spacing: VSpace.x2,
                        runSpacing: VSpace.x2,
                        children: [
                          VButton(
                            label: l10n.agendaNewMeeting,
                            icon: LucideIcons.calendarPlus,
                            size: VButtonSize.sm,
                            onPressed: () => unawaited(
                              showActivityForm(
                                context,
                                ref,
                                kind: ActivityKind.meeting,
                              ),
                            ),
                          ),
                          VButton(
                            label: l10n.agendaNewTask,
                            icon: LucideIcons.squareCheck,
                            size: VButtonSize.sm,
                            onPressed: () => unawaited(
                              showActivityForm(
                                context,
                                ref,
                                kind: ActivityKind.task,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: VSpace.x3),
                    if (selectedEvents.isEmpty)
                      Text(l10n.agendaNothing, style: t.small),
                    for (final a in selectedEvents)
                      _EventTile(
                        activity: a,
                        onTap: canWrite
                            ? () => unawaited(
                                showActivityForm(context, ref, activity: a),
                              )
                            : null,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.events,
    required this.inMonth,
    required this.today,
    required this.selected,
    required this.onTap,
  });

  final DateTime day;
  final List<ActivityRow> events;
  final bool inMonth;
  final bool today;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    const shown = 3;
    return Pressable(
      onPressed: onTap,
      semanticLabel: DateFormat('d MMMM', 'fr').format(day),
      builder: (context, s) => Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(VSpace.x1),
        decoration: BoxDecoration(
          color: selected
              ? c.surfaceSelected
              : s.hovered
              ? c.surfaceHover
              : inMonth
              ? c.surface
              : c.backgroundSubtle,
          borderRadius: VRadius.smAll,
          border: Border.all(color: today ? c.accent : c.borderSubtle),
        ),
        child: ClipRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${day.day}',
                style: (today ? t.bodyStrong : t.small).copyWith(
                  color: today
                      ? c.accentText
                      : inMonth
                      ? null
                      : c.textSubtle,
                ),
              ),
              for (final a in events.take(shown))
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      Icon(
                        activityIcon(enumByKey(ActivityKind.values, a.kind)),
                        size: 10,
                        color: a.doneAt != null ? c.textSubtle : c.accentText,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          a.subject,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: t.caption.copyWith(
                            decoration: a.doneAt != null
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (events.length > shown)
                Text('+${events.length - shown}', style: t.caption),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventTile extends ConsumerWidget {
  const _EventTile({required this.activity, this.onTap});

  final ActivityRow activity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final t = context.text;
    final a = activity;
    final org = ref.watch(organisationByIdProvider)[a.organisationId];
    final start = agendaDate(a)!;
    final time = DateFormat('HH:mm', 'fr');
    return Pressable(
      onPressed: onTap,
      semanticLabel: a.subject,
      builder: (context, s) => Container(
        margin: const EdgeInsets.only(bottom: VSpace.x2),
        padding: const EdgeInsets.all(VSpace.x2),
        decoration: BoxDecoration(
          color: s.hovered ? c.surfaceHover : c.surface,
          borderRadius: VRadius.mdAll,
          border: Border.all(color: c.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              activityIcon(enumByKey(ActivityKind.values, a.kind)),
              size: 14,
              color: c.textMuted,
            ),
            const SizedBox(width: VSpace.x2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a.subject, style: t.bodyStrong),
                  Text(
                    [
                      a.endsAt == null
                          ? time.format(start)
                          : '${time.format(start)} – '
                                '${time.format(a.endsAt!.toLocal())}',
                      ?org?.name,
                    ].join(' · '),
                    style: t.small,
                  ),
                ],
              ),
            ),
            if (a.doneAt != null)
              Icon(LucideIcons.check, size: 14, color: c.success),
          ],
        ),
      ),
    );
  }
}

/// Abonnement ICS : génère l'URL personnelle (affichée une fois) ou la
/// révoque.
Future<void> _showSubscription(BuildContext context, WidgetRef ref) async {
  final api = ref.read(apiClientProvider);
  if (api == null) return;
  final toasts = ref.read(toastProvider);
  final bool active;
  try {
    active =
        ((await api.get('/api/v1/calendar/feed'))!
                as Map<String, dynamic>)['active']
            as bool;
  } on ApiFailure catch (e) {
    toasts.error(e.message);
    return;
  }
  if (!context.mounted) return;
  await showVModal<void>(
    context,
    builder: (_) => _SubscriptionModal(active: active),
  );
}

class _SubscriptionModal extends ConsumerStatefulWidget {
  const _SubscriptionModal({required this.active});

  final bool active;

  @override
  ConsumerState<_SubscriptionModal> createState() => _SubscriptionModalState();
}

class _SubscriptionModalState extends ConsumerState<_SubscriptionModal> {
  String? _url;
  late bool _active = widget.active;
  bool _busy = false;

  Future<void> _call(Future<void> Function(ApiClient api) action) async {
    setState(() => _busy = true);
    try {
      await action(ref.read(apiClientProvider)!);
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    return VModal(
      title: l10n.agendaSubscribe,
      icon: LucideIcons.calendarSync,
      width: 620,
      actions: [
        if (_active)
          VButton(
            label: l10n.agendaRevoke,
            loading: _busy,
            onPressed: () => unawaited(
              _call((api) async {
                await api.delete('/api/v1/calendar/feed');
                setState(() {
                  _active = false;
                  _url = null;
                });
              }),
            ),
          ),
        VButton.primary(
          label: _active ? l10n.agendaRenew : l10n.agendaCreateLink,
          loading: _busy,
          onPressed: () => unawaited(
            _call((api) async {
              final json =
                  (await api.post('/api/v1/calendar/feed'))!
                      as Map<String, dynamic>;
              setState(() {
                _url = json['url'] as String;
                _active = true;
              });
            }),
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.agendaSubscribeHelp, style: t.body),
          const SizedBox(height: VSpace.x3),
          if (_url != null) ...[
            VBanner(message: l10n.agendaLinkOnce, tone: VTone.warning),
            const SizedBox(height: VSpace.x2),
            Row(
              children: [
                Expanded(child: SelectableText(_url!, style: t.mono)),
                VIconButton(
                  icon: LucideIcons.copy,
                  tooltip: l10n.copy,
                  onPressed: () =>
                      unawaited(Clipboard.setData(ClipboardData(text: _url!))),
                ),
              ],
            ),
          ] else
            Text(
              _active ? l10n.agendaLinkActive : l10n.agendaLinkNone,
              style: t.small,
            ),
        ],
      ),
    );
  }
}
