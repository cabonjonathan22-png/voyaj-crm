import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../design_system/design_system.dart';
import 'settings_page.dart';

class AppearanceSection extends ConsumerWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return SettingsScroll(
      children: [
        VCard(
          title: l10n.appearanceTitle,
          description: l10n.appearanceDescription,
          child: Column(
            children: [
              SettingRow(
                label: l10n.themeLabel,
                description: l10n.themeDescription,
                control: VSegmented<ThemeMode>(
                  value: ref.watch(themeModeProvider),
                  onChanged: ref.read(themeModeProvider.notifier).set,
                  options: [
                    VSelectOption(
                      ThemeMode.system,
                      l10n.themeSystem,
                      icon: LucideIcons.monitor,
                    ),
                    VSelectOption(
                      ThemeMode.light,
                      l10n.themeLight,
                      icon: LucideIcons.sun,
                    ),
                    VSelectOption(
                      ThemeMode.dark,
                      l10n.themeDark,
                      icon: LucideIcons.moon,
                    ),
                  ],
                ),
              ),
              SettingRow(
                label: l10n.compactSidebar,
                description: l10n.compactSidebarDescription,
                control: Switch(
                  value: ref.watch(sidebarCollapsedProvider),
                  onChanged: (_) =>
                      ref.read(sidebarCollapsedProvider.notifier).toggle(),
                ),
              ),
              SettingRow(
                label: l10n.languageLabel,
                description: l10n.languageDescription,
                control: VSelect<String>(
                  width: 160,
                  value: 'fr',
                  options: const [VSelectOption('fr', 'Français')],
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
