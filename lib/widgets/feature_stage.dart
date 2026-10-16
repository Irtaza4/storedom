import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/product.dart';
import 'motion_object.dart';
import 'common.dart';
import 'product_card.dart';

class FeatureStage extends StatefulWidget {
  final void Function(int id, String prefix) onOpen;
  const FeatureStage({super.key, required this.onOpen});
  @override
  State<FeatureStage> createState() => _FeatureStageState();
}

class _FeatureStageState extends State<FeatureStage> {
  int _index = 0;
  static const _ids = [0, 1, 3];
  static const _titles = [
    'Less ordinary.\nMore you.',
    'A brighter\nkind of weird.',
    'Take a seat.\nStay a while.',
  ];
  static const _colors = [
    Color(0xFF7051B0),
    Color(0xFF9B593E),
    Color(0xFF4D7061),
  ];
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, bounds) {
      final wide = bounds.maxWidth > 650;
      final id = _ids[_index];
      return AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        height: wide ? 440 : 490,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _colors[_index],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Positioned(
              right: wide ? 30 : -60,
              top: wide ? -35 : 190,
              child: Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .15),
                  ),
                ),
              ),
            ),
            Positioned(
              right: wide ? 65 : -18,
              bottom: wide ? 5 : 25,
              width: wide ? 420 : 280,
              height: wide ? 420 : 280,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: SizedBox.expand(
                  key: ValueKey(id),
                  child: Hero(
                    tag: 'feature-$id',
                    child: MotionObject(
                      kind: products[id].art,
                      color:
                          productColor(id) ??
                          (id == 0 ? const Color(0xFFCEB9F1) : null),
                      amplitude: 12,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(wide ? 38 : 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, size: 14, color: lime),
                      const SizedBox(width: 8),
                      Text(
                        'OBJECTS WITH MAIN CHARACTER ENERGY',
                        style: mono(
                          color: Colors.white70,
                          size: wide ? 10 : 7.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: Align(
                      key: ValueKey(_index),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _titles[_index],
                        style: display(wide ? 66 : 46, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Life’s too short for boring things.\nMake a little room for different.',
                    style: TextStyle(
                      color: Color(0xFFE6DBF2),
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 22),
                  FilledButton(
                    onPressed: () => widget.onOpen(id, 'feature'),
                    style: FilledButton.styleFrom(
                      backgroundColor: lime,
                      foregroundColor: ink,
                      minimumSize: const Size(150, 48),
                    ),
                    child: const ArrowLabel(
                      'Explore the object',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text('0${_index + 1}', style: mono(color: Colors.white)),
                      Text(' / 03', style: mono(color: Colors.white38)),
                      const Spacer(),
                      ...List.generate(
                        3,
                        (i) => Semantics(
                          label: 'Show featured object ${i + 1}',
                          button: true,
                          selected: _index == i,
                          child: InkWell(
                            onTap: () => setState(() => _index = i),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 14,
                              ),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 3,
                                width: _index == i ? 28 : 12,
                                color: _index == i ? lime : Colors.white30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 22,
              top: wide ? 30 : 246,
              child: Transform.rotate(
                angle: .12,
                child: Container(
                  width: 69,
                  height: 69,
                  decoration: const BoxDecoration(
                    color: lime,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'ODDLY\nOBSESSED',
                      textAlign: TextAlign.center,
                      style: mono(color: ink, size: 9),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
