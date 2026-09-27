import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../design_system/design_system.dart';
import '../crm_actions.dart';
import '../crm_data.dart';

/// Tags appliqués à une fiche, avec ajout et retrait.
class RecordTags extends ConsumerWidget {
  const RecordTags({super.key, required this.entity, required this.recordId});

  final CrmEntity entity;
  final String recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final canApply = ref.watch(permissionProvider(Permission.tagApply));
    final applied = ref.watch(tagsByRecordProvider)[recordId] ?? const <Tag>[];
    final taggings = ref.watch(taggingsProvider).value ?? const [];
    final store = ref.watch(recordStoreProvider);

    Future<void> add() async {
      final appliedIds = {for (final t in applied) t.id};
      final option = await pickTag(
        context,
        ref,
        exclude: appliedIds,
        title: l10n.tagAddTitle,
      );
      if (option == null) return;
      await applyTag(
        store,
        entity: entity,
        recordIds: [recordId],
        tagId: option,
        taggings: taggings,
      );
    }

    return Wrap(
      spacing: VSpace.x1_5,
      runSpacing: VSpace.x1_5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final tag in applied)
          VChip(
            tag.name,
            color: parseHexColor(tag.color),
            onRemove: canApply
                ? () => unawaited(
                    removeTag(
                      store,
                      recordId: recordId,
                      tagId: tag.id,
                      taggings: taggings,
                    ),
                  )
                : null,
          ),
        if (canApply)
          VChip(
            l10n.tagAdd,
            icon: LucideIcons.plus,
            onPressed: () => unawaited(add()),
          )
        else if (applied.isEmpty)
          Text('—', style: context.text.small),
      ],
    );
  }
}

/// Choix d'un tag (hors [exclude]) ; retourne son identifiant.
Future<String?> pickTag(
  BuildContext context,
  WidgetRef ref, {
  required String title,
  Set<String> exclude = const {},
}) async {
  final tags = ref.read(tagsProvider).value ?? const <Tag>[];
  final option = await showSearchPicker<String>(
    context,
    title: title,
    options: [
      for (final t in tags)
        if (!exclude.contains(t.id))
          VSelectOption(
            t.id,
            t.name,
            leading: ColorDot(parseHexColor(t.color)),
          ),
    ],
  );
  return option?.value;
}
