import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';

/// Champ de saisie du design system.
class VTextField extends StatefulWidget {
  const VTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefixIcon,
    this.suffix,
    this.obscure = false,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
    this.dense = false,
    this.monospace = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool obscure;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool dense;
  final bool monospace;

  @override
  State<VTextField> createState() => _VTextFieldState();
}

class _VTextFieldState extends State<VTextField> {
  late final FocusNode _focus = widget.focusNode ?? FocusNode();
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocus);
  }

  void _onFocus() => setState(() {});

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    if (widget.focusNode == null) _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final hasError = widget.error != null;
    final focused = _focus.hasFocus;
    final borderColor = hasError
        ? c.danger
        : focused
        ? c.accent
        : _hovered
        ? c.borderStrong
        : c.border;
    final multiline = (widget.maxLines ?? 2) > 1;

    final field = MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: VMotion.fast,
        constraints: BoxConstraints(
          minHeight: widget.dense ? VSize.controlSm : VSize.controlMd,
        ),
        decoration: BoxDecoration(
          color: widget.enabled ? c.surface : c.backgroundSubtle,
          borderRadius: VRadius.smAll,
          border: Border.all(color: borderColor),
          boxShadow: focused
              ? [
                  BoxShadow(
                    color: (hasError ? c.danger : c.accent).withValues(
                      alpha: 0.18,
                    ),
                    spreadRadius: 3,
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: multiline
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            if (widget.prefixIcon != null)
              Padding(
                padding: EdgeInsets.only(
                  left: VSpace.x2 + 2,
                  top: multiline ? VSpace.x2 : 0,
                ),
                child: Icon(
                  widget.prefixIcon,
                  size: 15,
                  color: focused ? c.textMuted : c.textSubtle,
                ),
              ),
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: _focus,
                autofocus: widget.autofocus,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                obscureText: widget.obscure,
                maxLines: widget.obscure ? 1 : widget.maxLines,
                minLines: widget.minLines,
                maxLength: widget.maxLength,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                inputFormatters: widget.inputFormatters,
                autofillHints: widget.autofillHints,
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
                style: widget.monospace ? t.mono : t.body,
                cursorWidth: 1.5,
                cursorHeight: 16,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hint,
                  hintStyle: t.body.copyWith(color: c.textSubtle),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: VSpace.x2 + 2,
                    vertical: widget.dense ? 6 : 8,
                  ),
                ),
              ),
            ),
            if (widget.suffix != null)
              Padding(
                padding: const EdgeInsets.only(right: VSpace.x1),
                child: widget.suffix,
              ),
          ],
        ),
      ),
    );

    if (widget.label == null && widget.helper == null && !hasError) {
      return field;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: t.label),
          const SizedBox(height: VSpace.x1_5),
        ],
        field,
        if (hasError || widget.helper != null) ...[
          const SizedBox(height: VSpace.x1),
          Text(
            widget.error ?? widget.helper!,
            style: t.small.copyWith(color: hasError ? c.danger : c.textSubtle),
          ),
        ],
      ],
    );
  }
}
