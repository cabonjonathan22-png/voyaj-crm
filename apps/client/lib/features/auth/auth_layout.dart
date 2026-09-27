import 'package:flutter/material.dart';

import '../../design_system/design_system.dart';

/// Mise en page des écrans hors connexion : carte centrée.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.footer,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Scaffold(
      backgroundColor: c.backgroundSubtle,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(VSpace.x6),
          child: SizedBox(
            width: 380,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [c.accent, c.accentHover],
                      ),
                      borderRadius: VRadius.mdAll,
                      boxShadow: VShadows.md(dark: c.isDark),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'V',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: VSpace.x5),
                Text(title, style: t.display, textAlign: TextAlign.center),
                const SizedBox(height: VSpace.x1_5),
                Text(subtitle, style: t.small, textAlign: TextAlign.center),
                const SizedBox(height: VSpace.x6),
                VCard(padding: const EdgeInsets.all(VSpace.x5), child: child),
                if (footer != null) ...[
                  const SizedBox(height: VSpace.x4),
                  footer!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
