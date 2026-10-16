import 'package:flutter/material.dart';
import '../core/theme.dart';

class Brand extends StatelessWidget {
  final Color color;
  final double size;
  const Brand({super.key, this.color = ink, this.size = 32});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.adjust_rounded, color: color, size: size * .8),
      const SizedBox(width: 6),
      Text('oddly', style: display(size, color: color)),
      Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 2),
        child: Text('®', style: TextStyle(color: color, fontSize: 10)),
      ),
    ],
  );
}

class RoundButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color background, foreground;
  const RoundButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.background = Colors.white,
    this.foreground = ink,
  });
  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: label,
    onPressed: onTap,
    style: IconButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      minimumSize: const Size(48, 48),
    ),
    icon: Icon(icon, size: 21),
  );
}

class SectionHeading extends StatelessWidget {
  final String eyebrow, title;
  final Widget? trailing;
  const SectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.trailing,
  });
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(eyebrow, style: mono()),
            const SizedBox(height: 9),
            Text(title, style: display(31)),
          ],
        ),
      ),
      ?trailing,
    ],
  );
}

class EmptyState extends StatelessWidget {
  final String title, message, action;
  final VoidCallback onAction;
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.onAction,
    this.action = 'Explore objects',
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(color: lime, shape: BoxShape.circle),
          child: const Icon(Icons.auto_awesome, size: 32),
        ),
        const SizedBox(height: 24),
        Text(title, style: display(30), textAlign: TextAlign.center),
        const SizedBox(height: 12),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: muted),
        ),
        const SizedBox(height: 24),
        FilledButton(onPressed: onAction, child: Text(action)),
      ],
    ),
  );
}

class PageEntrance extends StatelessWidget {
  final Widget child;
  const PageEntrance({super.key, required this.child});
  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: Duration(
      milliseconds: MediaQuery.disableAnimationsOf(context) ? 0 : 550,
    ),
    curve: Curves.easeOutCubic,
    child: child,
    builder: (_, v, child) => Opacity(
      opacity: v,
      child: Transform.translate(offset: Offset(0, (1 - v) * 22), child: child),
    ),
  );
}

class ArrowLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const ArrowLabel(this.text, {super.key, this.style});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(child: Text(text, style: style)),
      const SizedBox(width: 8),
      Icon(Icons.north_east_rounded, size: 15, color: style?.color),
    ],
  );
}
