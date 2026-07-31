import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/service_locator.dart';
import '../services/api_service.dart';

class OrderProvider extends ChangeNotifier {
  final ApiService _api = ServiceLocator.api;

  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<Order> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await _api.getUserOrders();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Order?> getOrderById(String id) async {
    try {
      return await _api.getOrderById(id);
    } catch (_) {
      return null;
    }
  }

  Future<Order?> createOrder({
    required List<OrderItem> items,
    required double subtotal,
    double deliveryFee = 0.0,
    required double total,
    required Address address,
    String deliveryMethod = 'Standard',
    String paymentMethod = 'Cash on Delivery',
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final order = await _api.createOrder(
        items: items,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        total: total,
        address: address,
        deliveryMethod: deliveryMethod,
        paymentMethod: paymentMethod,
      );
      _orders.insert(0, order);
      _isLoading = false;
      notifyListeners();
      return order;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool> cancelOrder(String orderId, {String? reason}) async {
    try {
      await _api.updateOrderStatus(orderId, OrderStatus.cancelled, cancellationReason: reason);
      final idx = _orders.indexWhere((o) => o.id == orderId);
      if (idx >= 0) {
        final old = _orders[idx];
        _orders[idx] = Order(
          id: old.id,
          orderNumber: old.orderNumber,
          placedAt: old.placedAt,
          status: OrderStatus.cancelled,
          deliveryMethod: old.deliveryMethod,
          paymentMethod: old.paymentMethod,
          items: old.items,
          subtotal: old.subtotal,
          deliveryFee: old.deliveryFee,
          total: old.total,
          address: old.address,
          estimatedDelivery: old.estimatedDelivery,
          cancellationReason: reason,
        );
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((o) => o.status == status).toList();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
