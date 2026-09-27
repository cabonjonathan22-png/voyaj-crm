import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';
import 'button.dart';
import 'modal.dart';
import 'pressable.dart';
import 'select.dart';
import 'text_field.dart';

/// Minuscules sans accents (recherche tolérante).
String _fold(String text) {
  const from = 'àâäáãçéèêëîïíìôöóòõùûüúÿñ';
  const to = 'aaaaaceeeeiiiiooooouuuuyn';
  final buffer = StringBuffer();
  for (final char in text.toLowerCase().split('')) {
    final i = from.indexOf(char);
    buffer.write(i < 0 ? char : to[i]);
  }
  return buffer.toString();
}

/// Choix d'un élément parmi une longue liste, avec recherche (modale).
/// Retourne l'option choisie, ou `null` si annulé.
Future<VSelectOption<T>?> showSearchPicker<T>(
  BuildContext context, {
  required String title,
  required List<VSelectOption<T>> options,
  String? subtitle,
  String Function(VSelectOption<T> option)? searchText,
}) => showVModal<VSelectOption<T>>(
  context,
  builder: (context) => _SearchPicker<T>(
    title: title,
    subtitle: subtitle,
    options: options,
    searchText: searchText,
  ),
);

class _SearchPicker<T> extends StatefulWidget {
  const _SearchPicker({
    required this.title,
    required this.options,
    this.subtitle,
    this.searchText,
  });

  final String title;
  final String? subtitle;
  final List<VSelectOption<T>> options;
  final String Function(VSelectOption<T> option)? searchText;

  @override
  State<_SearchPicker<T>> createState() => _SearchPickerState<T>();
}

class _SearchPickerState<T> extends State<_SearchPicker<T>> {
  static const _maxShown = 60;
  final _query = TextEditingController();
  int _selected = 0;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  List<VSelectOption<T>> get _results {
    final words = _fold(
      _query.text,
    ).split(' ').where((w) => w.isNotEmpty).toList();
    final matches = words.isEmpty
        ? widget.options
        : widget.options.where((o) {
            final text = _fold(widget.searchText?.call(o) ?? o.label);
            return words.every(text.contains);
          });
    return matches.take(_maxShown).toList();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final results = _results;
    if (_selected >= results.length) _selected = 0;

    return VModal(
      title: widget.title,
      description: widget.subtitle,
      width: 520,
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.arrowDown): () => setState(
            () => _selected = results.isEmpty
                ? 0
                : (_selected + 1) % results.length,
          ),
          const SingleActivator(LogicalKeyboardKey.arrowUp): () => setState(
            () => _selected = results.isEmpty
                ? 0
                : (_selected - 1) % results.length,
          ),
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VTextField(
              controller: _query,
              autofocus: true,
              prefixIcon: LucideIcons.search,
              hint: 'Rechercher…',
              onChanged: (_) => setState(() => _selected = 0),
              onSubmitted: (_) {
                if (results.isNotEmpty) {
                  Navigator.of(context).pop(results[_selected]);
                }
              },
            ),
            const SizedBox(height: VSpace.x2),
            SizedBox(
              height: 320,
              child: results.isEmpty
                  ? Center(child: Text('Aucun résultat', style: t.small))
                  : ListView.builder(
                      itemCount: results.length,
                      itemExtent: 34,
                      itemBuilder: (context, i) {
                        final option = results[i];
                        return Pressable(
                          onPressed: () => Navigator.of(context).pop(option),
                          semanticLabel: option.label,
                          builder: (context, s) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: VSpace.x2,
                            ),
                            decoration: BoxDecoration(
                              color: i == _selected || s.hovered
                                  ? c.surfaceHover
                                  : Colors.transparent,
                              borderRadius: VRadius.smAll,
                            ),
                            child: Row(
                              children: [
                                if (option.leading != null) ...[
                                  option.leading!,
                                  const SizedBox(width: VSpace.x2),
                                ] else if (option.icon != null) ...[
                                  Icon(
                                    option.icon,
                                    size: 14,
                                    color: c.textMuted,
                                  ),
                                  const SizedBox(width: VSpace.x2),
                                ],
                                Expanded(
                                  child: Text(
                                    option.label,
                                    overflow: TextOverflow.ellipsis,
                                    style: t.body,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Champ de sélection dans une longue liste (ouvre [showSearchPicker]).
class VSearchSelect<T> extends StatelessWidget {
  const VSearchSelect({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.label,
    this.placeholder = 'Choisir…',
    this.error,
    this.clearable = true,
  });

  final T? value;
  final List<VSelectOption<T>> options;

  /// `null` : champ en lecture seule.
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String placeholder;
  final String? error;
  final bool clearable;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final selected = options.where((o) => o.value == value).firstOrNull;

    Future<void> pick() async {
      final option = await showSearchPicker<T>(
        context,
        title: label ?? placeholder,
        options: options,
      );
      if (option != null) onChanged?.call(option.value);
    }

    final field = Pressable(
      onPressed: onChanged == null ? null : pick,
      semanticLabel: label,
      builder: (context, s) => AnimatedContainer(
        duration: VMotion.fast,
        height: VSize.controlMd,
        padding: const EdgeInsets.only(left: VSpace.x2 + 2, right: VSpace.x1),
        decoration: BoxDecoration(
          color: onChanged == null ? c.backgroundSubtle : c.surface,
          borderRadius: VRadius.smAll,
          border: Border.all(
            color: error != null
                ? c.danger
                : s.focused
                ? c.accent
                : s.hovered
                ? c.borderStrong
                : c.border,
          ),
        ),
        child: Row(
          children: [
            if (selected?.leading != null) ...[
              selected!.leading!,
              const SizedBox(width: VSpace.x2),
            ] else if (selected?.icon != null) ...[
              Icon(selected!.icon, size: 14, color: c.textMuted),
              const SizedBox(width: VSpace.x2),
            ],
            Expanded(
              child: Text(
                selected?.label ?? placeholder,
                overflow: TextOverflow.ellipsis,
                style: t.body.copyWith(
                  color: selected == null ? c.textSubtle : c.text,
                ),
              ),
            ),
            if (clearable && selected != null && onChanged != null)
              VIconButton(
                icon: LucideIcons.x,
                tooltip: 'Effacer',
                size: VButtonSize.sm,
                onPressed: () => onChanged!(null),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: VSpace.x1),
                child: Icon(
                  LucideIcons.chevronsUpDown,
                  size: 14,
                  color: c.textSubtle,
                ),
              ),
          ],
        ),
      ),
    );

    if (label == null && error == null) return field;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: t.label),
          const SizedBox(height: VSpace.x1_5),
        ],
        field,
        if (error != null) ...[
          const SizedBox(height: VSpace.x1),
          Text(error!, style: t.small.copyWith(color: c.danger)),
        ],
      ],
    );
  }
}
