import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/app.dart';
import '../../design_system/design_system.dart';
import 'appearance_section.dart';
import 'custom_fields_section.dart';
import 'security_section.dart';
import 'server_section.dart';

/// Sections des paramètres (une URL chacune : /settings/<section>).
enum SettingsSection {
  appearance('Apparence', LucideIcons.palette, 'thème sombre clair'),
  security(
    'Sécurité',
    LucideIcons.shieldCheck,
    'mot de passe 2fa double authentification sessions',
  ),
  server('Serveur et données', LucideIcons.server, 'connexion poste cache'),
  customFields(
    'Champs personnalisés',
    LucideIcons.textCursorInput,
    'attributs colonnes formulaire',
  );

  const SettingsSection(this.label, this.icon, this.keywords);

  final String label;
  final IconData icon;
  final String keywords;
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key, required this.section});

  final SettingsSection section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    return Column(
      children: [
        PageHeader(title: context.l10n.navSettings, icon: LucideIcons.settings),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 220,
                padding: const EdgeInsets.all(VSpace.x3),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: c.border)),
                ),
                child: Column(
                  children: [
                    for (final s in SettingsSection.values)
                      _SectionTile(
                        section: s,
                        active: s == section,
                        onTap: () => context.go('/settings/${s.name}'),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: switch (section) {
                      SettingsSection.appearance => const AppearanceSection(),
                      SettingsSection.security => const SecuritySection(),
                      SettingsSection.server => const ServerSection(),
                      SettingsSection.customFields =>
                        const CustomFieldsSection(),
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTile extends StatelessWidget {
  const _SectionTile({
    required this.section,
    required this.active,
    required this.onTap,
  });

  final SettingsSection section;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onPressed: onTap,
      builder: (context, s) => AnimatedContainer(
        duration: VMotion.fast,
        height: 32,
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: VSpace.x2 + 2),
        decoration: BoxDecoration(
          color: active
              ? c.surfaceSelected
              : s.hovered
              ? c.surfaceHover
              : Colors.transparent,
          borderRadius: VRadius.smAll,
        ),
        child: Row(
          children: [
            Icon(
              section.icon,
              size: 15,
              color: active ? c.accentText : c.textMuted,
            ),
            const SizedBox(width: VSpace.x2 + 2),
            Text(
              section.label,
              style: context.text.bodyStrong.copyWith(
                color: active ? c.text : c.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Mise en page commune d'une section de paramètres.
class SettingsScroll extends StatelessWidget {
  const SettingsScroll({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: const EdgeInsets.all(VSpace.x6),
    itemCount: children.length,
    separatorBuilder: (_, _) => const SizedBox(height: VSpace.x4),
    itemBuilder: (_, i) => children[i],
  );
}

/// Ligne « libellé / description / contrôle ».
class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.label,
    required this.control,
    this.description,
  });

  final String label;
  final String? description;
  final Widget control;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: VSpace.x2),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.text.bodyStrong),
              if (description != null) ...[
                const SizedBox(height: 2),
                Text(description!, style: context.text.small),
              ],
            ],
          ),
        ),
        const SizedBox(width: VSpace.x4),
        control,
      ],
    ),
  );
}
