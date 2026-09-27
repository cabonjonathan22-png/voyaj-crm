import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/dimensions.dart';
import '../tokens/typography.dart';

/// Extension de thème portant les tokens Voyaj.
@immutable
final class VTheme extends ThemeExtension<VTheme> {
  const VTheme(this.colors);

  final VColors colors;

  VTypography get text => VTypography(colors.text, colors.textMuted);

  @override
  VTheme copyWith({VColors? colors}) => VTheme(colors ?? this.colors);

  @override
  VTheme lerp(covariant VTheme? other, double t) =>
      other == null ? this : VTheme(VColors.lerp(colors, other.colors, t));
}

/// Accès rapide aux tokens depuis le contexte.
extension VThemeContext on BuildContext {
  VTheme get vTheme => Theme.of(this).extension<VTheme>()!;
  VColors get colors => vTheme.colors;
  VTypography get text => vTheme.text;
}

/// Construit le [ThemeData] Material à partir des tokens, pour que les
/// widgets Material restants (sélection de texte, barres de défilement,
/// infobulles…) restent cohérents avec le design system.
ThemeData buildTheme(VColors c) {
  final t = VTypography(c.text, c.textMuted);
  final scheme = ColorScheme(
    brightness: c.brightness,
    primary: c.accent,
    onPrimary: c.textOnAccent,
    secondary: c.accent,
    onSecondary: c.textOnAccent,
    error: c.danger,
    onError: c.textOnAccent,
    surface: c.surface,
    onSurface: c.text,
    surfaceContainerHighest: c.surfaceHover,
    outline: c.border,
    outlineVariant: c.borderSubtle,
  );
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: fontFamily,
    brightness: c.brightness,
    visualDensity: VisualDensity.compact,
  );
  return base.copyWith(
    extensions: [VTheme(c)],
    scaffoldBackgroundColor: c.background,
    canvasColor: c.background,
    dividerColor: c.border,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: c.surfaceHover,
    focusColor: c.focusRing,
    textTheme: base.textTheme.apply(
      fontFamily: fontFamily,
      bodyColor: c.text,
      displayColor: c.text,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: c.accent,
      selectionColor: c.accent.withValues(alpha: 0.28),
      selectionHandleColor: c.accent,
    ),
    tooltipTheme: TooltipThemeData(
      waitDuration: const Duration(milliseconds: 450),
      textStyle: t.caption.copyWith(color: c.isDark ? c.text : Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: c.isDark ? const Color(0xFF2C2C33) : const Color(0xFF232329),
        borderRadius: VRadius.smAll,
        border: c.isDark ? Border.all(color: c.borderStrong) : null,
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: const WidgetStatePropertyAll(8),
      radius: const Radius.circular(8),
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.hovered)
            ? c.textSubtle
            : c.borderStrong,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(color: c.borderStrong, width: 1.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? c.accent : c.surface,
      ),
      checkColor: WidgetStatePropertyAll(c.textOnAccent),
    ),
    switchTheme: SwitchThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      thumbColor: const WidgetStatePropertyAll(Colors.white),
      trackColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? c.accent : c.borderStrong,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: c.accent,
      linearTrackColor: c.accentSubtle,
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(c.surfaceRaised),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(8),
        shadowColor: WidgetStatePropertyAll(
          Colors.black.withValues(alpha: c.isDark ? 0.5 : 0.18),
        ),
        side: WidgetStatePropertyAll(BorderSide(color: c.border)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: VRadius.mdAll),
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(4)),
      ),
    ),
    menuButtonTheme: MenuButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(t.body),
        foregroundColor: WidgetStatePropertyAll(c.text),
        iconColor: WidgetStatePropertyAll(c.textMuted),
        iconSize: const WidgetStatePropertyAll(16),
        minimumSize: const WidgetStatePropertyAll(Size(180, 32)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: VRadius.smAll),
        ),
        overlayColor: WidgetStatePropertyAll(c.surfaceHover),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: c.surfaceRaised,
      surfaceTintColor: Colors.transparent,
      barrierColor: c.scrim,
    ),
  );
}
