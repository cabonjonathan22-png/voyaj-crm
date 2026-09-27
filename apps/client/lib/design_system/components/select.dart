import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';
import 'pressable.dart';

/// Option d'un [VSelect].
@immutable
final class VSelectOption<T> {
  const VSelectOption(this.value, this.label, {this.icon, this.leading});

  final T value;
  final String label;
  final IconData? icon;
  final Widget? leading;
}

/// Liste déroulante.
class VSelect<T> extends StatelessWidget {
  const VSelect({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.label,
    this.placeholder = 'Choisir…',
    this.width,
  });

  final T? value;
  final List<VSelectOption<T>> options;
  final ValueChanged<T>? onChanged;
  final String? label;
  final String placeholder;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final selected = options.where((o) => o.value == value).firstOrNull;

    final anchor = MenuAnchor(
      alignmentOffset: const Offset(0, 4),
      menuChildren: [
        for (final option in options)
          MenuItemButton(
            leadingIcon:
                option.leading ??
                (option.icon != null ? Icon(option.icon) : null),
            trailingIcon: option.value == value
                ? Icon(LucideIcons.check, size: 14, color: c.accentText)
                : null,
            onPressed: () => onChanged?.call(option.value),
            child: Text(option.label),
          ),
      ],
      builder: (context, controller, _) => Pressable(
        onPressed: onChanged == null
            ? null
            : () => controller.isOpen ? controller.close() : controller.open(),
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          width: width,
          height: VSize.controlMd,
          padding: const EdgeInsets.symmetric(horizontal: VSpace.x2 + 2),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: VRadius.smAll,
            border: Border.all(
              color: s.focused || controller.isOpen
                  ? c.accent
                  : s.hovered
                  ? c.borderStrong
                  : c.border,
            ),
          ),
          child: Row(
            mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
            children: [
              if (selected?.leading != null) ...[
                selected!.leading!,
                const SizedBox(width: VSpace.x2),
              ] else if (selected?.icon != null) ...[
                Icon(selected!.icon, size: 15, color: c.textMuted),
                const SizedBox(width: VSpace.x2),
              ],
              Flexible(
                fit: width == null ? FlexFit.loose : FlexFit.tight,
                child: Text(
                  selected?.label ?? placeholder,
                  overflow: TextOverflow.ellipsis,
                  style: t.body.copyWith(
                    color: selected == null ? c.textSubtle : c.text,
                  ),
                ),
              ),
              const SizedBox(width: VSpace.x2),
              Icon(LucideIcons.chevronsUpDown, size: 14, color: c.textSubtle),
            ],
          ),
        ),
      ),
    );

    if (label == null) return anchor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label!, style: t.label),
        const SizedBox(height: VSpace.x1_5),
        anchor,
      ],
    );
  }
}

/// Contrôle segmenté (choix exclusif parmi quelques options visibles).
class VSegmented<T> extends StatelessWidget {
  const VSegmented({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final T value;
  final List<VSelectOption<T>> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: c.backgroundSubtle,
        borderRadius: VRadius.smAll,
        border: Border.all(color: c.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final option in options)
            Pressable(
              onPressed: () => onChanged(option.value),
              builder: (context, s) {
                final active = option.value == value;
                return AnimatedContainer(
                  duration: VMotion.fast,
                  height: VSize.controlSm - 2,
                  padding: const EdgeInsets.symmetric(horizontal: VSpace.x3),
                  decoration: BoxDecoration(
                    color: active
                        ? c.surface
                        : s.hovered
                        ? c.surfaceHover
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(VRadius.sm - 1),
                    boxShadow: active ? VShadows.sm(dark: c.isDark) : null,
                    border: s.focused
                        ? Border.all(color: c.focusRing, width: 2)
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (option.icon != null) ...[
                        Icon(
                          option.icon,
                          size: 14,
                          color: active ? c.text : c.textMuted,
                        ),
                        const SizedBox(width: VSpace.x1_5),
                      ],
                      Text(
                        option.label,
                        style: context.text.bodyStrong.copyWith(
                          color: active ? c.text : c.textMuted,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
