import 'package:flutter/material.dart';

import '../../../design_system/design_system.dart';

/// En-tête d'une fiche : icône, titre, sous-titre, actions, puis contenu
/// complémentaire (tags…).
class RecordHeader extends StatelessWidget {
  const RecordHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actions = const [],
    this.below,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Widget? below;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        VSpace.x6,
        VSpace.x5,
        VSpace.x6,
        VSpace.x3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: c.accentSubtle,
                  borderRadius: VRadius.mdAll,
                ),
                child: Icon(icon, size: 20, color: c.accentText),
              ),
              const SizedBox(width: VSpace.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(title, style: t.display),
                    if (subtitle != null) Text(subtitle!, style: t.small),
                  ],
                ),
              ),
              for (final (i, action) in actions.indexed) ...[
                if (i > 0) const SizedBox(width: VSpace.x2),
                action,
              ],
            ],
          ),
          if (below != null) ...[const SizedBox(height: VSpace.x3), below!],
        ],
      ),
    );
  }
}

/// Section titrée d'une fiche (carte).
class RecordSection extends StatelessWidget {
  const RecordSection({
    super.key,
    required this.title,
    required this.children,
    this.actions,
  });

  final String title;
  final List<Widget> children;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: VSpace.x4),
    child: VCard(
      title: title,
      actions: actions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    ),
  );
}
