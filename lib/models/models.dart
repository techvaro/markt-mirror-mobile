import 'package:flutter/material.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

enum TaskStatus { pending, inProgress, completed, requiresFix }

enum TaskPriority { high, medium, low }

enum NotificationType { assignment, approval, rejection, system }

enum VendorStatus { pending, approved, rejected }

enum PhotoType { front, inside, signboard, products, license }

class Task {
  final String id;
  final String title;
  final String vendorName;
  final String market;
  final DateTime dueDate;
  final TaskStatus status;
  final TaskPriority priority;
  final String? rejectionReason;
  final String? category;
  final String? description;
  final List<String> requiredActions;
  final DateTime? completedAt;
  final DateTime? approvedAt;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.vendorName,
    required this.market,
    required this.dueDate,
    required this.status,
    required this.priority,
    this.rejectionReason,
    this.category,
    this.description,
    this.requiredActions = const [],
    this.completedAt,
    this.approvedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class Vendor {
  final String id;
  final String businessName;
  final String ownerName;
  final String category;
  final String phone;
  final String email;
  final String market;
  final String shopNumber;
  final String registrationNumber;
  final String taxId;
  final String operatingHours;
  final int employeeCount;
  final String accessibilityNotes;
  final double latitude;
  final double longitude;
  final double accuracy;
  final VendorStatus status;
  final DateTime submissionDate;
  final Map<PhotoType, String> photos;
  final String? rejectionNote;

  const Vendor({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.category,
    required this.phone,
    required this.email,
    required this.market,
    required this.shopNumber,
    this.registrationNumber = '',
    this.taxId = '',
    this.operatingHours = '',
    this.employeeCount = 1,
    this.accessibilityNotes = '',
    this.latitude = 0,
    this.longitude = 0,
    this.accuracy = 0,
    this.status = VendorStatus.pending,
    required this.submissionDate,
    this.photos = const {},
    this.rejectionNote,
  });
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });
}

class Conversation {
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final String lastTime;
  final int unreadCount;
  final bool isOnline;

  const Conversation({
    required this.id,
    required this.name,
    this.avatar = '',
    required this.lastMessage,
    required this.lastTime,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isMe;
  final bool isImage;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    this.isMe = false,
    this.isImage = false,
  });
}

class Report {
  final String id;
  final String name;
  final DateTime date;
  final String size;
  final String url;

  const Report({
    required this.id,
    required this.name,
    required this.date,
    required this.size,
    this.url = '',
  });
}

class MapperStats {
  final int tasksCompleted;
  final int inProgress;
  final int pendingReview;
  final double performance;

  const MapperStats({
    this.tasksCompleted = 47,
    this.inProgress = 3,
    this.pendingReview = 8,
    this.performance = 94,
  });
}

class MarketCoverage {
  final String name;
  final double percentage;
  final Color color;

  const MarketCoverage({
    required this.name,
    required this.percentage,
    required this.color,
  });
}

class DailySummary {
  final int tasksCompleted;
  final int shopsMapped;
  final double approvalRate;

  const DailySummary({
    this.tasksCompleted = 12,
    this.shopsMapped = 45,
    this.approvalRate = 94,
  });
}

class UserProfile {
  final String name;
  final String employeeId;
  final String region;
  final String role;
  final String email;
  final String phone;
  final String avatarUrl;

  const UserProfile({
    this.name = 'James Mwangi',
    this.employeeId = 'MP-2024-0042',
    this.region = 'Nairobi Central',
    this.role = 'Field Mapper',
    this.email = 'james.mwangi@marketmirror.co.ke',
    this.phone = '+254 712 345 678',
    this.avatarUrl = '',
  });
}

String formatDate(DateTime date) {
  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

String formatTime(DateTime date) {
  final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
  final min = date.minute.toString().padLeft(2, '0');
  final ampm = date.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$min $ampm';
}

String relativeTime(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);
  if (diff.inSeconds < 60) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return formatDate(date);
}

String taskStatusLabel(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending: return 'Pending';
    case TaskStatus.inProgress: return 'In Progress';
    case TaskStatus.completed: return 'Completed';
    case TaskStatus.requiresFix: return 'Requires Fix';
  }
}

String taskPriorityLabel(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.high: return 'High';
    case TaskPriority.medium: return 'Medium';
    case TaskPriority.low: return 'Low';
  }
}

Color taskPriorityColor(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.high: return AppColors.priorityHigh;
    case TaskPriority.medium: return AppColors.priorityMedium;
    case TaskPriority.low: return AppColors.priorityLow;
  }
}

Color taskStatusBgColor(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending: return AppColors.warningLight;
    case TaskStatus.inProgress: return AppColors.infoLight;
    case TaskStatus.completed: return AppColors.successLight;
    case TaskStatus.requiresFix: return AppColors.errorLight;
  }
}

