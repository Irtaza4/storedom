import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../state/store_controller.dart';
import '../widgets/common.dart';
import '../widgets/motion_object.dart';
import '../widgets/product_card.dart';

class BagScreen extends StatelessWidget {
  final StoreController store;
  final VoidCallback onExplore, onCheckout;
  const BagScreen({
    super.key,
    required this.store,
    required this.onExplore,
    required this.onCheckout,
  });
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: store,
    builder: (_, _) => ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Brand(),
        const SizedBox(height: 36),
        Text('THE GOOD STUFF, ALL TOGETHER', style: mono(color: purple)),
        const SizedBox(height: 12),
        Text('In the bag.', style: display(52)),
        const SizedBox(height: 12),
        Text(
          '${store.count} objects. Zero ordinary choices.',
          style: const TextStyle(color: muted),
        ),
        const SizedBox(height: 30),
        if (store.lines.isEmpty)
          EmptyState(
            title: 'Room for something odd.',
            message: 'Your bag is waiting for a little personality.',
            onAction: onExplore,
          )
        else ...[
          ...store.lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 96,
                    height: 115,
                    decoration: BoxDecoration(
                      color: line.product.stage,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: MotionObject(
                      kind: line.product.art,
                      color: productColor(line.productId, line.color),
                      phase: line.productId.toDouble(),
                      amplitude: 4,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          line.product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(line.color.toUpperCase(), style: mono(size: 8)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(
                              width: 36,
                              height: 40,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                tooltip: 'Decrease ${line.product.name}',
                                onPressed: () => store.changeQuantity(line, -1),
                                icon: const Icon(Icons.remove, size: 16),
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 180),
                              child: Text(
                                '${line.quantity}',
                                key: ValueKey(line.quantity),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 36,
                              height: 40,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                tooltip: 'Increase ${line.product.name}',
                                onPressed: () => store.changeQuantity(line, 1),
                                icon: const Icon(Icons.add, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${line.subtotal}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9E1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('THE SUMMARY', style: mono(size: 9)),
                    const Icon(Icons.receipt_long_outlined, size: 18),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('Subtotal'), Text('\$${store.total}')],
                ),
                const SizedBox(height: 14),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery'),
                    Text('On us', style: TextStyle(color: purple)),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: display(26)),
                    Text('\$${store.total}', style: display(30)),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onCheckout,
                    child: const ArrowLabel('Make it yours'),
                  ),
                ),
                const SizedBox(height: 14),
                Text('DEMO CHECKOUT / NO PAYMENT TAKEN', style: mono(size: 8)),
              ],
            ),
          ),
        ],
        const SizedBox(height: 30),
      ],
    ),
  );
}
