import 'package:flutter/material.dart';

/// Police de l'interface (embarquée : fonctionne hors ligne).
const fontFamily = 'Inter';

/// Échelle typographique (base 13 px, densité « application de bureau »).
@immutable
final class VTypography {
  const VTypography(this.color, this.muted);

  final Color color;
  final Color muted;

  static const _features = [FontFeature('cv11'), FontFeature('ss01')];

  TextStyle _style(
    double size,
    FontWeight weight, {
    double height = 1.4,
    double letterSpacing = 0,
    Color? color,
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: letterSpacing,
    color: color ?? this.color,
    fontFeatures: _features,
  );

  /// Titre de page.
  TextStyle get display =>
      _style(24, FontWeight.w600, height: 1.25, letterSpacing: -0.4);

  /// Titre de section / modale.
  TextStyle get title =>
      _style(17, FontWeight.w600, height: 1.3, letterSpacing: -0.2);

  /// Sous-titre, en-tête de carte.
  TextStyle get heading => _style(14, FontWeight.w600, letterSpacing: -0.1);

  /// Texte courant.
  TextStyle get body => _style(13, FontWeight.w400);

  /// Texte courant accentué.
  TextStyle get bodyStrong => _style(13, FontWeight.w500);

  /// Texte secondaire.
  TextStyle get small => _style(12, FontWeight.w400, color: muted);

  /// Libellés de champs, en-têtes de colonnes.
  TextStyle get label => _style(12, FontWeight.w500, color: muted);

  /// Micro-texte (badges, raccourcis).
  TextStyle get caption =>
      _style(11, FontWeight.w500, height: 1.2, letterSpacing: 0.1);

  /// Chiffres alignés (tableaux, montants).
  TextStyle get numeric => body.copyWith(
    fontFeatures: const [..._features, FontFeature.tabularFigures()],
  );

  /// Code, identifiants, secrets.
  TextStyle get mono => const TextStyle(
    fontFamily: 'Consolas',
    fontFamilyFallback: ['Cascadia Mono', 'Menlo', 'monospace'],
    fontSize: 12.5,
  ).copyWith(color: color);
}
