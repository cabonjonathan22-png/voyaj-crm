import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../design_system/design_system.dart';
import '../l10n/generated/app_localizations.dart';
import 'providers.dart';
import 'router.dart';

/// Application Voyaj CRM.
class VoyajApp extends ConsumerWidget {
  const VoyajApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final toasts = ref.watch(toastProvider);
    return MaterialApp.router(
      title: 'Voyaj CRM',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: buildTheme(VColors.light),
      darkTheme: buildTheme(VColors.dark),
      themeMode: ref.watch(themeModeProvider),
      themeAnimationDuration: VMotion.fast,
      locale: const Locale('fr'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) =>
          ToastHost(controller: toasts, child: child ?? const SizedBox()),
    );
  }
}

/// Accès court aux traductions.
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
