import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../data/local/database.dart';
import '../../../data/records/record_store.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../crm_format.dart';

/// Définition d'un champ de formulaire (clé = champ du schéma).
sealed class FormFieldDef {
  const FormFieldDef(this.key, this.label, {this.wide = false});

  final String key;
  final String label;

  /// Occupe toute la largeur.
  final bool wide;
}

final class TextFieldDef extends FormFieldDef {
  const TextFieldDef(
    super.key,
    super.label, {
    super.wide,
    this.maxLines = 1,
    this.hint,
    this.autofocus = false,
  });

  final int maxLines;
  final String? hint;
  final bool autofocus;
}

/// Nombre entier ou décimal, saisi en texte.
final class NumberFieldDef extends FormFieldDef {
  const NumberFieldDef(
    super.key,
    super.label, {
    this.decimal = false,
    this.cents = false,
    super.wide,
  });

  final bool decimal;

  /// Montant saisi en euros, stocké en centimes.
  final bool cents;
}

/// Liste courte de choix.
final class ChoiceFieldDef extends FormFieldDef {
  const ChoiceFieldDef(
    super.key,
    super.label,
    this.options, {
    super.wide,
    this.clearable = true,
  });

  final List<VSelectOption<String>> options;
  final bool clearable;
}

/// Référence vers un autre enregistrement (longue liste, recherche).
final class RefFieldDef extends FormFieldDef {
  const RefFieldDef(super.key, super.label, this.options, {super.wide});

  final List<VSelectOption<String>> options;
}

/// Date calendaire (`AAAA-MM-JJ`) ou horodatage ([withTime]).
final class DateFieldDef extends FormFieldDef {
  const DateFieldDef(
    super.key,
    super.label, {
    this.withTime = false,
    super.wide,
  });

  final bool withTime;
}

final class BoolFieldDef extends FormFieldDef {
  const BoolFieldDef(super.key, super.label, {super.wide = true});
}

/// Titre de section.
final class SectionDef extends FormFieldDef {
  const SectionDef(String label) : super('', label, wide: true);
}

/// Options d'une énumération métier.
List<VSelectOption<String>> enumOptions(List<KeyedEnum> values) => [
  for (final v in values) VSelectOption(v.key, v.label),
];

/// Ouvre le formulaire de création ([id] `null`) ou de modification d'un
/// enregistrement. Retourne l'identifiant enregistré, ou `null`.
Future<String?> showRecordForm(
  BuildContext context, {
  required EntitySchema schema,
  required String title,
  required List<FormFieldDef> fields,
  String? id,
  Map<String, Object?> initial = const {},
  CrmEntity? customFieldsOf,
  IconData? icon,
  double width = 640,
  Map<String, Object?> Function(Map<String, Object?> values)? transform,
}) => showVModal<String>(
  context,
  builder: (_) => RecordFormModal(
    schema: schema,
    title: title,
    fields: fields,
    id: id,
    initial: initial,
    customFieldsOf: customFieldsOf,
    icon: icon,
    width: width,
    transform: transform,
  ),
);

/// Formulaire générique : valeurs au format réseau, validation par les
/// règles partagées, écriture par [RecordStore].
class RecordFormModal extends ConsumerStatefulWidget {
  const RecordFormModal({
    super.key,
    required this.schema,
    required this.title,
    required this.fields,
    this.id,
    this.initial = const {},
    this.customFieldsOf,
    this.icon,
    this.width = 640,
    this.transform,
  });

  final EntitySchema schema;
  final String title;
  final List<FormFieldDef> fields;
  final String? id;
  final Map<String, Object?> initial;

  /// Ajoute les champs personnalisés de cette entité.
  final CrmEntity? customFieldsOf;
  final IconData? icon;
  final double width;

  /// Transforme les valeurs saisies avant l'écriture (champs dérivés).
  final Map<String, Object?> Function(Map<String, Object?> values)? transform;

  @override
  ConsumerState<RecordFormModal> createState() => _RecordFormModalState();
}

class _RecordFormModalState extends ConsumerState<RecordFormModal> {
  late final Map<String, Object?> _values = {...widget.initial};
  late final Map<String, Object?> _custom = {
    ...?(widget.initial['custom_fields'] as Map<String, Object?>?),
  };
  final _controllers = <String, TextEditingController>{};
  Map<String, String> _errors = const {};
  bool _saving = false;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _controller(String key, String text) =>
      _controllers.putIfAbsent(key, () => TextEditingController(text: text));

