import 'package:flutter/foundation.dart';
import '../models/product.dart';

class BagLine {
  final int productId;
  final String color;
  final int quantity;
  const BagLine(this.productId, this.color, this.quantity);
  Product get product => products[productId];
  int get subtotal => product.price * quantity;
}

/// One source of truth shared by catalogue, details, wishlist and checkout.
/// Deliberately in-memory: this demo never sends order or payment data.
class StoreController extends ChangeNotifier {
  final Set<int> _saved = {};
  final Map<(int, String), int> _bag = {};
  bool isSaved(int id) => _saved.contains(id);
  List<int> get savedIds => List.unmodifiable(_saved);
  List<BagLine> get lines => _bag.entries
      .map((e) => BagLine(e.key.$1, e.key.$2, e.value))
      .toList(growable: false);
  int get count => _bag.values.fold(0, (a, b) => a + b);
  int get total => lines.fold(0, (a, b) => a + b.subtotal);
  void toggleSaved(int id) {
    if (!_saved.add(id)) _saved.remove(id);
    notifyListeners();
  }

  void add(int id, String color, int quantity) {
    assert(quantity > 0);
    _bag.update((id, color), (v) => v + quantity, ifAbsent: () => quantity);
    notifyListeners();
  }

  void changeQuantity(BagLine line, int delta) {
    final key = (line.productId, line.color);
    final next = (_bag[key] ?? 0) + delta;
    if (next <= 0) {
      _bag.remove(key);
    } else {
      _bag[key] = next;
    }
    notifyListeners();
  }

  void clearBag() {
    _bag.clear();
    notifyListeners();
  }
}
