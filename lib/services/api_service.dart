import '../models/models.dart';

class ApiService {
  static final ApiService _instance = ApiService._();
  ApiService._();
  factory ApiService() => _instance;

  Future<AppUser> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return AppUser(id: '1', name: 'John Doe', email: email, role: UserRole.buyer);
  }

  Future<AppUser> signup(String name, String email, String phone, String password, UserRole role) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return AppUser(id: '1', name: name, email: email, phone: phone, role: role);
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<List<CartItem>> getCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<CartItem> addToCart(ProductWithShop product, {String variant = '', int quantity = 1}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return CartItem(product: product, variant: variant, quantity: quantity);
  }

  Future<void> removeFromCart(String productId, {String variant = ''}) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<CartItem> updateCartQuantity(String productId, {String variant = '', int quantity = 1}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return CartItem(product: ProductWithShop(id: productId, shopId: '', name: '', price: 0), quantity: quantity);
  }

  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<List<Order>> getUserOrders() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<Order?> getOrderById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return null;
  }

  Future<Order> createOrder({
    required List<OrderItem> items,
    required double subtotal,
    double deliveryFee = 0.0,
    required double total,
    required Address address,
    String deliveryMethod = 'Standard',
    String paymentMethod = 'Cash on Delivery',
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Order(
      id: 'new',
      orderNumber: 'MM-${DateTime.now().millisecondsSinceEpoch}',
      placedAt: DateTime.now(),
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      address: address,
    );
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status, {String? cancellationReason}) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<Shop> getVendorShop(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Shop(id: 's1', name: 'My Shop', category: 'General');
  }

  Future<Shop> updateVendorShop(String vendorId, Map<String, dynamic> updates) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Shop(id: 's1', name: 'My Shop', category: 'General');
  }

  Future<List<Product>> getVendorProducts(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<Product> createVendorProduct(String vendorId, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Product(id: 'p-new', name: data['name'] ?? '');
  }

  Future<Product> updateVendorProduct(String vendorId, String productId, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Product(id: productId, name: data['name'] ?? '');
  }

  Future<void> deleteVendorProduct(String vendorId, String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<List<Order>> getVendorOrders(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<Order> updateVendorOrderStatus(String vendorId, String orderId, OrderStatus status) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Order(id: orderId, orderNumber: '', placedAt: DateTime.now(), items: [], total: 0, address: Address());
  }

  Future<List<CustomerData>> getVendorCustomers(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<VendorStats> getVendorAnalytics(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return VendorStats();
  }

  Future<List<AnalyticsDataPoint>> getVendorSalesAnalytics(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<List<Review>> getVendorReviews(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<Review> replyToReview(String reviewId, String reply) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Review(id: reviewId, userName: '', date: DateTime.now());
  }

  Future<List<Conversation>> getVendorConversations(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<List<ChatMessage>> getVendorMessages(String vendorId, String conversationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<ChatMessage> sendVendorMessage(String vendorId, String conversationId, String text) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ChatMessage(id: 'm-new', senderId: vendorId, senderName: 'You', content: text, timestamp: DateTime.now(), isMe: true);
  }

  Future<List<AppNotification>> getVendorNotifications(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<AppNotification> markVendorNotificationRead(String vendorId, String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return AppNotification(id: notificationId, type: '', title: '', time: DateTime.now(), read: true);
  }

  Future<List<TransactionData>> getVendorTransactions(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<List<PayoutData>> getVendorPayouts(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<List<MarketingCoupon>> getVendorCoupons(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<List<FlashSaleData>> getVendorFlashSales(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<List<SupportTicket>> getVendorTickets(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<List<HelpFaq>> getVendorFaqs(String vendorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }
}
