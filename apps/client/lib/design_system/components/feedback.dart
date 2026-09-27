import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/dimensions.dart';

/// Bloc de chargement animé (squelette).
class Skeleton extends StatefulWidget {
  const Skeleton({super.key, this.width, this.height = 12, this.radius = 4});

  final double? width;
  final double height;
  final double radius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final x = _controller.value * 3 - 1;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(x - 1, 0),
              end: Alignment(x + 1, 0),
              colors: [c.surfaceHover, c.border, c.surfaceHover],
            ),
          ),
        );
      },
    );
  }
}

/// Squelette d'une liste de lignes (chargement d'un tableau).
class SkeletonRows extends StatelessWidget {
  const SkeletonRows({super.key, this.rows = 8});

  final int rows;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var i = 0; i < rows; i++)
        Container(
          height: VSize.tableRow,
          padding: const EdgeInsets.symmetric(horizontal: VSpace.x4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: context.colors.borderSubtle),
            ),
          ),
          child: Row(
            children: [
              const Skeleton(width: 14, height: 14, radius: 7),
              const SizedBox(width: VSpace.x3),
              Skeleton(width: 120.0 + (i * 37) % 90),
              const Spacer(),
              const Skeleton(width: 80),
            ],
          ),
        ),
    ],
  );
}

/// État vide soigné : icône, titre, explication, action.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(VSpace.x8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: VRadius.lgAll,
                  border: Border.all(color: c.border),
                  boxShadow: VShadows.sm(dark: c.isDark),
                ),
                child: Icon(icon, size: 22, color: c.textMuted),
              ),
              const SizedBox(height: VSpace.x4),
              Text(title, style: t.heading, textAlign: TextAlign.center),
              if (message != null) ...[
                const SizedBox(height: VSpace.x1_5),
                Text(message!, style: t.small, textAlign: TextAlign.center),
              ],
              if (action != null) ...[
                const SizedBox(height: VSpace.x5),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Avatar à initiales (couleur stable dérivée du nom).
class VAvatar extends StatelessWidget {
  const VAvatar(this.name, {super.key, this.size = 24});

  final String name;
  final double size;

  static const _palette = [
    Color(0xFF6366F1),
    Color(0xFF0EA5E9),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFF14B8A6),
    Color(0xFFF97316),
  ];

  @override
  Widget build(BuildContext context) {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    final initials = words.take(2).map((w) => w[0].toUpperCase()).join();
    final color = _palette[name.hashCode.abs() % _palette.length];
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        initials.isEmpty ? '?' : initials,
        style: context.text.caption.copyWith(
          color: Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
