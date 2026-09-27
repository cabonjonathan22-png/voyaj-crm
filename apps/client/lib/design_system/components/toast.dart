import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_theme.dart';
import '../tokens/colors.dart';
import '../tokens/dimensions.dart';
import 'button.dart';

/// Notification éphémère.
@immutable
final class VToast {
  const VToast(
    this.message, {
    this.tone = VTone.neutral,
    this.description,
    this.duration = const Duration(seconds: 4),
  });

  final String message;
  final String? description;
  final VTone tone;
  final Duration duration;
}

/// File des toasts affichés en bas à droite.
final class ToastController extends ChangeNotifier {
  final _toasts = <(int, VToast)>[];
  final _timers = <int, Timer>{};
  var _nextId = 0;

  List<(int, VToast)> get toasts => List.unmodifiable(_toasts);

  void show(VToast toast) {
    final id = _nextId++;
    _toasts.add((id, toast));
    if (_toasts.length > 4) dismiss(_toasts.first.$1);
    _timers[id] = Timer(toast.duration, () => dismiss(id));
    notifyListeners();
  }

  void success(String message, {String? description}) =>
      show(VToast(message, tone: VTone.success, description: description));

  void error(String message, {String? description}) => show(
    VToast(
      message,
      tone: VTone.danger,
      description: description,
      duration: const Duration(seconds: 7),
    ),
  );

  void info(String message, {String? description}) =>
      show(VToast(message, description: description));

  void dismiss(int id) {
    _timers.remove(id)?.cancel();
    _toasts.removeWhere((t) => t.$1 == id);
    notifyListeners();
  }

  @override
  void dispose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    super.dispose();
  }
}

/// Zone d'affichage des toasts, à placer au-dessus de l'application.
///
/// Les toasts ont leur propre [Overlay] : placés hors du navigateur, leurs
/// infobulles (bouton de fermeture) en ont besoin.
class ToastHost extends StatefulWidget {
  const ToastHost({super.key, required this.controller, required this.child});

  final ToastController controller;
  final Widget child;

  @override
  State<ToastHost> createState() => _ToastHostState();
}

class _ToastHostState extends State<ToastHost> {
  late final _entry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned(
          right: VSpace.x5,
          bottom: VSpace.x5,
          child: ListenableBuilder(
            listenable: widget.controller,
            builder: (context, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final (id, toast) in widget.controller.toasts)
                  _ToastCard(
                    key: ValueKey(id),
                    toast: toast,
                    onClose: () => widget.controller.dismiss(id),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  @override
  void dispose() {
    _entry
      ..remove()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      widget.child,
      Positioned.fill(child: Overlay(initialEntries: [_entry])),
    ],
  );
}

class _ToastCard extends StatelessWidget {
  const _ToastCard({super.key, required this.toast, required this.onClose});

  final VToast toast;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final icon = switch (toast.tone) {
      VTone.success => LucideIcons.circleCheck,
      VTone.danger => LucideIcons.circleAlert,
      VTone.warning => LucideIcons.triangleAlert,
      _ => LucideIcons.info,
    };
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: VMotion.normal,
      curve: VMotion.emphasized,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 12 * (1 - v)),
          child: child,
        ),
      ),
      child: Container(
        width: 340,
        margin: const EdgeInsets.only(top: VSpace.x2),
        padding: const EdgeInsets.fromLTRB(
          VSpace.x3,
          VSpace.x3,
          VSpace.x1,
          VSpace.x3,
        ),
        decoration: BoxDecoration(
          color: c.surfaceRaised,
          borderRadius: VRadius.mdAll,
          border: Border.all(color: c.border),
          boxShadow: VShadows.lg(dark: c.isDark),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(icon, size: 16, color: c.toneColor(toast.tone)),
              ),
              const SizedBox(width: VSpace.x2 + 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(toast.message, style: t.bodyStrong),
                    if (toast.description != null) ...[
                      const SizedBox(height: 2),
                      Text(toast.description!, style: t.small),
                    ],
                  ],
                ),
              ),
              VIconButton(
                icon: LucideIcons.x,
                tooltip: 'Fermer',
                size: VButtonSize.sm,
                onPressed: onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