  String _numberText(NumberFieldDef def) {
    final value = _values[def.key];
    if (value is! num) return '';
    final n = def.cents ? value / 100 : value;
    return n == n.roundToDouble() ? '${n.round()}' : '$n'.replaceAll('.', ',');
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final errors = <String, String>{};
    final values = {..._values};
    for (final def in widget.fields.whereType<NumberFieldDef>()) {
      final text = _controllers[def.key]?.text.trim().replaceAll(' ', '');
      if (text == null) continue;
      if (text.isEmpty) {
        values[def.key] = null;
        continue;
      }
      final n = num.tryParse(text.replaceAll(',', '.'));
      if (n == null || (!def.decimal && !def.cents && n != n.roundToDouble())) {
        errors[def.key] = l10n.formInvalidNumber;
      } else {
        values[def.key] = def.cents
            ? (n * 100).round()
            : def.decimal
            ? n.toDouble()
            : n.toInt();
      }
    }
    for (final def in widget.fields.whereType<TextFieldDef>()) {
      final controller = _controllers[def.key];
      if (controller != null) values[def.key] = controller.text;
    }
    for (final field in _customDefs) {
      final controller = _controllers['custom.${field.key}'];
      if (controller == null) continue;
      final text = controller.text.trim();
      if (field.type == CustomFieldType.number.key) {
        final n = num.tryParse(text.replaceAll(' ', '').replaceAll(',', '.'));
        if (text.isNotEmpty && n == null) {
          errors['custom.${field.key}'] = l10n.formInvalidNumber;
        }
        _custom[field.key] = text.isEmpty ? null : n;
      } else {
        _custom[field.key] = text.isEmpty ? null : text;
      }
    }
    if (widget.customFieldsOf != null) {
      _custom.removeWhere((_, v) => v == null);
      values['custom_fields'] = _custom.isEmpty ? null : {..._custom};
    }
    if (errors.isNotEmpty) {
      setState(() => _errors = errors);
      return;
    }

    setState(() {
      _saving = true;
      _errors = const {};
    });
    final store = ref.read(recordStoreProvider);
    final record = widget.transform?.call(values) ?? values;
    try {
      final String id;
      if (widget.id == null) {
        id = await store.create(widget.schema, record);
      } else {
        id = widget.id!;
        await store.update(widget.schema, id, record);
      }
      if (mounted) Navigator.of(context).pop(id);
    } on RecordValidationException catch (e) {
      if (mounted) {
        setState(() {
          _errors = e.byField;
          _saving = false;
        });
      }
    }
  }

  List<CustomFieldRow> get _customDefs => widget.customFieldsOf == null
      ? const []
      : ref.watch(customFieldsForProvider(widget.customFieldsOf!));

