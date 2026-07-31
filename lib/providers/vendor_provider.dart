import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/service_locator.dart';
import '../services/api_service.dart';

class VendorProvider extends ChangeNotifier {
  final ApiService _api = ServiceLocator.api;

  Shop? _shop;
  List<Product> _products = [];
  List<Order> _orders = [];
  List<CustomerData> _customers = [];
  List<Review> _reviews = [];
  List<Conversation> _conversations = [];
  List<ChatMessage> _currentMessages = [];
  List<AppNotification> _notifications = [];
  List<TransactionData> _transactions = [];
  List<PayoutData> _payouts = [];
  List<MarketingCoupon> _coupons = [];
  List<FlashSaleData> _flashSales = [];
  List<SupportTicket> _tickets = [];
  List<HelpFaq> _faqs = [];
  List<AnalyticsDataPoint> _salesAnalytics = [];
  VendorStats? _stats;

  bool _isLoading = false;
  String? _error;

  Shop? get shop => _shop;
  List<Product> get products => List.unmodifiable(_products);
  List<Order> get orders => List.unmodifiable(_orders);
  List<CustomerData> get customers => List.unmodifiable(_customers);
  List<Review> get reviews => List.unmodifiable(_reviews);
  List<Conversation> get conversations => List.unmodifiable(_conversations);
  List<ChatMessage> get currentMessages => List.unmodifiable(_currentMessages);
  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  List<TransactionData> get transactions => List.unmodifiable(_transactions);
  List<PayoutData> get payouts => List.unmodifiable(_payouts);
  List<MarketingCoupon> get coupons => List.unmodifiable(_coupons);
  List<FlashSaleData> get flashSales => List.unmodifiable(_flashSales);
  List<SupportTicket> get tickets => List.unmodifiable(_tickets);
  List<HelpFaq> get faqs => List.unmodifiable(_faqs);
  List<AnalyticsDataPoint> get salesAnalytics => List.unmodifiable(_salesAnalytics);
  VendorStats? get stats => _stats;
  bool get isLoading => _isLoading;
  String? get error => _error;
  AppUser get currentUser => AppUser(id: 'vendor-1', name: 'Chidi Okafor', email: 'chidi@craftmarket.com', role: UserRole.vendor);

  Future<void> loadShop(String vendorId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _shop = await _api.getVendorShop(vendorId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateShop(String vendorId, Map<String, dynamic> updates) async {
    _isLoading = true;
    notifyListeners();

    try {
      _shop = await _api.updateVendorShop(vendorId, updates);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadProducts(String vendorId) async {
    try {
      _products = await _api.getVendorProducts(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> createProduct(String vendorId, Map<String, dynamic> data) async {
    try {
      final product = await _api.createVendorProduct(vendorId, data);
      _products.add(product);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(String vendorId, String productId, Map<String, dynamic> data) async {
    try {
      final updated = await _api.updateVendorProduct(vendorId, productId, data);
      final idx = _products.indexWhere((p) => p.id == productId);
      if (idx >= 0) _products[idx] = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct(String vendorId, String productId) async {
    try {
      await _api.deleteVendorProduct(vendorId, productId);
      _products.removeWhere((p) => p.id == productId);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> loadOrders(String vendorId) async {
    try {
      _orders = await _api.getVendorOrders(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> updateOrderStatus(String vendorId, String orderId, OrderStatus status) async {
    try {
      final updated = await _api.updateVendorOrderStatus(vendorId, orderId, status);
      final idx = _orders.indexWhere((o) => o.id == orderId);
      if (idx >= 0) _orders[idx] = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> loadCustomers(String vendorId) async {
    try {
      _customers = await _api.getVendorCustomers(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadAnalytics(String vendorId) async {
    try {
      _stats = await _api.getVendorAnalytics(vendorId);
      _salesAnalytics = await _api.getVendorSalesAnalytics(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadReviews(String vendorId) async {
    try {
      _reviews = await _api.getVendorReviews(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> replyToReview(String reviewId, String reply) async {
    try {
      final updated = await _api.replyToReview(reviewId, reply);
      final idx = _reviews.indexWhere((r) => r.id == reviewId);
      if (idx >= 0) _reviews[idx] = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> loadConversations(String vendorId) async {
    try {
      _conversations = await _api.getVendorConversations(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadMessages(String vendorId, String conversationId) async {
    try {
      _currentMessages = await _api.getVendorMessages(vendorId, conversationId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> sendMessage(String vendorId, String conversationId, String text) async {
    try {
      final msg = await _api.sendVendorMessage(vendorId, conversationId, text);
      _currentMessages.add(msg);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadNotifications(String vendorId) async {
    try {
      _notifications = await _api.getVendorNotifications(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> markNotificationRead(String vendorId, String notificationId) async {
    try {
      final updated = await _api.markVendorNotificationRead(vendorId, notificationId);
      final idx = _notifications.indexWhere((n) => n.id == notificationId);
      if (idx >= 0) _notifications[idx] = updated;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadTransactions(String vendorId) async {
    try {
      _transactions = await _api.getVendorTransactions(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadPayouts(String vendorId) async {
    try {
      _payouts = await _api.getVendorPayouts(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadCoupons(String vendorId) async {
    try {
      _coupons = await _api.getVendorCoupons(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadFlashSales(String vendorId) async {
    try {
      _flashSales = await _api.getVendorFlashSales(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadTickets(String vendorId) async {
    try {
      _tickets = await _api.getVendorTickets(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadFaqs(String vendorId) async {
    try {
      _faqs = await _api.getVendorFaqs(vendorId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadAll(String vendorId) async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([
      loadShop(vendorId),
      loadProducts(vendorId),
      loadOrders(vendorId),
      loadCustomers(vendorId),
      loadAnalytics(vendorId),
      loadReviews(vendorId),
      loadConversations(vendorId),
      loadNotifications(vendorId),
      loadTransactions(vendorId),
      loadPayouts(vendorId),
      loadCoupons(vendorId),
      loadFlashSales(vendorId),
      loadTickets(vendorId),
      loadFaqs(vendorId),
    ]);

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
