import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/providers.dart';
import '../../design_system/design_system.dart';

/// Catalogue des composants (build de debug uniquement) : sert de référence
/// visuelle et de banc d'essai des thèmes.
class DesignSystemGallery extends ConsumerStatefulWidget {
  const DesignSystemGallery({super.key});

  @override
  ConsumerState<DesignSystemGallery> createState() =>
      _DesignSystemGalleryState();
}

class _DesignSystemGalleryState extends ConsumerState<DesignSystemGallery> {
  String _select = 'a';
  bool _switch = true;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    final toasts = ref.read(toastProvider);

    Widget section(String title, List<Widget> children) => VCard(
      title: title,
      child: Wrap(
        spacing: VSpace.x3,
        runSpacing: VSpace.x3,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      ),
    );

    Widget swatch(String name, Color color) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: VRadius.smAll,
            border: Border.all(color: c.border),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: t.caption),
      ],
    );

    return Column(
      children: [
        const PageHeader(
          title: 'Design system',
          subtitle: 'Tokens et composants',
          icon: LucideIcons.palette,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(VSpace.x5),
            children: [
              section('Couleurs', [
                swatch('background', c.background),
                swatch('subtle', c.backgroundSubtle),
                swatch('surface', c.surface),
                swatch('hover', c.surfaceHover),
                swatch('selected', c.surfaceSelected),
                swatch('border', c.border),
                swatch('text', c.text),
                swatch('muted', c.textMuted),
                swatch('accent', c.accent),
                swatch('success', c.success),
                swatch('warning', c.warning),
                swatch('danger', c.danger),
                swatch('info', c.info),
              ]),
              const SizedBox(height: VSpace.x4),
              section('Typographie', [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Display 24', style: t.display),
                    Text('Title 17', style: t.title),
                    Text('Heading 14', style: t.heading),
                    Text(
                      'Body 13 — Voyaj relie conducteurs et passagers.',
                      style: t.body,
                    ),
                    Text('Label 12', style: t.label),
                    Text('Small 12', style: t.small),
                    Text('Caption 11', style: t.caption),
                    Text('Mono 0192a3b4-c5d6', style: t.mono),
                  ],
                ),
              ]),
              const SizedBox(height: VSpace.x4),
              section('Boutons', [
                VButton.primary(label: 'Primaire', onPressed: () {}),
                VButton(label: 'Secondaire', onPressed: () {}),
                VButton.ghost(label: 'Discret', onPressed: () {}),
                VButton.danger(label: 'Danger', onPressed: () {}),
                VButton.primary(
                  label: 'Avec raccourci',
                  icon: LucideIcons.plus,
                  shortcut: 'Ctrl N',
                  onPressed: () {},
                ),
                const VButton(label: 'Désactivé', onPressed: null),
                VButton(label: 'Chargement', loading: true, onPressed: () {}),
                VIconButton(
                  icon: LucideIcons.settings,
                  tooltip: 'Icône',
                  onPressed: () {},
                ),
              ]),
              const SizedBox(height: VSpace.x4),
              section('Champs', [
                const SizedBox(
                  width: 240,
                  child: VTextField(label: 'Libellé', hint: 'Indication'),
                ),
                const SizedBox(
                  width: 240,
                  child: VTextField(
                    label: 'Erreur',
                    error: 'Ce champ est obligatoire.',
                  ),
                ),
                const SizedBox(
                  width: 240,
                  child: VTextField(
                    prefixIcon: LucideIcons.search,
                    hint: 'Rechercher…',
                  ),
                ),
                VSelect<String>(
                  width: 200,
                  label: 'Liste',
                  value: _select,
                  onChanged: (v) => setState(() => _select = v),
                  options: const [
                    VSelectOption('a', 'Mairies'),
                    VSelectOption('b', 'EPCI'),
                    VSelectOption('c', 'Festivals'),
                  ],
                ),
                VSegmented<String>(
                  value: _select,
                  onChanged: (v) => setState(() => _select = v),
                  options: const [
                    VSelectOption('a', 'Liste'),
                    VSelectOption('b', 'Kanban'),
                    VSelectOption('c', 'Carte'),
                  ],
                ),
                Switch(
                  value: _switch,
                  onChanged: (v) => setState(() => _switch = v),
                ),
                Checkbox(
                  value: _switch,
                  onChanged: (v) => setState(() => _switch = v!),
                ),
              ]),
              const SizedBox(height: VSpace.x4),
              section('Badges et retours', [
                for (final tone in VTone.values) VBadge(tone.name, tone: tone),
                const VBadge('Tag', dotColor: Color(0xFFEC4899)),
                const Kbd('Ctrl Maj K'),
                const VAvatar('Camille Martin'),
                const VSpinner(),
                const Skeleton(width: 160),
                VButton(
                  label: 'Toast',
                  onPressed: () => toasts.success(
                    'Enregistré',
                    description: 'Les modifications seront synchronisées.',
                  ),
                ),
                VButton(
                  label: 'Modale',
                  onPressed: () => confirm(
                    context,
                    title: 'Supprimer ?',
                    message:
                        'Cette action est synchronisée sur tous les postes.',
                    destructive: true,
                  ),
                ),
              ]),
              const SizedBox(height: VSpace.x4),
              const VBanner(
                message: 'Bannière d’information contextuelle.',
                icon: LucideIcons.info,
              ),
              const SizedBox(height: VSpace.x4),
              const SizedBox(
                height: 260,
                child: VCard(
                  padding: EdgeInsets.zero,
                  child: EmptyState(
                    icon: LucideIcons.inbox,
                    title: 'État vide',
                    message: 'Explication courte et action principale.',
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
