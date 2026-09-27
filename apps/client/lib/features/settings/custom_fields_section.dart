import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../data/local/database.dart';
import '../../data/sync/local_entities.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import '../crm/widgets/record_form.dart';
import 'settings_page.dart';

/// Identifiant technique proposé d'après un libellé (`Budget 2026` →
/// `budget_2026`).
String customFieldKey(String label) {
  final key = searchText(
    label,
  ).replaceAll(RegExp('[^a-z0-9]+'), '_').replaceAll(RegExp(r'^_+|_+$'), '');
  final prefixed = RegExp('^[a-z]').hasMatch(key) ? key : 'champ_$key';
  return prefixed.length > 40 ? prefixed.substring(0, 40) : prefixed;
}

/// Champs personnalisés des organisations, contacts et affaires.
class CustomFieldsSection extends ConsumerWidget {
  const CustomFieldsSection({super.key});

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    CrmEntity entity, {
    CustomFieldRow? field,
    required int count,
  }) async {
    final l10n = context.l10n;
    final initial = field == null
        ? <String, Object?>{
            'entity': entity.key,
            'type': CustomFieldType.text.key,
            'sort_order': count.toDouble(),
          }
        : rowToWire(SyncEntities.customFields, field);
    initial['options_text'] = customFieldOptionsOf(initial).join(', ');
    await showRecordForm(
      context,
      schema: SyncEntities.customFields,
      title: field == null ? l10n.customFieldNew : l10n.customFieldEdit,
      icon: LucideIcons.textCursorInput,
      id: field?.id,
      width: 520,
      initial: initial,
      transform: (values) {
        final options = [
          for (final o in '${values['options_text'] ?? ''}'.split(','))
            if (o.trim().isNotEmpty) o.trim(),
        ];
        return {
          ...values,
          'key': field?.key ?? customFieldKey('${values['label'] ?? ''}'),
          'options': options.isEmpty ? null : options,
        };
      },
      fields: [
        TextFieldDef(
          'label',
          l10n.customFieldLabel,
          wide: true,
          autofocus: true,
        ),
        ChoiceFieldDef(
          'type',
          l10n.customFieldType,
          enumOptions(CustomFieldType.values),
          clearable: false,
          wide: true,
        ),
        TextFieldDef(
          'options_text',
          l10n.customFieldOptions,
          wide: true,
          hint: l10n.customFieldOptionsHint,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final canManage = ref.watch(
      permissionProvider(Permission.customFieldManage),
    );

    return SettingsScroll(
      children: [
        for (final entity in CrmEntity.values) ...[
          VCard(
            title: entity.label,
            description: l10n.customFieldsDescription,
            actions: [
              if (canManage)
                VButton(
                  label: l10n.customFieldNew,
                  icon: LucideIcons.plus,
                  size: VButtonSize.sm,
                  onPressed: () => unawaited(
                    _edit(
                      context,
                      ref,
                      entity,
                      count: ref.read(customFieldsForProvider(entity)).length,
                    ),
                  ),
                ),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (ref.watch(customFieldsForProvider(entity)).isEmpty)
                  Text(l10n.customFieldsEmpty, style: t.small),
                for (final field in ref.watch(customFieldsForProvider(entity)))
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: VSpace.x1),
                    padding: const EdgeInsets.symmetric(horizontal: VSpace.x3),
                    decoration: BoxDecoration(
                      borderRadius: VRadius.smAll,
                      border: Border.all(color: c.border),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(field.label, style: t.bodyStrong)),
                        Text(field.key, style: t.mono),
                        const SizedBox(width: VSpace.x3),
                        VBadge(
                          enumByKey(
                                CustomFieldType.values,
                                field.type,
                              )?.label ??
                              field.type,
                        ),
                        if (canManage) ...[
                          VIconButton(
                            icon: LucideIcons.pencil,
                            tooltip: l10n.edit,
                            size: VButtonSize.sm,
                            onPressed: () => unawaited(
                              _edit(
                                context,
                                ref,
                                entity,
                                field: field,
                                count: 0,
                              ),
                            ),
                          ),
                          VIconButton(
                            icon: LucideIcons.trash2,
                            tooltip: l10n.delete,
                            size: VButtonSize.sm,
                            onPressed: () => unawaited(
                              ref.read(recordStoreProvider).delete(
                                SyncEntities.customFields,
                                [field.id],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: VSpace.x4),
        ],
      ],
    );
  }
}

/// Options d'un champ (format réseau).
List<String> customFieldOptionsOf(Map<String, Object?> record) =>
    switch (record['options']) {
      final List<Object?> list => [for (final o in list) '$o'],
      final String text => [for (final o in jsonDecode(text) as List) '$o'],
      _ => const [],
    };
