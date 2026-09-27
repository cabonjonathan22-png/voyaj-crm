import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// États d'interaction transmis au constructeur visuel.
@immutable
final class PressState {
  const PressState({
    required this.hovered,
    required this.pressed,
    required this.focused,
    required this.enabled,
  });

  final bool hovered;
  final bool pressed;
  final bool focused;
  final bool enabled;
}

/// Primitive interactive commune (boutons, lignes, éléments de menu) :
/// survol, appui, focus clavier (Entrée / Espace), curseur, sémantique.
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.builder,
    this.onPressed,
    this.onSecondaryTapUp,
    this.onDoubleTap,
    this.focusNode,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.semanticLabel,
    this.cursor = SystemMouseCursors.click,
  });

  final Widget Function(BuildContext context, PressState state) builder;
  final VoidCallback? onPressed;
  final GestureTapUpCallback? onSecondaryTapUp;
  final VoidCallback? onDoubleTap;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool canRequestFocus;
  final String? semanticLabel;
  final MouseCursor cursor;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _hovered = false;
  bool _pressed = false;
  bool _focused = false;

  bool get _enabled => widget.onPressed != null;

  void _activate() {
    if (_enabled) widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    final state = PressState(
      hovered: _hovered && _enabled,
      pressed: _pressed && _enabled,
      focused: _focused,
      enabled: _enabled,
    );
    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.semanticLabel,
      child: FocusableActionDetector(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: _enabled && widget.canRequestFocus,
        mouseCursor: _enabled ? widget.cursor : SystemMouseCursors.basic,
        onShowHoverHighlight: (v) => setState(() => _hovered = v),
        onShowFocusHighlight: (v) => setState(() => _focused = v),
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.numpadEnter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _activate();
              return null;
            },
          ),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _enabled ? (_) => setState(() => _pressed = true) : null,
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: _enabled ? (_) => setState(() => _pressed = false) : null,
          onTap: _enabled ? _activate : null,
          onDoubleTap: widget.onDoubleTap,
          onSecondaryTapUp: widget.onSecondaryTapUp,
          child: widget.builder(context, state),
        ),
      ),
    );
  }
}
