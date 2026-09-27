import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/providers.dart';

/// Données d'administration (lecture en ligne, rafraîchies après chaque
/// modification par `ref.invalidate`).
final usersProvider = FutureProvider.autoDispose<List<UserSummary>>((
  ref,
) async {
  final json = await ref.watch(apiClientProvider)!.get('/api/v1/users');
  return [
    for (final u in json! as List<dynamic>)
      UserSummary.fromJson(u as Map<String, dynamic>),
  ];
});

final rolesProvider = FutureProvider.autoDispose<List<RoleInfo>>((ref) async {
  final json = await ref.watch(apiClientProvider)!.get('/api/v1/roles');
  return [
    for (final r in json! as List<dynamic>)
      RoleInfo.fromJson(r as Map<String, dynamic>),
  ];
});
