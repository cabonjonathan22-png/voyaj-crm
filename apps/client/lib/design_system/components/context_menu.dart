import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'kbd.dart';

/// Entrée d'un menu contextuel.
@immutable
final class VMenuItem {
  const VMenuItem({
    required this.label,
    required this.onSelected,
    this.icon,
    this.shortcut,
    this.destructive = false,
    this.dividerBefore = false,
  });

  final String label;
  final VoidCallback? onSelected;
  final IconData? icon;
  final String? shortcut;
  final bool destructive;
  final bool dividerBefore;
}

/// Construit les widgets Material d'un menu à partir de [items].
List<Widget> buildMenuItems(BuildContext context, List<VMenuItem> items) {
  final c = context.colors;
  return [
    for (final item in items) ...[
      if (item.dividerBefore) Divider(height: 9, color: c.borderSubtle),
      MenuItemButton(
        onPressed: item.onSelected,
        leadingIcon: item.icon == null
            ? null
            : Icon(item.icon, color: item.destructive ? c.danger : null),
        trailingIcon: item.shortcut == null ? null : Kbd(item.shortcut!),
        child: Text(
          item.label,
          style: item.destructive ? TextStyle(color: c.danger) : null,
        ),
      ),
    ],
  ];
}

/// Zone ouvrant un menu contextuel au clic droit.
class VContextMenuRegion extends StatefulWidget {
  const VContextMenuRegion({
    super.key,
    required this.items,
    required this.child,
    this.onOpen,
  });

  /// Entrées calculées à l'ouverture (l'état peut avoir changé).
  final List<VMenuItem> Function() items;
  final Widget child;
  final VoidCallback? onOpen;

  @override
  State<VContextMenuRegion> createState() => _VContextMenuRegionState();
}

class _VContextMenuRegionState extends State<VContextMenuRegion> {
  final _controller = MenuController();
  List<VMenuItem> _items = const [];

  @override
  Widget build(BuildContext context) => MenuAnchor(
    controller: _controller,
    menuChildren: buildMenuItems(context, _items),
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onSecondaryTapUp: (details) {
        widget.onOpen?.call();
        setState(() => _items = widget.items());
        _controller.open(position: details.localPosition);
      },
      child: widget.child,
    ),
  );
}
