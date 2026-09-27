import 'package:flutter/material.dart';

/// Couleurs sémantiques de l'interface.
///
/// Les composants n'utilisent jamais de couleur « brute » : uniquement ces
/// rôles, déclinés en thème clair et sombre.
@immutable
final class VColors {
  const VColors({
    required this.brightness,
    required this.background,
    required this.backgroundSubtle,
    required this.surface,
    required this.surfaceRaised,
    required this.surfaceHover,
    required this.surfaceSelected,
    required this.border,
    required this.borderSubtle,
    required this.borderStrong,
    required this.text,
    required this.textMuted,
    required this.textSubtle,
    required this.textOnAccent,
    required this.accent,
    required this.accentHover,
    required this.accentSubtle,
    required this.accentText,
    required this.success,
    required this.successSubtle,
    required this.warning,
    required this.warningSubtle,
    required this.danger,
    required this.dangerSubtle,
    required this.info,
    required this.infoSubtle,
    required this.focusRing,
    required this.scrim,
  });

  final Brightness brightness;

  /// Fond de l'application (zone de contenu).
  final Color background;

  /// Fond de la barre latérale et des zones secondaires.
  final Color backgroundSubtle;

  /// Cartes, panneaux, tableaux.
  final Color surface;

  /// Menus, popovers, modales.
  final Color surfaceRaised;
  final Color surfaceHover;
  final Color surfaceSelected;

  final Color border;
  final Color borderSubtle;
  final Color borderStrong;

  final Color text;
  final Color textMuted;
  final Color textSubtle;
  final Color textOnAccent;

  final Color accent;
  final Color accentHover;
  final Color accentSubtle;
  final Color accentText;

  final Color success;
  final Color successSubtle;
  final Color warning;
  final Color warningSubtle;
  final Color danger;
  final Color dangerSubtle;
  final Color info;
  final Color infoSubtle;

  final Color focusRing;

  /// Voile derrière les modales.
  final Color scrim;

  bool get isDark => brightness == Brightness.dark;

  static const light = VColors(
    brightness: Brightness.light,
    background: Color(0xFFFFFFFF),
    backgroundSubtle: Color(0xFFF7F7F8),
    surface: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFFFFFFF),
    surfaceHover: Color(0xFFF2F2F4),
    surfaceSelected: Color(0xFFEDEDFC),
    border: Color(0xFFE4E4E7),
    borderSubtle: Color(0xFFEFEFF1),
    borderStrong: Color(0xFFD1D1D6),
    text: Color(0xFF18181B),
    textMuted: Color(0xFF52525B),
    textSubtle: Color(0xFF8B8B94),
    textOnAccent: Color(0xFFFFFFFF),
    accent: Color(0xFF5B5BD6),
    accentHover: Color(0xFF4B4BC4),
    accentSubtle: Color(0xFFEEEEFD),
    accentText: Color(0xFF4545BF),
    success: Color(0xFF16A34A),
    successSubtle: Color(0xFFEAF8EF),
    warning: Color(0xFFD97706),
    warningSubtle: Color(0xFFFEF5E7),
    danger: Color(0xFFDC2626),
    dangerSubtle: Color(0xFFFDEEEE),
    info: Color(0xFF0284C7),
    infoSubtle: Color(0xFFEAF5FC),
    focusRing: Color(0x805B5BD6),
    scrim: Color(0x66000000),
  );

  static const dark = VColors(
    brightness: Brightness.dark,
    background: Color(0xFF0F0F11),
    backgroundSubtle: Color(0xFF141417),
    surface: Color(0xFF17171A),
    surfaceRaised: Color(0xFF1E1E22),
    surfaceHover: Color(0xFF222227),
    surfaceSelected: Color(0xFF25254A),
    border: Color(0xFF2A2A30),
    borderSubtle: Color(0xFF212126),
    borderStrong: Color(0xFF3A3A42),
    text: Color(0xFFEDEDEF),
    textMuted: Color(0xFFA1A1AA),
    textSubtle: Color(0xFF71717A),
    textOnAccent: Color(0xFFFFFFFF),
    accent: Color(0xFF6B6BEF),
    accentHover: Color(0xFF7D7DF4),
    accentSubtle: Color(0xFF23233F),
    accentText: Color(0xFFA9A9FA),
    success: Color(0xFF22C55E),
    successSubtle: Color(0xFF13261A),
    warning: Color(0xFFF59E0B),
    warningSubtle: Color(0xFF2A2113),
    danger: Color(0xFFEF4444),
    dangerSubtle: Color(0xFF2C1616),
    info: Color(0xFF38BDF8),
    infoSubtle: Color(0xFF12222C),
    focusRing: Color(0x996B6BEF),
    scrim: Color(0x99000000),
  );

  static VColors lerp(VColors a, VColors b, double t) {
    Color c(Color x, Color y) => Color.lerp(x, y, t)!;
    return VColors(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      background: c(a.background, b.background),
      backgroundSubtle: c(a.backgroundSubtle, b.backgroundSubtle),
      surface: c(a.surface, b.surface),
      surfaceRaised: c(a.surfaceRaised, b.surfaceRaised),
      surfaceHover: c(a.surfaceHover, b.surfaceHover),
      surfaceSelected: c(a.surfaceSelected, b.surfaceSelected),
      border: c(a.border, b.border),
      borderSubtle: c(a.borderSubtle, b.borderSubtle),
      borderStrong: c(a.borderStrong, b.borderStrong),
      text: c(a.text, b.text),
      textMuted: c(a.textMuted, b.textMuted),
      textSubtle: c(a.textSubtle, b.textSubtle),
      textOnAccent: c(a.textOnAccent, b.textOnAccent),
      accent: c(a.accent, b.accent),
      accentHover: c(a.accentHover, b.accentHover),
      accentSubtle: c(a.accentSubtle, b.accentSubtle),
      accentText: c(a.accentText, b.accentText),
      success: c(a.success, b.success),
      successSubtle: c(a.successSubtle, b.successSubtle),
      warning: c(a.warning, b.warning),
      warningSubtle: c(a.warningSubtle, b.warningSubtle),
      danger: c(a.danger, b.danger),
      dangerSubtle: c(a.dangerSubtle, b.dangerSubtle),
      info: c(a.info, b.info),
      infoSubtle: c(a.infoSubtle, b.infoSubtle),
      focusRing: c(a.focusRing, b.focusRing),
      scrim: c(a.scrim, b.scrim),
    );
  }
}

/// Tonalités sémantiques (badges, toasts, bannières).
enum VTone { neutral, accent, success, warning, danger, info }

extension VToneColors on VColors {
  Color toneColor(VTone tone) => switch (tone) {
    VTone.neutral => textMuted,
    VTone.accent => accentText,
    VTone.success => success,
    VTone.warning => warning,
    VTone.danger => danger,
    VTone.info => info,
  };

  Color toneBackground(VTone tone) => switch (tone) {
    VTone.neutral => surfaceHover,
    VTone.accent => accentSubtle,
    VTone.success => successSubtle,
    VTone.warning => warningSubtle,
    VTone.danger => dangerSubtle,
    VTone.info => infoSubtle,
  };
}
