import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';
import 'button.dart';

/// Affiche une modale animée (fondu + légère mise à l'échelle).
/// Échap ferme la modale.
Future<T?> showVModal<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool dismissible = true,
}) => showGeneralDialog<T>(
  context: context,
  barrierDismissible: dismissible,
  barrierLabel: 'Fermer',
  barrierColor: context.colors.scrim,
  transitionDuration: VMotion.normal,
  pageBuilder: (context, _, _) => builder(context),
  transitionBuilder: (context, animation, _, child) {
    final curved = CurvedAnimation(parent: animation, curve: VMotion.curve);
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween(begin: 0.97, end: 1.0).animate(curved),
        child: child,
      ),
    );
  },
);

/// Mise en page standard d'une modale.
class VModal extends StatelessWidget {
  const VModal({
    super.key,
    required this.title,
    required this.child,
    this.description,
    this.actions = const [],
    this.width = 480,
    this.icon,
  });

  final String title;
  final String? description;
  final Widget child;
  final List<Widget> actions;
  final double width;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Center(
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              Navigator.of(context).maybePop(),
        },
        child: FocusScope(
          autofocus: true,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: width,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.86,
              ),
              margin: const EdgeInsets.all(VSpace.x6),
              decoration: BoxDecoration(
                color: c.surfaceRaised,
                borderRadius: VRadius.lgAll,
                border: Border.all(color: c.border),
                boxShadow: VShadows.lg(dark: c.isDark),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      VSpace.x5,
                      VSpace.x5,
                      VSpace.x3,
                      0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (icon != null) ...[
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: c.accentSubtle,
                              borderRadius: VRadius.smAll,
                            ),
                            child: Icon(icon, size: 16, color: c.accentText),
                          ),
                          const SizedBox(width: VSpace.x3),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: t.title),
                              if (description != null) ...[
                                const SizedBox(height: VSpace.x1),
                                Text(description!, style: t.small),
                              ],
                            ],
                          ),
                        ),
                        VIconButton(
                          icon: LucideIcons.x,
                          tooltip: 'Fermer (Échap)',
                          size: VButtonSize.sm,
                          onPressed: () => Navigator.of(context).maybePop(),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        VSpace.x5,
                        VSpace.x4,
                        VSpace.x5,
                        VSpace.x5,
                      ),
                      child: child,
                    ),
                  ),
                  if (actions.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: VSpace.x5,
                        vertical: VSpace.x3,
                      ),
                      decoration: BoxDecoration(
                        color: c.backgroundSubtle,
                        border: Border(top: BorderSide(color: c.border)),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(VRadius.lg),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (final (i, action) in actions.indexed) ...[
                            if (i > 0) const SizedBox(width: VSpace.x2),
                            action,
                          ],
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Demande de confirmation. Retourne `true` si l'utilisateur confirme.
Future<bool> confirm(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirmer',
  bool destructive = false,
}) async {
  final result = await showVModal<bool>(
    context,
    builder: (context) => VModal(
      title: title,
      width: 420,
      actions: [
        VButton(
          label: 'Annuler',
          onPressed: () => Navigator.of(context).pop(false),
        ),
        if (destructive)
          VButton.danger(
            label: confirmLabel,
            autofocus: true,
            onPressed: () => Navigator.of(context).pop(true),
          )
        else
          VButton.primary(
            label: confirmLabel,
            autofocus: true,
            onPressed: () => Navigator.of(context).pop(true),
          ),
      ],
      child: Text(message, style: context.text.body),
    ),
  );
  return result ?? false;
}
