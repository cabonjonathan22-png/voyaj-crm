import 'package:intl/intl.dart';

/// Date et heure locales : `27/09/2026 14:05`.
String formatDateTime(DateTime date) =>
    DateFormat('dd/MM/yyyy HH:mm', 'fr').format(date.toLocal());

/// Date relative courte (« à l'instant », « il y a 5 min », « hier »…).
String formatRelative(DateTime date, {DateTime? now}) {
  final reference = (now ?? DateTime.now()).toLocal();
  final local = date.toLocal();
  final diff = reference.difference(local);
  if (diff.inSeconds < 45) return "à l'instant";
  if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes.clamp(1, 59)} min';
  if (diff.inHours < 24 && reference.day == local.day) {
    return 'il y a ${diff.inHours} h';
  }
  final yesterday = reference.subtract(const Duration(days: 1));
  if (local.year == yesterday.year &&
      local.month == yesterday.month &&
      local.day == yesterday.day) {
    return 'hier, ${DateFormat('HH:mm', 'fr').format(local)}';
  }
  if (local.year == reference.year) {
    return DateFormat('d MMM', 'fr').format(local);
  }
  return DateFormat('d MMM yyyy', 'fr').format(local);
}
