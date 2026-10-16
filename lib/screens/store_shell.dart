import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../state/store_controller.dart';
import '../widgets/common.dart';
import 'bag_screen.dart';
import 'catalog_screen.dart';
import 'checkout_screen.dart';
import 'collections_screen.dart';
import 'product_screen.dart';

class StoreShell extends StatefulWidget {
  final StoreController store;
  const StoreShell({super.key, required this.store});
  @override
  State<StoreShell> createState() => _StoreShellState();
}

class _StoreShellState extends State<StoreShell> {
  int tab = 0;
  String category = 'All';
  Future<void> openProduct(int id, String prefix) async {
    final openBag = await Navigator.push<bool>(
      context,
      objectRoute(
        context,
        ProductScreen(id: id, heroPrefix: prefix, store: widget.store),
      ),
    );
    if (openBag == true && mounted) setState(() => tab = 3);
  }

  Future<void> checkout() async {
    final complete = await Navigator.push<bool>(
      context,
      objectRoute(context, Checkout(total: widget.store.total)),
    );
    if (complete == true && mounted) {
      widget.store.clearBag();
      setState(() {
        tab = 0;
        category = 'All';
      });
    }
  }

  void discover() => setState(() {
    tab = 0;
    category = 'All';
  });
  @override
  Widget build(BuildContext context) {
    final pages = [
      CatalogScreen(
        key: ValueKey('catalog-$category'),
        store: widget.store,
        onOpen: openProduct,
        initialCategory: category,
      ),
      CollectionsScreen(
        onCategory: (value) => setState(() {
          category = value;
          tab = 0;
        }),
      ),
      CatalogScreen(
        key: const ValueKey('saved'),
        store: widget.store,
        onOpen: openProduct,
        savedOnly: true,
        onExplore: discover,
      ),
      BagScreen(store: widget.store, onExplore: discover, onCheckout: checkout),
    ];
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: AnimatedSwitcher(
              duration: Duration(
                milliseconds: MediaQuery.disableAnimationsOf(context) ? 0 : 350,
              ),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(.035, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: KeyedSubtree(
                key: ValueKey('$tab-$category'),
                child: PageEntrance(child: pages[tab]),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Center(
          heightFactor: 1,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            margin: const EdgeInsets.fromLTRB(18, 8, 18, 12),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: night,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: night.withValues(alpha: .15),
                  blurRadius: 24,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: ListenableBuilder(
              listenable: widget.store,
              builder: (_, _) => Row(
                children: [
                  nav(0, Icons.grid_view_rounded, 'Discover'),
                  nav(1, Icons.category_outlined, 'Edits'),
                  nav(2, Icons.favorite_border_rounded, 'Saved'),
                  nav(
                    3,
                    Icons.shopping_bag_outlined,
                    widget.store.count > 0
                        ? 'Bag · ${widget.store.count}'
                        : 'Bag',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nav(int index, IconData icon, String label) => Expanded(
    child: Semantics(
      selected: tab == index,
      button: true,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => setState(() {
          tab = index;
          if (index == 0) category = 'All';
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: tab == index ? lime : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: tab == index ? ink : Colors.white54),
              const SizedBox(height: 5),
              Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: tab == index ? ink : Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
