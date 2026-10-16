import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/product.dart';
import '../state/store_controller.dart';
import '../widgets/common.dart';
import '../widgets/feature_stage.dart';
import '../widgets/product_card.dart';

class CatalogScreen extends StatefulWidget {
  final StoreController store;
  final void Function(int, String) onOpen;
  final bool savedOnly;
  final String initialCategory;
  final VoidCallback? onExplore;
  const CatalogScreen({
    super.key,
    required this.store,
    required this.onOpen,
    this.savedOnly = false,
    this.initialCategory = 'All',
    this.onExplore,
  });
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late String category = widget.initialCategory;
  String query = '';
  bool search = false, priceSort = false;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.store,
    builder: (_, _) {
      final wide = MediaQuery.sizeOf(context).width > 760;
      final ids = List.generate(products.length, (i) => i)
          .where(
            (i) =>
                (!widget.savedOnly || widget.store.isSaved(i)) &&
                (category == 'All' || products[i].category == category) &&
                products[i].name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      if (priceSort) {
        ids.sort((a, b) => products[a].price.compareTo(products[b].price));
      }
      final prefix = widget.savedOnly ? 'saved' : 'catalog';
      return CustomScrollView(
        key: PageStorageKey(
          'catalog-${widget.savedOnly}-${widget.initialCategory}',
        ),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              wide ? 36 : 24,
              22,
              wide ? 36 : 24,
              24,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Brand(),
                      const Spacer(),
                      if (wide)
                        Text(
                          'GOOD DESIGN. A LITTLE STRANGE.',
                          style: mono(size: 9),
                        ),
                      if (wide) const SizedBox(width: 28),
                      RoundButton(
                        icon: search ? Icons.close : Icons.search_rounded,
                        label: search ? 'Close search' : 'Search objects',
                        onTap: () => setState(() {
                          search = !search;
                          query = '';
                        }),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    child: search
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextField(
                              autofocus: true,
                              onChanged: (v) => setState(() => query = v),
                              decoration: const InputDecoration(
                                hintText: 'Find your kind of different',
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                  const SizedBox(height: 28),
                  if (!widget.savedOnly && !search && category == 'All') ...[
                    FeatureStage(onOpen: widget.onOpen),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('INDEPENDENT SPIRIT.', style: mono(size: 8)),
                        const Icon(Icons.auto_awesome, size: 14, color: purple),
                        Text('EXCEPTIONAL EVERYDAY.', style: mono(size: 8)),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                  if (widget.savedOnly) ...[
                    Text('YOUR PERSONAL EDIT', style: mono(color: purple)),
                    const SizedBox(height: 12),
                    Text('Love at\nfirst odd.', style: display(wide ? 66 : 52)),
                    const SizedBox(height: 15),
                    Text(
                      '${widget.store.savedIds.length} favorites. Impeccable instincts.',
                      style: const TextStyle(color: muted),
                    ),
                    const SizedBox(height: 32),
                  ] else
                    SectionHeading(
                      eyebrow: 'THE ODDLY EDIT / VOL. 01',
                      title: category == 'All'
                          ? 'Everyday, elevated.'
                          : 'The $category edit.',
                      trailing: IconButton(
                        tooltip: 'Sort products',
                        onPressed: () => setState(() => priceSort = !priceSort),
                        icon: Icon(
                          priceSort ? Icons.trending_up : Icons.tune_rounded,
                        ),
                      ),
                    ),
                  if (!widget.savedOnly) ...[
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        for (final c in ['All', 'Tech', 'Living'])
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              showCheckmark: false,
                              label: Text(c == 'All' ? 'All objects' : c),
                              selected: category == c,
                              selectedColor: ink,
                              labelStyle: TextStyle(
                                color: category == c ? Colors.white : ink,
                                fontSize: 12,
                              ),
                              shape: const StadiumBorder(),
                              side: BorderSide(
                                color: category == c
                                    ? ink
                                    : const Color(0xFFDBD7D1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 9,
                              ),
                              onSelected: (_) => setState(() => category = c),
                            ),
                          ),
                      ],
                    ),
                    if (priceSort)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text('PRICE: LOW TO HIGH', style: mono(size: 8)),
                      ),
                  ],
                ],
              ),
            ),
          ),
          if (ids.isEmpty)
            SliverToBoxAdapter(
              child: EmptyState(
                title: widget.savedOnly
                    ? 'Your future favorites live here.'
                    : 'Nothing in this orbit.',
                message: widget.savedOnly
                    ? 'Tap a heart to start your own little collection.'
                    : 'Try a different search or category.',
                onAction: widget.savedOnly
                    ? widget.onExplore!
                    : () => setState(() {
                        query = '';
                        category = 'All';
                        search = false;
                      }),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: wide ? 36 : 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (_, index) => ProductCard(
                    id: ids[index],
                    store: widget.store,
                    heroPrefix: prefix,
                    onOpen: () => widget.onOpen(ids[index], prefix),
                  ),
                  childCount: ids.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: wide ? 4 : 2,
                  mainAxisExtent: wide ? 300 : 250,
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 16,
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Column(
                children: [
                  const Icon(Icons.adjust_rounded, color: purple),
                  const SizedBox(height: 10),
                  Text('NORMAL IS OVERRATED.', style: mono(size: 9)),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
