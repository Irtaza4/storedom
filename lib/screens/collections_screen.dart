import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/common.dart';
import '../widgets/motion_object.dart';

class CollectionsScreen extends StatelessWidget {
  final ValueChanged<String> onCategory;
  const CollectionsScreen({super.key, required this.onCategory});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(24),
    children: [
      const Brand(),
      const SizedBox(height: 36),
      Text('GOOD THINGS, IN GOOD COMPANY', style: mono(color: purple)),
      const SizedBox(height: 12),
      Text('Find your\nfrequency.', style: display(52)),
      const SizedBox(height: 16),
      const Text(
        'Little worlds of things that just belong together.',
        style: TextStyle(color: muted),
      ),
      const SizedBox(height: 30),
      _collection(
        'Tech',
        'Tune out.\nTurn up.',
        '01 / THE SOUND & SIGNAL EDIT',
        0,
        const Color(0xFFDCD1ED),
        const Color(0xFFA48ACA),
      ),
      const SizedBox(height: 18),
      _collection(
        'Living',
        'Stay in.\nStand out.',
        '02 / THE SLOW LIVING EDIT',
        3,
        const Color(0xFFDFE6D8),
        const Color(0xFF819A70),
      ),
      const SizedBox(height: 30),
      Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: night,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome, color: lime, size: 30),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fewer things. Better things.',
                    style: display(23, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Thoughtfully picked. Never ordinary.\nThat’s the ODDLY point of view.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.6,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
  Widget _collection(
    String category,
    String title,
    String label,
    int art,
    Color stage,
    Color tint,
  ) => Semantics(
    button: true,
    label: 'Explore $category collection',
    child: InkWell(
      onTap: () => onCategory(category),
      borderRadius: BorderRadius.circular(28),
      child: Container(
        height: 275,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: stage,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -24,
              bottom: 0,
              width: 240,
              height: 240,
              child: MotionObject(kind: art, color: tint),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: mono(size: 8)),
                  const SizedBox(height: 18),
                  Text(title, style: display(36)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: ink,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ArrowLabel(
                      category,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
