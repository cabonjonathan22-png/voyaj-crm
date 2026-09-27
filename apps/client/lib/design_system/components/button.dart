import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';
import 'kbd.dart';
import 'pressable.dart';
import 'spinner.dart';

enum VButtonVariant { primary, secondary, ghost, danger }

enum VButtonSize { sm, md, lg }

/// Bouton du design system.
class VButton extends StatelessWidget {
  const VButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = VButtonVariant.secondary,
    this.size = VButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.shortcut,
    this.loading = false,
    this.expand = false,
    this.autofocus = false,
    this.tooltip,
  });

  const VButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = VButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.shortcut,
    this.loading = false,
    this.expand = false,
    this.autofocus = false,
    this.tooltip,
  }) : variant = VButtonVariant.primary;

  const VButton.ghost({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = VButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.shortcut,
    this.loading = false,
    this.expand = false,
    this.autofocus = false,
    this.tooltip,
  }) : variant = VButtonVariant.ghost;

  const VButton.danger({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = VButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.shortcut,
    this.loading = false,
    this.expand = false,
    this.autofocus = false,
    this.tooltip,
  }) : variant = VButtonVariant.danger;

  final String label;
  final VoidCallback? onPressed;
  final VButtonVariant variant;
  final VButtonSize size;
  final IconData? icon;
  final IconData? trailingIcon;

  /// Raccourci affiché dans le bouton (ex. `Ctrl N`).
  final String? shortcut;
  final bool loading;
  final bool expand;
  final bool autofocus;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final height = switch (size) {
      VButtonSize.sm => VSize.controlSm,
      VButtonSize.md => VSize.controlMd,
      VButtonSize.lg => VSize.controlLg,
    };
    final padding = switch (size) {
      VButtonSize.sm => 10.0,
      VButtonSize.md => 12.0,
      VButtonSize.lg => 16.0,
    };
    final enabled = onPressed != null && !loading;

    Widget button = Pressable(
      onPressed: enabled ? onPressed : null,
      autofocus: autofocus,
      semanticLabel: label,
      builder: (context, s) {
        final (bg, fg, border) = switch (variant) {
          VButtonVariant.primary => (
            s.pressed || s.hovered ? c.accentHover : c.accent,
            c.textOnAccent,
            Colors.transparent,
          ),
          VButtonVariant.secondary => (
            s.pressed
                ? c.surfaceSelected
                : s.hovered
                ? c.surfaceHover
                : c.surface,
            c.text,
            c.border,
          ),
          VButtonVariant.ghost => (
            s.pressed || s.hovered ? c.surfaceHover : Colors.transparent,
            c.textMuted,
            Colors.transparent,
          ),
          VButtonVariant.danger => (
            s.pressed || s.hovered ? c.danger : c.dangerSubtle,
            s.pressed || s.hovered ? c.textOnAccent : c.danger,
            Colors.transparent,
          ),
        };
        final text = context.text.bodyStrong.copyWith(color: fg);
        return AnimatedOpacity(
          duration: VMotion.fast,
          opacity: s.enabled || loading ? 1 : 0.45,
          child: AnimatedContainer(
            duration: VMotion.fast,
            curve: VMotion.curve,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: padding),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: VRadius.smAll,
              border: Border.all(color: border),
              boxShadow: variant == VButtonVariant.secondary
                  ? VShadows.sm(dark: c.isDark)
                  : null,
            ),
            foregroundDecoration: s.focused
                ? BoxDecoration(
                    borderRadius: VRadius.smAll,
                    border: Border.all(color: c.focusRing, width: 2),
                  )
                : null,
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (loading)
                  Padding(
                    padding: const EdgeInsets.only(right: VSpace.x2),
                    child: VSpinner(size: 14, color: fg),
                  )
                else if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: VSpace.x1_5),
                    child: Icon(icon, size: 15, color: fg),
                  ),
                Flexible(
                  child: Text(
                    label,
                    style: text,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailingIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(left: VSpace.x1_5),
                    child: Icon(trailingIcon, size: 15, color: fg),
                  ),
                if (shortcut != null) ...[
                  const SizedBox(width: VSpace.x2),
                  Kbd(shortcut!, onAccent: variant == VButtonVariant.primary),
                ],
              ],
            ),
          ),
        );
      },
    );
    if (tooltip != null) button = Tooltip(message: tooltip, child: button);
    return button;
  }
}

/// Bouton icône seul (barres d'outils, en-têtes).
class VIconButton extends StatelessWidget {
  const VIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.size = VButtonSize.md,
    this.active = false,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final VButtonSize size;
  final bool active;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final extent = switch (size) {
      VButtonSize.sm => VSize.controlSm - 2,
      VButtonSize.md => VSize.controlMd,
      VButtonSize.lg => VSize.controlLg,
    };
    return Tooltip(
      message: tooltip,
      child: Pressable(
        onPressed: onPressed,
        semanticLabel: tooltip,
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          width: extent,
          height: extent,
          decoration: BoxDecoration(
            color: active
                ? c.surfaceSelected
                : s.hovered || s.pressed
                ? c.surfaceHover
                : Colors.transparent,
            borderRadius: VRadius.smAll,
            border: s.focused ? Border.all(color: c.focusRing, width: 2) : null,
          ),
          child: Icon(
            icon,
            size: size == VButtonSize.sm ? 15 : 17,
            color: !s.enabled
                ? c.textSubtle.withValues(alpha: 0.5)
                : color ?? (active ? c.accentText : c.textMuted),
          ),
        ),
      ),
    );
  }
}