String vendorStatusLabel(VendorStatus status) {
  switch (status) {
    case VendorStatus.pending: return 'Pending';
    case VendorStatus.approved: return 'Approved';
    case VendorStatus.rejected: return 'Rejected';
  }
}

Color vendorStatusColor(VendorStatus status) {
  switch (status) {
    case VendorStatus.pending: return AppColors.warning;
    case VendorStatus.approved: return AppColors.success;
    case VendorStatus.rejected: return AppColors.error;
  }
}

class ProductOption {
  final String id;
  final String name;
  final double priceAdjustment;

  ProductOption({
    this.id = '',
    this.name = '',
    this.priceAdjustment = 0.0,
  });
}

class ProductVariant {
  final String id;
  final String name;
  final double price;
  final double priceAdjustment;
  final bool inStock;
  String type;
  String value;
  int stock;

  ProductVariant({
    this.id = '',
    this.name = '',
    this.price = 0.0,
    this.priceAdjustment = 0.0,
    this.inStock = true,
    this.type = '',
    this.value = '',
    this.stock = 0,
  });
}


class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String? imageUrl;
  final bool inStock;
  final double rating;
  final int reviewCount;
  final List<ProductVariant> variants;
  final String shopId;
  final String shopName;
  final String subcategory;
  final double displayPrice;
  final double discountPercentage;
  final String sku;
  final int stockQuantity;
  final bool isLowStock;
  final bool isOutOfStock;
  final List<String> tags;
  final String status;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.imageUrl,
    this.inStock = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.variants = const [],
    this.shopId = '',
    this.shopName = '',
    this.subcategory = '',
    this.displayPrice = 0.0,
    this.discountPercentage = 0.0,
    this.sku = '',
    this.stockQuantity = 0,
    this.isLowStock = false,
    this.isOutOfStock = false,
    this.tags = const [],
    this.status = '',
  });
}

class OrderItem {
  final String productId;
  final String name;
  final String variant;
  final double price;
  final int quantity;

  const OrderItem({
    required this.productId,
    required this.name,
    this.variant = '',
    this.price = 0.0,
    this.quantity = 1,
  });

  double get total => price * quantity;
}

class Order {
  final String id;
  final String orderNumber;
  final DateTime placedAt;
  final OrderStatus status;
  final String deliveryMethod;
  final String paymentMethod;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final Address address;
  final DateTime? estimatedDelivery;
  final String? cancellationReason;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final DateTime date;
  final String shippingAddress;
  final String shippingCity;
  final double shipping;
  final String orderStatus;
  final String paymentStatus;
  final String itemSummary;
  final String customerId;

  Order({
    required this.id,
    required this.orderNumber,
    DateTime? placedAt,
    this.status = OrderStatus.confirmed,
    this.deliveryMethod = '',
    this.paymentMethod = '',
    required this.items,
    this.subtotal = 0.0,
    this.deliveryFee = 0.0,
    required this.total,
    Address? address,
    this.estimatedDelivery,
    this.cancellationReason,
    this.customerName = '',
    this.customerEmail = '',
    this.customerPhone = '',
    DateTime? date,
    this.shippingAddress = '',
    this.shippingCity = '',
    this.shipping = 0.0,
    this.orderStatus = '',
    this.paymentStatus = '',
    this.itemSummary = '',
    this.customerId = '',
  })  : placedAt = placedAt ?? DateTime.now(),
        date = date ?? DateTime.now(),
        address = address ?? Address();
}

class Customer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String address;
  final int ordersCount;
  final int orderCount;
  final double totalSpend;
  final double totalSpent;
  final double rating;
  final DateTime lastOrder;
  final String status;

  Customer({
    required this.id,
    required this.name,
    this.email = '',
    this.phone = '',
    this.location = '',
    this.address = '',
    this.ordersCount = 0,
    this.orderCount = 0,
    this.totalSpend = 0.0,
    this.totalSpent = 0.0,
    this.rating = 0.0,
    DateTime? lastOrder,
    this.status = 'active',
  }) : lastOrder = lastOrder ?? DateTime.now();
}
typedef CustomerData = Customer;

class Review {
  final String id;
  final String userName;
  final String avatar;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String> images;
  final String customerName;
  final String productName;
  final String productId;
  final String? reply;

  Review({
    required this.id,
    String? userName,
    this.avatar = '',
    this.rating = 0.0,
    this.comment = '',
    required this.date,
    this.images = const [],
    this.customerName = '',
    this.productName = '',
    this.productId = '',
    this.reply,
  }) : userName = userName ?? customerName;
}

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isMe;
  final bool isImage;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    this.isMe = false,
    this.isImage = false,
  });
}

class TransactionData {
  final String id;
  final String orderId;
  final String customerName;
  final double amount;
  final DateTime date;
  final String status;
  final String method;