  Widget _field(FormFieldDef def) {
    final error = _errors[def.key];
    return switch (def) {
      SectionDef() => Padding(
        padding: const EdgeInsets.only(top: VSpace.x2),
        child: Text(def.label, style: context.text.heading),
      ),
      TextFieldDef() => VTextField(
        controller: _controller(def.key, _values[def.key] as String? ?? ''),
        label: def.label,
        hint: def.hint,
        error: error,
        autofocus: def.autofocus,
        maxLines: def.maxLines,
        minLines: def.maxLines > 1 ? 2 : null,
      ),
      NumberFieldDef() => VTextField(
        controller: _controller(def.key, _numberText(def)),
        label: def.label,
        error: error,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9 ,.\-]')),
        ],
      ),
      ChoiceFieldDef() => _labelled(
        def.label,
        error,
        VSelect<String?>(
          value: _values[def.key] as String?,
          width: double.infinity,
          options: [
            if (def.clearable) VSelectOption(null, context.l10n.formNone),
            for (final o in def.options)
              VSelectOption(o.value, o.label, icon: o.icon, leading: o.leading),
          ],
          onChanged: (v) => setState(() => _values[def.key] = v),
        ),
      ),
      RefFieldDef() => VSearchSelect<String>(
        value: _values[def.key] as String?,
        label: def.label,
        error: error,
        options: def.options,
        placeholder: context.l10n.formChoose,
        onChanged: (v) => setState(() => _values[def.key] = v),
      ),
      DateFieldDef() => VDateField(
        label: def.label,
        error: error,
        withTime: def.withTime,
        value: switch (_values[def.key]) {
          final String s => DateTime.tryParse(s)?.toLocal(),
          _ => null,
        },
        onChanged: (d) => setState(
          () => _values[def.key] = d == null
              ? null
              : def.withTime
              ? d.toUtc().toIso8601String()
              : formatDateOnly(d),
        ),
      ),
      BoolFieldDef() => _checkbox(
        def.label,
        _values[def.key] == true,
        (v) => setState(() => _values[def.key] = v),
      ),
    };
  }

  Widget _checkbox(String label, bool value, ValueChanged<bool> onChanged) =>
      Row(
        children: [
          Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
          const SizedBox(width: VSpace.x1),
          Flexible(child: Text(label, style: context.text.body)),
        ],
      );

  Widget _labelled(String label, String? error, Widget child) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label, style: context.text.label),
      const SizedBox(height: VSpace.x1_5),
      child,
      if (error != null) ...[
        const SizedBox(height: VSpace.x1),
        Text(
          error,
          style: context.text.small.copyWith(color: context.colors.danger),
        ),
      ],
    ],
  );

  Widget _customField(CustomFieldRow field) {
    final key = 'custom.${field.key}';
    final value = _custom[field.key];
    return switch (enumByKey(CustomFieldType.values, field.type)) {
      CustomFieldType.boolean => _checkbox(
        field.label,
        value == true,
        (v) => setState(() => _custom[field.key] = v),
      ),
      CustomFieldType.date => VDateField(
        label: field.label,
        value: value is String ? DateTime.tryParse(value) : null,
        onChanged: (d) => setState(
          () => _custom[field.key] = d == null ? null : formatDateOnly(d),
        ),
      ),
      CustomFieldType.select => _labelled(
        field.label,
        null,
        VSelect<String?>(
          value: value as String?,
          width: double.infinity,
          options: [
            VSelectOption(null, context.l10n.formNone),
            for (final o in customFieldOptions(field)) VSelectOption(o, o),
          ],
          onChanged: (v) => setState(() => _custom[field.key] = v),
        ),
      ),
      _ => VTextField(
        controller: _controller(key, value == null ? '' : '$value'),
        label: field.label,
        error: _errors[key],
        hint: field.type == CustomFieldType.url.key ? 'https://' : null,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final customDefs = _customDefs;
    final items = [
      for (final def in widget.fields) (def.wide, _field(def)),
      if (customDefs.isNotEmpty)
        (true, _field(SectionDef(l10n.customFieldsTitle))),
      for (final field in customDefs)
        (field.type == CustomFieldType.boolean.key, _customField(field)),
    ];
    // Erreurs de champs non affichés (règles portant sur plusieurs champs).
    final shown = {for (final def in widget.fields) def.key};
    final other = [
      for (final MapEntry(:key, :value) in _errors.entries)
        if (!shown.contains(key) && !key.startsWith('custom.')) value,
    ];

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () =>
            unawaited(_save()),
        const SingleActivator(LogicalKeyboardKey.enter, control: true): () =>
            unawaited(_save()),
      },
      child: VModal(
        title: widget.title,
        icon: widget.icon,
        width: widget.width,
        actions: [
          VButton(
            label: l10n.cancel,
            onPressed: () => Navigator.of(context).pop(),
          ),
          VButton.primary(
            label: widget.id == null ? l10n.create : l10n.save,
            shortcut: 'Ctrl S',
            loading: _saving,
            onPressed: _save,
          ),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            final half = (constraints.maxWidth - VSpace.x4) / 2;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (other.isNotEmpty) ...[
                  VBanner(message: other.join(' '), tone: VTone.danger),
                  const SizedBox(height: VSpace.x3),
                ],
                Wrap(
                  spacing: VSpace.x4,
                  runSpacing: VSpace.x3,
                  children: [
                    for (final (wide, widget) in items)
                      SizedBox(
                        width: wide ? constraints.maxWidth : half,
                        child: widget,
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Options « organisations » pour un champ de référence.
List<VSelectOption<String>> organisationOptions(
  Iterable<OrganisationRow> organisations, {
  String? exclude,
}) => [
  for (final o in organisations)
    if (o.id != exclude)
      VSelectOption(
        o.id,
        o.city == null || o.name.contains(o.city!)
            ? o.name
            : '${o.name} (${o.city})',
        icon: kindIcon(enumByKey(OrganisationKind.values, o.kind)),
      ),
];

/// Options « contacts » pour un champ de référence.
List<VSelectOption<String>> contactOptions(
  Iterable<ContactRow> contacts,
  Map<String, OrganisationRow> organisations,
) => [
  for (final c in contacts)
    VSelectOption(c.id, switch (organisations[c.organisationId]) {
      final OrganisationRow o => '${contactName(c)} — ${o.name}',
      null => contactName(c),
    }),
];
