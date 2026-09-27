import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

/// Espacements (grille de 4 px).
abstract final class VSpace {
  static const double x0_5 = 2;
  static const double x1 = 4;
  static const double x1_5 = 6;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x5 = 20;
  static const double x6 = 24;
  static const double x8 = 32;
  static const double x10 = 40;
  static const double x12 = 48;
}

/// Rayons d'arrondi.
abstract final class VRadius {
  static const double xs = 4;
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlAll = BorderRadius.all(Radius.circular(xl));
}

/// Hauteurs de contrôles (boutons, champs, lignes de tableau).
abstract final class VSize {
  static const double controlSm = 28;
  static const double controlMd = 32;
  static const double controlLg = 38;
  static const double tableRow = 36;
  static const double tableHeader = 34;
  static const double sidebar = 232;
  static const double sidebarCollapsed = 56;
  static const double topBar = 48;
}

/// Durées et courbes d'animation (discrètes : l'interface ne doit jamais
/// faire attendre).
abstract final class VMotion {
  static const fast = Duration(milliseconds: 110);
  static const normal = Duration(milliseconds: 180);
  static const slow = Duration(milliseconds: 260);
  static const Curve curve = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeOutQuart;
}

/// Ombres portées.
abstract final class VShadows {
  static List<BoxShadow> sm({required bool dark}) => [
    BoxShadow(
      color: Color(dark ? 0x40000000 : 0x0D000000),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> md({required bool dark}) => [
    BoxShadow(
      color: Color(dark ? 0x59000000 : 0x14000000),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Color(dark ? 0x33000000 : 0x0A000000),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> lg({required bool dark}) => [
    BoxShadow(
      color: Color(dark ? 0x80000000 : 0x1F000000),
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
    BoxShadow(
      color: Color(dark ? 0x40000000 : 0x0F000000),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
}