  const TransactionData({
    required this.id,
    required this.orderId,
    required this.customerName,
    required this.amount,
    required this.date,
    this.status = 'completed',
    this.method = '',
  });
}

class PayoutData {
  final String id;
  final double amount;
  final DateTime date;
  final String status;
  final String method;

  const PayoutData({
    required this.id,
    required this.amount,
    required this.date,
    this.status = 'pending',
    this.method = '',
  });
}

class DiscountCode {
  final String id;
  final String code;
  final String title;
  final String description;
  final String discountType;
  final double discountValue;
  final double value;
  final DateTime validUntil;
  final DateTime validity;
  final int usageCount;
  final int maxUsage;
  final int usageLimit;
  final String status;
  final bool isActive;

  DiscountCode({
    required this.id,
    required this.code,
    this.title = '',
    this.description = '',
    this.discountType = 'percentage',
    this.discountValue = 0.0,
    this.value = 0.0,
    DateTime? validUntil,
    DateTime? validity,
    this.usageCount = 0,
    this.maxUsage = 100,
    this.usageLimit = 100,
    this.status = 'active',
    this.isActive = true,
  })  : validUntil = validUntil ?? validity ?? DateTime.now(),
        validity = validity ?? validUntil ?? DateTime.now();
}
typedef MarketingCoupon = DiscountCode;

class FlashSale {
  final String id;
  final String name;
  final String productId;
  final String productName;
  final double originalPrice;
  final double salePrice;
  final double discountPercentage;
  final DateTime startTime;
  final DateTime endTime;
  final int soldCount;
  final int stockCount;
  final int productsCount;
  final String status;
  final bool isActive;

  FlashSale({
    required this.id,
    this.name = '',
    this.productId = '',
    this.productName = '',
    this.originalPrice = 0.0,
    this.salePrice = 0.0,
    this.discountPercentage = 0.0,
    DateTime? startTime,
    DateTime? endTime,
    this.soldCount = 0,
    this.stockCount = 100,
    this.productsCount = 0,
    this.status = 'active',
    this.isActive = true,
  })  : startTime = startTime ?? DateTime.now(),
        endTime = endTime ?? DateTime.now().add(const Duration(hours: 24));
}
typedef FlashSaleData = FlashSale;

class SupportTicket {
  final String id;
  final String subject;
  final String message;
  final String description;
  final String category;
  final String status;
  final DateTime createdAt;
  final DateTime date;
  final String? response;

  SupportTicket({
    required this.id,
    required this.subject,
    this.message = '',
    this.description = '',
    this.category = '',
    this.status = 'open',
    DateTime? createdAt,
    DateTime? date,
    this.response,
  })  : createdAt = createdAt ?? date ?? DateTime.now(),
        date = date ?? createdAt ?? DateTime.now();
}

class FAQ {
  final String id;
  final String question;
  final String answer;
  final String category;

  const FAQ({
    this.id = '',
    required this.question,
    required this.answer,
    this.category = '',
  });
}
typedef HelpFaq = FAQ;

class InventorySummary {
  final int totalItems;
  final int totalProducts;
  final int inStock;
  final int lowStockItems;
  final int lowStock;
  final int outOfStockItems;
  final int outOfStock;
  final double inventoryValue;

  const InventorySummary({
    this.totalItems = 0,
    this.totalProducts = 0,
    this.inStock = 0,
    this.lowStockItems = 0,
    this.lowStock = 0,
    this.outOfStockItems = 0,
    this.outOfStock = 0,
    this.inventoryValue = 0.0,
  });
}



class AnalyticsDataPoint {
  final String label;
  final double value;

  const AnalyticsDataPoint({
    required this.label,
    required this.value,
  });
}

class VendorStats {
  final double totalRevenue;
  final int totalOrders;
  final int totalProducts;
  final double averageRating;
  final int totalCustomers;
  final double growthRate;
  final double todaysSales;
  final int todaysOrders;
  final int pendingOrders;
  final int completedOrders;
  final List<double> revenue7Days;
  final List<int> orders7Days;

  VendorStats({
    this.totalRevenue = 0.0,
    this.totalOrders = 0,
    this.totalProducts = 0,
    this.averageRating = 0.0,
    this.totalCustomers = 0,
    this.growthRate = 0.0,
    this.todaysSales = 0.0,
    this.todaysOrders = 0,
    this.pendingOrders = 0,
    this.completedOrders = 0,
    this.revenue7Days = const [0, 0, 0, 0, 0, 0, 0],
    this.orders7Days = const [0, 0, 0, 0, 0, 0, 0],
  });
}

enum UserRole { buyer, vendor, mapper, admin }

class AppUser {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? location;
  final UserRole role;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.location,
    this.role = UserRole.buyer,
  });
}

