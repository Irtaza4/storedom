import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/product.dart';
import '../state/store_controller.dart';
import 'motion_object.dart';

Color? productColor(int id, [String color = 'Signature']) =>
    color == 'Soft sage'
    ? const Color(0xFF8CA592)
    : color == 'Rose'
    ? const Color(0xFFC68D94)
    : id == 4
    ? const Color(0xFF7B9CAE)
    : id == 5
    ? const Color(0xFFBE8092)
    : null;

class ProductCard extends StatelessWidget {
  final int id;
  final StoreController store;
  final VoidCallback onOpen;
  final String heroPrefix;
  const ProductCard({
    super.key,
    required this.id,
    required this.store,
    required this.onOpen,
    required this.heroPrefix,
  });
  @override
  Widget build(BuildContext context) {
    final p = products[id];
    return InkWell(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: p.stage,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: '$heroPrefix-$id',
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: MotionObject(
                          kind: p.art,
                          color: productColor(id),
                          phase: id * 1.3,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    top: 16,
                    child: Text(
                      '0${id + 1}',
                      style: mono(size: 9, color: ink.withValues(alpha: .45)),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: ListenableBuilder(
                      listenable: store,
                      builder: (_, _) => IconButton(
                        tooltip: store.isSaved(id)
                            ? 'Unsave ${p.name}'
                            : 'Save ${p.name}',
                        onPressed: () => store.toggleSaved(id),
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Icon(
                            store.isSaved(id)
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            key: ValueKey(store.isSaved(id)),
                            size: 19,
                            color: store.isSaved(id) ? purple : ink,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      width: 29,
                      height: 29,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.north_east_rounded, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            p.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(p.category.toUpperCase(), style: mono(size: 8)),
              const Spacer(),
              Text(
                '\$${p.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
