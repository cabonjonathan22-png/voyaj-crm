import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../design_system/design_system.dart';

const _tableId = 'audit';
const _pageSize = 200;

/// Journal d'audit (lecture seule, chargement par pages).
class AuditPage extends ConsumerStatefulWidget {
  const AuditPage({super.key});

  @override
  ConsumerState<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends ConsumerState<AuditPage> {
  final List<AuditEntry> _entries = [];
  bool _loading = false;
  bool _done = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_loadMore());
  }

  Future<void> _loadMore() async {
    if (_loading || _done) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final before = _entries.isEmpty ? '' : '&before=${_entries.last.id}';
      final json = await ref
          .read(apiClientProvider)!
          .get('/api/v1/audit?limit=$_pageSize$before');
      final page = [
        for (final e in json! as List<dynamic>)
          AuditEntry.fromJson(e as Map<String, dynamic>),
      ];
      setState(() {
        _entries.addAll(page);
        _done = page.length < _pageSize;
      });
    } on ApiFailure catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final view = ref.watch(tableViewProvider(_tableId));
    final columns = <VColumn<AuditEntry>>[
      VColumn(
        id: 'date',
        label: l10n.auditDate,
        width: 160,
        sortValue: (e) => e.occurredAt,
        cell: (context, e) =>
            Text(formatDateTime(e.occurredAt), style: context.text.numeric),
      ),
      VColumn(
        id: 'actor',
        label: l10n.auditActor,
        width: 180,
        sortValue: (e) => e.actorName ?? '',
        filterValue: (e) => e.actorName,
        cell: (context, e) => Text(e.actorName ?? l10n.auditSystem),
      ),
      VColumn(
        id: 'action',
        label: l10n.auditAction,
        width: 220,
        sortValue: (e) => e.action,
        filterValue: (e) => e.action,
        cell: (context, e) => Text(e.action, style: context.text.mono),
      ),
      VColumn(
        id: 'entity',
        label: l10n.auditEntity,
        width: 140,
        filterValue: (e) => e.entity,
        cell: (context, e) => Text(e.entity ?? ''),
      ),
      VColumn(
        id: 'details',
        label: l10n.auditDetails,
        width: 260,
        flex: true,
        filterValue: (e) => jsonEncode(e.payload),
        cell: (context, e) => Text(
          e.payload.isEmpty ? '' : jsonEncode(e.payload),
          style: context.text.small,
        ),
      ),
      VColumn(
        id: 'ip',
        label: 'IP',
        width: 120,
        filterValue: (e) => e.ip,
        cell: (context, e) => Text(e.ip ?? '', style: context.text.small),
      ),
    ];

    return Column(
      children: [
        PageHeader(
          title: l10n.navAudit,
          subtitle: l10n.auditSubtitle,
          icon: LucideIcons.scrollText,
          actions: [
            if (!_done)
              VButton(
                label: l10n.loadMore,
                loading: _loading,
                onPressed: _loadMore,
              ),
          ],
        ),
        VTableToolbar<AuditEntry>(
          columns: columns,
          view: view,
          onViewChanged: ref.read(tableViewProvider(_tableId).notifier).set,
          savedViews: ref.watch(savedViewsProvider(_tableId)),
          onSavedViewsChanged: ref
              .read(savedViewsProvider(_tableId).notifier)
              .set,
          resultCount: _entries.length,
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(VSpace.x4),
            child: VBanner(message: _error!, tone: VTone.danger),
          ),
        Expanded(
          child: _entries.isEmpty && _loading
              ? const SkeletonRows()
              : VDataTable<AuditEntry>(
                  rows: applyTableView(_entries, columns, view),
                  columns: columns,
                  rowId: (e) => '${e.id}',
                  view: view,
                  onViewChanged: ref
                      .read(tableViewProvider(_tableId).notifier)
                      .set,
                ),
        ),
      ],
    );
  }
}
