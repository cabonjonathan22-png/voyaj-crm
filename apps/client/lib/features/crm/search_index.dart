import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/commands/commands.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import 'crm_data.dart';
import 'crm_format.dart';

/// Entrée de l'index de recherche globale.
@immutable
final class SearchEntry {
  const SearchEntry(this.text, this.command);

  /// Texte recherché (minuscules sans accents).
  final String text;
  final AppCommand command;
}

/// Index de recherche globale (Ctrl K) des données locales : organisations,
/// contacts, affaires et tags, selon les droits de lecture.
final searchIndexProvider = Provider<List<SearchEntry>>((ref) {
  bool can(Permission p) => ref.watch(permissionProvider(p));
  final organisations = ref.watch(organisationByIdProvider);
  final entries = <SearchEntry>[];

  if (can(Permission.organisationRead)) {
    for (final o in organisations.values) {
      final kind = enumByKey(OrganisationKind.values, o.kind);
      entries.add(
        SearchEntry(
          searchText(
            '${o.name} ${o.city ?? ''} ${o.postalCode ?? ''} ${o.siren ?? ''} '
            '${o.inseeCode ?? ''}',
          ),
          AppCommand(
            id: 'organisation.${o.id}',
            label: o.name,
            subtitle: [kind?.label, o.city].whereType<String>().join(' · '),
            group: CommandGroup.records,
            icon: kindIcon(kind),
            run: (context, _) => context.go('${Routes.organisations}/${o.id}'),
          ),
        ),
      );
    }
  }
  if (can(Permission.contactRead)) {
    for (final c in ref.watch(contactsProvider).value ?? const <ContactRow>[]) {
      final organisation = organisations[c.organisationId];
      entries.add(
        SearchEntry(
          searchText(
            '${contactName(c)} ${c.email ?? ''} ${organisation?.name ?? ''}',
          ),
          AppCommand(
            id: 'contact.${c.id}',
            label: contactName(c),
            subtitle: [
              c.jobTitle,
              organisation?.name,
            ].whereType<String>().join(' · '),
            group: CommandGroup.records,
            icon: LucideIcons.user,
            run: (context, _) => context.go('${Routes.contacts}/${c.id}'),
          ),
        ),
      );
    }
  }
  if (can(Permission.dealRead)) {
    for (final d in ref.watch(dealsProvider).value ?? const <DealRow>[]) {
      final organisation = organisations[d.organisationId];
      entries.add(
        SearchEntry(
          searchText('${d.title} ${organisation?.name ?? ''}'),
          AppCommand(
            id: 'deal.${d.id}',
            label: d.title,
            subtitle: [
              organisation?.name,
              formatAmount(d.amountCents),
            ].where((s) => s != null && s.isNotEmpty).join(' · '),
            group: CommandGroup.records,
            icon: LucideIcons.handCoins,
            run: (context, _) =>
                context.go('${Routes.pipelines}?id=${d.pipelineId}'),
          ),
        ),
      );
    }
  }
  for (final tag in ref.watch(tagsProvider).value ?? const <Tag>[]) {
    entries.add(
      SearchEntry(
        searchText('${tag.name} ${tag.description ?? ''}'),
        AppCommand(
          id: 'tag.${tag.id}',
          label: tag.name,
          subtitle: tag.description,
          group: CommandGroup.records,
          icon: LucideIcons.tag,
          leading: ColorDot(parseHexColor(tag.color)),
          run: (context, _) => context.go('${Routes.tags}?id=${tag.id}'),
        ),
      ),
    );
  }
  return entries;
});

/// Enregistrements contenant tous les mots de [query] ; ceux dont le
/// libellé commence par la recherche d'abord.
List<AppCommand> searchRecords(
  List<SearchEntry> index,
  String query, {
  int limit = 8,
}) {
  final words = searchText(
    query,
  ).split(' ').where((w) => w.isNotEmpty).toList();
  if (words.isEmpty) return const [];
  final prefix = <AppCommand>[];
  final other = <AppCommand>[];
  for (final entry in index) {
    if (!words.every(entry.text.contains)) continue;
    if (entry.text.startsWith(words.first)) {
      prefix.add(entry.command);
      if (prefix.length >= limit) break;
    } else if (other.length < limit) {
      other.add(entry.command);
    }
  }
  return [...prefix, ...other].take(limit).toList();
}
