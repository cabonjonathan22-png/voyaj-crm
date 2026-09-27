import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/dimensions.dart';
import 'button.dart';
import 'text_field.dart';

/// Champ date (et heure si [withTime]) avec calendrier.
class VDateField extends StatefulWidget {
  const VDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.error,
    this.withTime = false,
    this.enabled = true,
  });

  /// Date locale.
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String? label;
  final String? error;
  final bool withTime;
  final bool enabled;

  @override
  State<VDateField> createState() => _VDateFieldState();
}

class _VDateFieldState extends State<VDateField> {
  late final _text = TextEditingController(text: _format(widget.value));

  DateFormat get _pattern =>
      DateFormat(widget.withTime ? 'dd/MM/yyyy HH:mm' : 'dd/MM/yyyy', 'fr');

  String _format(DateTime? value) =>
      value == null ? '' : _pattern.format(value);

  @override
  void didUpdateWidget(covariant VDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) _text.text = _format(widget.value);
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final initial = widget.value ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale('fr'),
    );
    if (date == null || !mounted) return;
    var result = date;
    if (widget.withTime) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initial),
      );
      if (!mounted) return;
      result = DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? 9,
        time?.minute ?? 0,
      );
    }
    widget.onChanged(result);
  }

  void _parse(String text) {
    if (text.trim().isEmpty) {
      widget.onChanged(null);
      return;
    }
    try {
      widget.onChanged(_pattern.parseStrict(text.trim()));
    } on FormatException {
      _text.text = _format(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) => Focus(
    onFocusChange: (focused) {
      if (!focused) _parse(_text.text);
    },
    child: VTextField(
      controller: _text,
      label: widget.label,
      error: widget.error,
      enabled: widget.enabled,
      hint: widget.withTime ? 'jj/mm/aaaa hh:mm' : 'jj/mm/aaaa',
      onSubmitted: _parse,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.value != null && widget.enabled)
            VIconButton(
              icon: LucideIcons.x,
              tooltip: 'Effacer',
              size: VButtonSize.sm,
              onPressed: () => widget.onChanged(null),
            ),
          const SizedBox(width: VSpace.x0_5),
          VIconButton(
            icon: LucideIcons.calendar,
            tooltip: 'Calendrier',
            size: VButtonSize.sm,
            onPressed: widget.enabled ? _pick : null,
          ),
        ],
      ),
    ),
  );
}
