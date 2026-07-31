import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import '../order_tracking/order_tracking_screen.dart';

final List<BuyerOrder> _orders = [
  BuyerOrder(id: 'ord_1', orderNumber: 'MM-2026-001', placedAt: DateTime(2026, 7, 25, 10, 30), status: OrderStatus.delivered, deliveryMethod: 'Standard Delivery', paymentMethod: 'Cash on Delivery', items: [
    BuyerOrderItem(productId: 'prod_2', name: 'Sony PlayStation 5', variant: 'Standard', shopName: 'TechCity', price: 380000, quantity: 1, color: 'White'),
    BuyerOrderItem(productId: 'prod_7', name: 'Samsung Freepods Pro', shopName: 'PhoneHub', price: 25000, quantity: 2),
  ], subtotal: 430000, deliveryFee: 2500, total: 432500, address: Address(firstName: 'Chidi', lastName: 'Okeke', phone: '+234 802 222 3333', street: '42 Awolowo Road, Ikoyi', city: 'Lagos', state: 'Lagos'), estimatedDelivery: DateTime(2026, 7, 28)),
  BuyerOrder(id: 'ord_2', orderNumber: 'MM-2026-002', placedAt: DateTime(2026, 7, 27, 14, 15), status: OrderStatus.outForDelivery, deliveryMethod: 'Express Delivery', paymentMethod: 'Card Payment', items: [
    BuyerOrderItem(productId: 'prod_9', name: 'Premium Swiss Lace', variant: 'Ivory', shopName: 'GlobalFabrics', price: 37000, quantity: 1, color: 'Ivory'),
    BuyerOrderItem(productId: 'prod_10', name: 'Vlisco Ankara', variant: 'Blue Sapphire', shopName: 'GlobalFabrics', price: 28000, quantity: 2, color: 'Blue'),
  ], subtotal: 93000, deliveryFee: 3500, total: 96500, address: Address(firstName: 'Chidi', lastName: 'Okeke', phone: '+234 802 222 3333', street: '42 Awolowo Road, Ikoyi', city: 'Lagos', state: 'Lagos'), estimatedDelivery: DateTime(2026, 7, 28)),
  BuyerOrder(id: 'ord_3', orderNumber: 'MM-2026-003', placedAt: DateTime(2026, 7, 28, 9, 0), status: OrderStatus.packing, deliveryMethod: 'Standard Delivery', paymentMethod: 'Cash on Delivery', items: [
    BuyerOrderItem(productId: 'prod_5', name: 'iPhone 15 Pro Max', variant: '256GB', shopName: 'PhoneHub', price: 1250000, quantity: 1, color: 'Natural Titanium'),
    BuyerOrderItem(productId: 'prod_8', name: 'Anker Power Bank 20000mAh', shopName: 'PhoneHub', price: 18500, quantity: 1),
  ], subtotal: 1268500, deliveryFee: 0, total: 1268500, address: Address(firstName: 'Chidi', lastName: 'Okeke', phone: '+234 802 222 3333', street: '42 Awolowo Road, Ikoyi', city: 'Lagos', state: 'Lagos'), estimatedDelivery: DateTime(2026, 7, 31)),
  BuyerOrder(id: 'ord_4', orderNumber: 'MM-2026-004', placedAt: DateTime(2026, 7, 26, 16, 45), status: OrderStatus.confirmed, deliveryMethod: 'Standard Delivery', paymentMethod: 'Transfer', items: [
    BuyerOrderItem(productId: 'prod_13', name: 'Thermocool Chest Freezer 300L', variant: '300L', shopName: 'Kemis Home Appliances', price: 285000, quantity: 1, color: 'White'),
  ], subtotal: 285000, deliveryFee: 5000, total: 290000, address: Address(firstName: 'Chidi', lastName: 'Okeke', phone: '+234 802 222 3333', street: '42 Awolowo Road, Ikoyi', city: 'Lagos', state: 'Lagos'), estimatedDelivery: DateTime(2026, 8, 1)),
  BuyerOrder(id: 'ord_5', orderNumber: 'MM-2026-005', placedAt: DateTime(2026, 7, 20, 11, 20), status: OrderStatus.cancelled, deliveryMethod: 'Standard Delivery', paymentMethod: 'Cash on Delivery', items: [
    BuyerOrderItem(productId: 'prod_17', name: 'Gabriel Shock Absorbers (Pair)', variant: 'Front Pair', shopName: 'AutoParts Pro', price: 42000, quantity: 2),
    BuyerOrderItem(productId: 'prod_18', name: 'Michelin Tyres 205/55R16', shopName: 'AutoParts Pro', price: 65000, quantity: 4),
  ], subtotal: 344000, deliveryFee: 3000, total: 347000, address: Address(firstName: 'Chidi', lastName: 'Okeke', phone: '+234 802 222 3333', street: '42 Awolowo Road, Ikoyi', city: 'Lagos', state: 'Lagos'), cancellationReason: 'Changed mind'),
];

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (_orders.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0, title: Text('My Orders', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long_outlined, size: 80, color: AppColors.textHint.withOpacity(0.4)),
              const SizedBox(height: 16),
              Text('No orders yet', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 6),
              Text('Your orders will appear here', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('My Orders', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => _OrderCard(order: _orders[i]),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final BuyerOrder order;
  const _OrderCard({required this.order});

  Color _statusColor(OrderStatus s) {
    switch (s) {
      case OrderStatus.confirmed: return AppColors.blue;
      case OrderStatus.packing: return AppColors.primary;
      case OrderStatus.outForDelivery: return AppColors.orange;
      case OrderStatus.delivered: return AppColors.green;
      case OrderStatus.cancelled: return AppColors.red;
    }
  }

  String _statusLabel(OrderStatus s) {
    switch (s) {
      case OrderStatus.confirmed: return 'Confirmed';
      case OrderStatus.packing: return 'Packing';
      case OrderStatus.outForDelivery: return 'Out for Delivery';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderTrackingScreen(order: order))),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.orderNumber, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: _statusColor(order.status).withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                  child: Text(_statusLabel(order.status), style: GoogleFonts.sourceSans3(fontSize: 11, fontWeight: FontWeight.w600, color: _statusColor(order.status))),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('${order.placedAt.day}/${order.placedAt.month}/${order.placedAt.year}', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(width: 12),
                Text('${order.itemCount} item${order.itemCount != 1 ? 's' : ''}', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text('${item.name}${item.variant.isNotEmpty ? ' (${item.variant})' : ''} x${item.quantity}', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
            )),
            const Divider(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.payments_outlined, size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(order.paymentMethod, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textHint)),
                  ],
                ),
                Text('₦${order.total.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.accent)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
