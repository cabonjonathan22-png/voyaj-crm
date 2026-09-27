import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../design_system/design_system.dart';
import '../../features/crm/search_index.dart';
import 'commands.dart';
import 'fuzzy.dart';

/// Ouvre la palette de commandes (Ctrl+K).
Future<void> showCommandPalette(BuildContext context) async {
  final command = await showGeneralDialog<AppCommand>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Fermer',
    barrierColor: context.colors.scrim.withValues(alpha: 0.25),
    transitionDuration: VMotion.fast,
    pageBuilder: (_, _, _) => const _CommandPalette(),
    transitionBuilder: (context, animation, _, child) => FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween(
          begin: 0.98,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: VMotion.curve)),
        child: child,
      ),
    ),
  );
  if (command != null && context.mounted) {
    command.run(
      context,
      ProviderScope.containerOf(context, listen: false).read,
    );
  }
}

class _CommandPalette extends ConsumerStatefulWidget {
  const _CommandPalette();

  @override
  ConsumerState<_CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends ConsumerState<_CommandPalette> {
  final _query = TextEditingController();
  final _scroll = ScrollController();
  int _selected = 0;

  static const _rowHeight = 38.0;
  static const _maxRecords = 8;

  @override
  void dispose() {
    _query.dispose();
    _scroll.dispose();
    super.dispose();
  }

  List<AppCommand> _results(List<AppCommand> all, List<SearchEntry> index) {
    final query = _query.text;
    if (query.trim().isEmpty) {
      return all.where((c) => c.group != CommandGroup.records).toList();
    }
    final records = searchRecords(index, query, limit: _maxRecords);
    final scored = <(AppCommand, int)>[];
    for (final command in all) {
      final score = [
        fuzzyScore(query, command.label),
        if (command.keywords.isNotEmpty)
          (fuzzyScore(query, command.keywords) ?? -10000) - 200,
      ].whereType<int>().fold<int?>(null, (a, b) => a == null || b > a ? b : a);
      if (score != null && score > -1000) scored.add((command, score));
    }
    scored.sort((a, b) => b.$2.compareTo(a.$2));
    return [for (final (command, _) in scored) command, ...records];
  }

  void _move(int delta, int count) {
    if (count == 0) return;
    setState(() => _selected = (_selected + delta) % count);
    final offset = _selected * _rowHeight;
    if (_scroll.hasClients) {
      final view = _scroll.position.viewportDimension;
      if (offset < _scroll.offset) {
        _scroll.jumpTo(offset);
      } else if (offset + _rowHeight > _scroll.offset + view) {
        _scroll.jumpTo(offset + _rowHeight - view);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final results = _results(
      ref.watch(commandsProvider),
      ref.watch(searchIndexProvider),
    );
    if (_selected >= results.length) _selected = 0;

    return Align(
      alignment: const Alignment(0, -0.55),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: 620,
          constraints: const BoxConstraints(maxHeight: 460),
          decoration: BoxDecoration(
            color: c.surfaceRaised,
            borderRadius: VRadius.lgAll,
            border: Border.all(color: c.border),
            boxShadow: VShadows.lg(dark: c.isDark),
          ),
          child: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
                  _move(1, results.length),
              const SingleActivator(LogicalKeyboardKey.arrowUp): () =>
                  _move(-1, results.length),
              const SingleActivator(LogicalKeyboardKey.escape): () =>
                  Navigator.of(context).pop(),
              const SingleActivator(LogicalKeyboardKey.enter): () {
                if (results.isNotEmpty) {
                  Navigator.of(context).pop(results[_selected]);
                }
              },
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: VSpace.x4),
                  child: Row(
                    children: [
                      Icon(LucideIcons.search, size: 17, color: c.textSubtle),
                      const SizedBox(width: VSpace.x3),
                      Expanded(
                        child: TextField(
                          controller: _query,
                          autofocus: true,
                          style: t.body.copyWith(fontSize: 15),
                          cursorWidth: 1.5,
                          onChanged: (_) => setState(() => _selected = 0),
                          decoration: InputDecoration(
                            hintText:
                                'Rechercher une commande, une page, un tag…',
                            hintStyle: t.body.copyWith(
                              fontSize: 15,
                              color: c.textSubtle,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: VSpace.x4,
                            ),
                          ),
                        ),
                      ),
                      const Kbd('Échap'),
                    ],
                  ),
                ),
                Divider(height: 1, color: c.border),
                Flexible(
                  child: results.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(VSpace.x8),
                          child: Text('Aucun résultat', style: t.small),
                        )
                      : ListView.builder(
                          controller: _scroll,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(VSpace.x1_5),
                          itemCount: results.length,
                          itemExtent: _rowHeight,
                          itemBuilder: (context, index) {
                            final command = results[index];
                            final showGroup =
                                index == 0 ||
                                results[index - 1].group != command.group;
                            return _CommandRow(
                              command: command,
                              selected: index == _selected,
                              groupLabel: showGroup
                                  ? command.group.label
                                  : null,
                              onHover: () => setState(() => _selected = index),
                              onTap: () => Navigator.of(context).pop(command),
                            );
                          },
                        ),
                ),
                Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: VSpace.x4),
                  decoration: BoxDecoration(
                    color: c.backgroundSubtle,
                    border: Border(top: BorderSide(color: c.border)),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(VRadius.lg),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Kbd('↑ ↓'),
                      const SizedBox(width: VSpace.x1_5),
                      Text('naviguer', style: t.small),
                      const SizedBox(width: VSpace.x4),
                      const Kbd('Entrée'),
                      const SizedBox(width: VSpace.x1_5),
                      Text('exécuter', style: t.small),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommandRow extends StatelessWidget {
  const _CommandRow({
    required this.command,
    required this.selected,
    required this.groupLabel,
    required this.onHover,
    required this.onTap,
  });

  final AppCommand command;
  final bool selected;
  final String? groupLabel;
  final VoidCallback onHover;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return MouseRegion(
      onHover: (_) => onHover(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: VSpace.x3),
          decoration: BoxDecoration(
            color: selected ? c.surfaceHover : Colors.transparent,
            borderRadius: VRadius.smAll,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 22,
                child: Center(
                  child:
                      command.leading ??
                      Icon(
                        command.icon,
                        size: 16,
                        color: selected ? c.text : c.textMuted,
                      ),
                ),
              ),
              const SizedBox(width: VSpace.x2 + 2),
              Flexible(
                child: Text(
                  command.label,
                  overflow: TextOverflow.ellipsis,
                  style: t.body.copyWith(color: c.text),
                ),
              ),
              if (command.subtitle != null) ...[
                const SizedBox(width: VSpace.x2),
                Flexible(
                  child: Text(
                    command.subtitle!,
                    overflow: TextOverflow.ellipsis,
                    style: t.small.copyWith(color: c.textSubtle),
                  ),
                ),
              ],
              const Spacer(),
              if (groupLabel != null)
                Text(
                  groupLabel!,
                  style: t.caption.copyWith(color: c.textSubtle),
                ),
              if (command.shortcut != null) ...[
                const SizedBox(width: VSpace.x3),
                Kbd(command.shortcut!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
