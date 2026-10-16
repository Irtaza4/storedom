import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/product.dart';
import '../state/store_controller.dart';
import '../widgets/common.dart';
import '../widgets/motion_object.dart';
import '../widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  final int id;
  final String heroPrefix;
  final StoreController store;
  const ProductScreen({
    super.key,
    required this.id,
    required this.heroPrefix,
    required this.store,
  });
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String color = 'Signature';
  int quantity = 1;
  bool added = false;
  Product get product => products[widget.id];
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 760;
    return Scaffold(
      bottomNavigationBar: SafeArea(
        top: false,
        child: Center(
          heightFactor: 1,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFDDD8D0)),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'Decrease quantity',
                        onPressed: quantity > 1
                            ? () => setState(() {
                                quantity--;
                                added = false;
                              })
                            : null,
                        icon: const Icon(Icons.remove, size: 17),
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        tooltip: 'Increase quantity',
                        onPressed: () => setState(() {
                          quantity++;
                          added = false;
                        }),
                        icon: const Icon(Icons.add, size: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      widget.store.add(widget.id, color, quantity);
                      setState(() => added = true);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: added ? purple : ink,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        added
                            ? 'Added to your bag ✓'
                            : 'Add to bag · \$${product.price * quantity}',
                        key: ValueKey(added),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Row(
                  children: [
                    RoundButton(
                      icon: Icons.arrow_back_rounded,
                      label: 'Back to store',
                      onTap: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Text('THE OBJECT / 0${widget.id + 1}', style: mono()),
                    const Spacer(),
                    ListenableBuilder(
                      listenable: widget.store,
                      builder: (_, _) => RoundButton(
                        icon: widget.store.isSaved(widget.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        label: 'Save ${product.name}',
                        foreground: widget.store.isSaved(widget.id)
                            ? purple
                            : ink,
                        onTap: () => widget.store.toggleSaved(widget.id),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (wide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: stage(450)),
                      const SizedBox(width: 40),
                      Expanded(child: information()),
                    ],
                  )
                else ...[
                  stage(330),
                  const SizedBox(height: 26),
                  information(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget stage(double height) => AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    height: height,
    decoration: BoxDecoration(
      color: color == 'Soft sage'
          ? const Color(0xFFDDE8DE)
          : color == 'Rose'
          ? const Color(0xFFEEDDE1)
          : product.stage,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Hero(
              tag: '${widget.heroPrefix}-${widget.id}',
              child: MotionObject(
                kind: product.art,
                color: productColor(widget.id, color),
                amplitude: 12,
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Text('DESIGNED TO BE DIFFERENT', style: mono(size: 8)),
        ),
        Positioned(
          bottom: 18,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('THE ${color.toUpperCase()} EDIT', style: mono(size: 8)),
              const Icon(Icons.auto_awesome, size: 18, color: purple),
            ],
          ),
        ),
      ],
    ),
  );
  Widget information() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            '${product.category.toUpperCase()} / ODDLY ORIGINALS',
            style: mono(color: purple, size: 9),
          ),
          const Spacer(),
          const Icon(Icons.star_rounded, size: 15, color: purple),
          const SizedBox(width: 3),
          Text('CURATED', style: mono(size: 8)),
        ],
      ),
      const SizedBox(height: 12),
      Text(product.name, style: display(42)),
      const SizedBox(height: 12),
      Text(
        product.subtitle,
        style: const TextStyle(color: muted, fontSize: 13),
      ),
      const SizedBox(height: 20),
      Text('\$${product.price}.00', style: display(30)),
      const SizedBox(height: 24),
      const Divider(color: Color(0xFFDEDAD3)),
      const SizedBox(height: 18),
      Text('COLOR / ${color.toUpperCase()}', style: mono(size: 9)),
      const SizedBox(height: 14),
      Row(
        children: [
          for (final choice in ['Signature', 'Soft sage', 'Rose'])
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Semantics(
                label: choice,
                selected: color == choice,
                button: true,
                child: InkWell(
                  onTap: () => setState(() {
                    color = choice;
                    added = false;
                  }),
                  borderRadius: BorderRadius.circular(30),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(4),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color == choice ? ink : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            productColor(widget.id, choice) ??
                            [
                              const Color(0xFFAB8BCB),
                              const Color(0xFFE4A64A),
                              const Color(0xFF6C9384),
                              const Color(0xFFCC7654),
                            ][product.art],
                      ),
                      child: color == choice
                          ? const Icon(
                              Icons.check,
                              size: 17,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: 24),
      Text(
        product.description,
        style: const TextStyle(
          height: 1.8,
          fontSize: 13,
          color: Color(0xFF615B68),
        ),
      ),
      const SizedBox(height: 20),
      const Divider(color: Color(0xFFDEDAD3)),
      ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: const Text(
          'The little details',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              product.art == 0
                  ? 'Wireless connectivity · USB-C charging\nSoft-touch finish · Travel case included'
                  : product.art == 1
                  ? 'Rechargeable · Three brightness settings\nCordless design · Warm diffused light'
                  : product.art == 2
                  ? '12-hour battery · Wireless connectivity\nTactile fabric shell · USB-C charging'
                  : 'Curved frame · Soft upholstered seat\nLow profile · Made for slow living',
              style: const TextStyle(color: muted, fontSize: 12, height: 1.8),
            ),
          ),
        ],
      ),
      const ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          'Delivery & returns',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: Text(
              'This is a demo storefront. Shipping and 30-day returns are example store policies; demo orders are not shipped.',
              style: TextStyle(color: muted, fontSize: 12, height: 1.7),
            ),
          ),
        ],
      ),
      const SizedBox(height: 14),
      Row(
        children: [
          const Icon(Icons.inventory_2_outlined, size: 17, color: purple),
          const SizedBox(width: 8),
          Text('GOOD THINGS. THOUGHTFULLY PACKED.', style: mono(size: 8)),
        ],
      ),
      if (added)
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const ArrowLabel('See your bag'),
          ),
        ),
    ],
  );
}
