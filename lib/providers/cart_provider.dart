import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/service_locator.dart';
import '../services/api_service.dart';

class CartProvider extends ChangeNotifier {
  final ApiService _api = ServiceLocator.api;

  List<CartItem> _items = [];
  bool _isLoading = false;

  List<CartItem> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await _api.getCart();
    } catch (_) {}

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addItem(ProductWithShop product, {String variant = '', int quantity = 1}) async {
    final item = await _api.addToCart(product, variant: variant, quantity: quantity);
    final existingIndex = _items.indexWhere(
      (c) => c.product.id == product.id && c.variant == variant,
    );
    if (existingIndex >= 0) {
      _items[existingIndex] = item;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  Future<void> removeItem(String productId, {String variant = ''}) async {
    await _api.removeFromCart(productId, variant: variant);
    _items.removeWhere((c) => c.product.id == productId && c.variant == variant);
    notifyListeners();
  }

  Future<void> updateQuantity(String productId, {String variant = '', required int quantity}) async {
    if (quantity <= 0) {
      await removeItem(productId, variant: variant);
      return;
    }
    final item = await _api.updateCartQuantity(productId, variant: variant, quantity: quantity);
    final idx = _items.indexWhere((c) => c.product.id == productId && c.variant == variant);
    if (idx >= 0) {
      _items[idx] = item;
    }
    notifyListeners();
  }

  Future<void> clear() async {
    await _api.clearCart();
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String productId) {
    return _items.any((c) => c.product.id == productId);
  }

  int getQuantity(String productId) {
    final item = _items.where((c) => c.product.id == productId);
    if (item.isNotEmpty) return item.first.quantity;
    return 0;
  }
}