class Shop {
  final String id;
  final String name;
  final String category;
  final String description;
  final String location;
  final String city;
  final String market;
  final String building;
  final String phone;
  final String hours;
  final String shopNumber;
  final String bannerGradient;
  final double rating;
  final int reviewCount;
  final int productCount;
  final List<String> images;
  final bool verified;

  Shop({
    required this.id,
    required this.name,
    required this.category,
    this.description = '',
    this.location = '',
    this.city = '',
    this.market = '',
    this.building = '',
    this.phone = '',
    this.hours = '',
    this.shopNumber = '',
    this.bannerGradient = '',
    this.rating = 0.0,
    this.reviewCount = 0,
    this.productCount = 0,
    this.images = const [],
    this.verified = false,
  });

  static List<Color> parseGradient(String gradientStr) {
    try {
      if (gradientStr.contains('#')) {
        final matches = RegExp(r'#([0-9a-fA-F]{6})').allMatches(gradientStr).toList();
        if (matches.length >= 2) {
          return [
            Color(int.parse('FF${matches[0].group(1)}', radix: 16)),
            Color(int.parse('FF${matches[1].group(1)}', radix: 16)),
          ];
        } else if (matches.length == 1) {
          final c = Color(int.parse('FF${matches[0].group(1)}', radix: 16));
          return [c, c];
        }
      }
    } catch (_) {}
    return const [Color(0xFF667EEA), Color(0xFF764BA2)];
  }
}

class ProductWithShop {
  final String id;
  final String shopId;
  final String name;
  final String description;
  final String category;
  final double price;
  final String? imageUrl;
  final bool inStock;
  final double rating;
  final int reviewCount;
  final String shopName;
  final List<ProductVariant> variants;

  ProductWithShop({
    required this.id,
    required this.shopId,
    required this.name,
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.imageUrl,
    this.inStock = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.shopName = '',
    this.variants = const [],
  });
}

class CartItem {
  final ProductWithShop product;
  final String variant;
  int quantity;

  CartItem({
    required this.product,
    this.variant = '',
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}

class Address {
  final String firstName;
  final String lastName;
  final String phone;
  final String street;
  final String city;
  final String state;

  Address({
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.street = '',
    this.city = '',
    this.state = '',
  });

  String get fullName => '$firstName $lastName';
  String get fullAddress => '$street, $city, $state';
}

enum OrderStatus { confirmed, packing, outForDelivery, delivered, cancelled }

class BuyerOrder {
  final String id;
  final String orderNumber;
  final DateTime placedAt;
  final OrderStatus status;
  final String deliveryMethod;
  final String paymentMethod;
  final List<BuyerOrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final Address address;
  final DateTime? estimatedDelivery;
  final String? cancellationReason;
  final String riderName;
  final String riderPhone;

  BuyerOrder({
    required this.id,
    required this.orderNumber,
    required this.placedAt,
    this.status = OrderStatus.confirmed,
    this.deliveryMethod = '',
    this.paymentMethod = '',
    required this.items,
    this.subtotal = 0.0,
    this.deliveryFee = 0.0,
    required this.total,
    required this.address,
    this.estimatedDelivery,
    this.cancellationReason,
    this.riderName = 'Emeka Okafor',
    this.riderPhone = '+234 803 456 7890',
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}

class BuyerOrderItem {
  final String productId;
  final String name;
  final String variant;
  final String shopName;
  final double price;
  final int quantity;
  final String color;

  BuyerOrderItem({
    required this.productId,
    required this.name,
    this.variant = '',
    this.shopName = '',
    required this.price,
    required this.quantity,
    this.color = '',
  });

  double get total => price * quantity;
}

class BuyerConversation {
  final String id;
  final String shopId;
  final String shopName;
  final String category;
  final String lastMessage;
  final String time;
  final int unread;
  final bool online;

  BuyerConversation({
    required this.id,
    required this.shopId,
    required this.shopName,
    this.category = '',
    this.lastMessage = '',
    this.time = '',
    this.unread = 0,
    this.online = false,
  });
}

class AppNotification {
  final String id;
  final String type;
  final String title;
  final String message;
  final DateTime time;
  final bool read;
  final String? link;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    this.message = '',
    required this.time,
    this.read = false,
    this.link,
  });
}

class Dispute {
  final String id;
  final String orderId;
  final String reason;
  final String description;
  final String status;
  final DateTime createdAt;

  Dispute({
    required this.id,
    required this.orderId,
    required this.reason,
    this.description = '',
    this.status = 'open',
    required this.createdAt,
  });
}

class NigerianState {
  final String name;
  final List<String> markets;

  NigerianState({
    required this.name,
    this.markets = const [],
  });
}

extension OrderStatusLabel on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.confirmed: return 'Confirmed';
      case OrderStatus.packing: return 'Packing';
      case OrderStatus.outForDelivery: return 'Out for Delivery';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
    }
  }
}
