import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final TextEditingController _searchCtrl = TextEditingController();
  final List<String> _tabs = ['All', 'Confirmed', 'Packing', 'Out for Delivery', 'Delivered', 'Cancelled'];

  List<Order> _orders = [
    Order(id: 'o1', orderNumber: 'ORD-001', date: DateTime.now().subtract(const Duration(hours: 2)), customerName: 'Amara Eze', total: 12500.0, paymentStatus: 'paid', orderStatus: 'delivered', items: [OrderItem(productId: 'p1', name: 'Handwoven Basket', quantity: 2, price: 6250.0)], subtotal: 12500.0, shipping: 0.0, shippingAddress: '12 Awolowo Road', shippingCity: 'Ikeja, Lagos', paymentMethod: 'Card'),
    Order(id: 'o2', orderNumber: 'ORD-002', date: DateTime.now().subtract(const Duration(hours: 5)), customerName: 'Tunde Balogun', total: 8500.0, paymentStatus: 'paid', orderStatus: 'packing', items: [OrderItem(productId: 'p2', name: 'Beaded Necklace', quantity: 1, price: 8500.0)], subtotal: 8500.0, shipping: 500.0, shippingAddress: '45 Marina Street', shippingCity: 'Victoria Island, Lagos', paymentMethod: 'Transfer'),
    Order(id: 'o3', orderNumber: 'ORD-003', date: DateTime.now().subtract(const Duration(hours: 8)), customerName: 'Ngozi Okafor', total: 32000.0, paymentStatus: 'pending', orderStatus: 'confirmed', items: [OrderItem(productId: 'p3', name: 'Canvas Painting', quantity: 1, price: 32000.0)], subtotal: 32000.0, shipping: 0.0, shippingAddress: '8 Bishop Oluwole', shippingCity: 'Ikeja, Lagos', paymentMethod: 'Card'),
    Order(id: 'o4', orderNumber: 'ORD-004', date: DateTime.now().subtract(const Duration(days: 1)), customerName: 'Kelechi Nwosu', total: 5600.0, paymentStatus: 'paid', orderStatus: 'delivered', items: [OrderItem(productId: 'p4', name: 'Leather Pouch', quantity: 2, price: 2800.0)], subtotal: 5600.0, shipping: 0.0),
    Order(id: 'o5', orderNumber: 'ORD-005', date: DateTime.now().subtract(const Duration(days: 1)), customerName: 'Chioma Obi', total: 18000.0, paymentStatus: 'paid', orderStatus: 'out_for_delivery', items: [OrderItem(productId: 'p5', name: 'Ankara Dress', quantity: 1, price: 18000.0)], subtotal: 18000.0, shipping: 1000.0),
    Order(id: 'o6', orderNumber: 'ORD-006', date: DateTime.now().subtract(const Duration(days: 2)), customerName: 'Femi Adekunle', total: 7500.0, paymentStatus: 'refunded', orderStatus: 'cancelled', items: [OrderItem(productId: 'p6', name: 'Wooden Sculpture', quantity: 1, price: 7500.0)], subtotal: 7500.0, shipping: 0.0),
    Order(id: 'o7', orderNumber: 'ORD-007', date: DateTime.now().subtract(const Duration(days: 3)), customerName: 'Zainab Abdullah', total: 22000.0, paymentStatus: 'paid', orderStatus: 'packing', items: [OrderItem(productId: 'p1', name: 'Handwoven Basket', quantity: 1, price: 6250.0), OrderItem(productId: 'p5', name: 'Ankara Dress', quantity: 1, price: 18000.0)], subtotal: 24250.0, shipping: 0.0),
  ];

  List<Order> get _filteredOrders {
    var list = _orders;
    if (_tabCtrl.index != 0) {
      final statusMap = ['all', 'confirmed', 'packing', 'out_for_delivery', 'delivered', 'cancelled'];
      list = list.where((o) => o.orderStatus == statusMap[_tabCtrl.index]).toList();
    }
    if (_searchCtrl.text.isNotEmpty) {
      final q = _searchCtrl.text.toLowerCase();
      list = list.where((o) => o.orderNumber.toLowerCase().contains(q) || o.customerName.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 6, vsync: this);
    _tabCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = _filteredOrders;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Orders', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 18, color: AppColors.textHint),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (_) => setState(() {}),
                      style: GoogleFonts.inter(fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'Search orders...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabCtrl,
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textHint,
              indicatorColor: AppColors.primary,
              labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
              unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: orders.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: orders.length,
                    itemBuilder: (_, i) => _buildOrderCard(orders[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.orderNumber, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
              _statusBadge(order.orderStatus),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text('${order.date.day}/${order.date.month}/${order.date.year}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
              const SizedBox(width: 16),
              Icon(Icons.person_outline, size: 12, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text(order.customerName, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.itemSummary, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
              Row(
                children: [
                  _paymentBadge(order.paymentStatus),
                  const SizedBox(width: 8),
                  Text('₦${order.total.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showOrderDetail(order),
              child: Text('View Details', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetail(Order order) {
    final steps = ['Confirmed', 'Packing', 'Out for Delivery', 'Delivered'];
    final statusMap = ['confirmed', 'packing', 'out_for_delivery', 'delivered'];
    final currentStep = statusMap.indexOf(order.orderStatus);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.divider)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.orderNumber, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                        IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Fulfillment stepper
                    Row(
                      children: List.generate(steps.length, (i) {
                        final isCompleted = i <= currentStep;
                        final isCurrent = i == currentStep;
                        return Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  if (i > 0)
                                    Expanded(
                                      child: Container(
                                        height: 2,
                                        color: isCompleted ? AppColors.primary : AppColors.border,
                                      ),
                                    ),
                                  Container(
                                    width: isCurrent ? 28 : 24,
                                    height: isCurrent ? 28 : 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isCurrent ? AppColors.primary : (isCompleted ? AppColors.primary.withOpacity(0.2) : Colors.white),
                                      border: Border.all(color: isCurrent || isCompleted ? AppColors.primary : AppColors.border, width: 2),
                                    ),
                                    child: Center(
                                      child: isCompleted
                                          ? Icon(Icons.check, size: 14, color: isCurrent ? Colors.white : AppColors.primary)
                                          : Text('${i + 1}', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textHint)),
                                    ),
                                  ),
                                  if (i < steps.length - 1)
                                    Expanded(
                                      child: Container(
                                        height: 2,
                                        color: isCompleted ? AppColors.primary : AppColors.border,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(steps[i], style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                                color: isCurrent ? AppColors.primary : AppColors.textHint,
                              )),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    // Action buttons
                    Row(
                      children: [
                        if (currentStep < steps.length - 1 && currentStep >= 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final next = statusMap[currentStep + 1];
                                setState(() {
                                  final idx = _orders.indexWhere((o) => o.id == order.id);
                                  if (idx >= 0) {
                                    _orders[idx] = Order(id: order.id, orderNumber: order.orderNumber, date: order.date, customerId: order.customerId, customerName: order.customerName, items: order.items, subtotal: order.subtotal, shipping: order.shipping, total: order.total, paymentStatus: order.paymentStatus, orderStatus: next);
                                  }
                                });
                                Navigator.pop(ctx);
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              child: Text('Mark as ${steps[currentStep + 1]}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        if (currentStep <= 0 && currentStep >= 0) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  final idx = _orders.indexWhere((o) => o.id == order.id);
                                  if (idx >= 0) {
                                    _orders[idx] = Order(id: order.id, orderNumber: order.orderNumber, date: order.date, customerId: order.customerId, customerName: order.customerName, items: order.items, subtotal: order.subtotal, shipping: order.shipping, total: order.total, paymentStatus: order.paymentStatus, orderStatus: 'cancelled');
                                  }
                                });
                                Navigator.pop(ctx);
                              },
                              style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.red), padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              child: Text('Cancel Order', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.red)),
                            ),
                          ),
                        ],
                        if (order.orderStatus == 'cancelled')
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  final idx = _orders.indexWhere((o) => o.id == order.id);
                                  if (idx >= 0) {
                                    _orders[idx] = Order(id: order.id, orderNumber: order.orderNumber, date: order.date, customerId: order.customerId, customerName: order.customerName, items: order.items, subtotal: order.subtotal, shipping: order.shipping, total: order.total, paymentStatus: order.paymentStatus, orderStatus: 'confirmed');
                                  }
                                });
                                Navigator.pop(ctx);
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                              child: Text('Reopen', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        if (order.paymentStatus == 'paid' && order.orderStatus == 'delivered')
                          TextButton(
                            onPressed: () {},
                            child: Text('Refund', style: GoogleFonts.inter(fontSize: 12, color: AppColors.red)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TabBar(
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.textHint,
                      indicatorColor: AppColors.primary,
                      labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                      tabs: const [Tab(text: 'Details'), Tab(text: 'Items')],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildOrderDetailsTab(order),
                    _buildOrderItemsTab(order),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailsTab(Order order) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Information', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _infoRow('Address', order.shippingAddress ?? 'N/A'),
          _infoRow('City', order.shippingCity ?? 'N/A'),
          _infoRow('Customer', order.customerName),
          _infoRow('Email', order.customerEmail ?? 'N/A'),
          _infoRow('Phone', order.customerPhone ?? 'N/A'),
          const SizedBox(height: 16),
          Text('Payment Information', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _infoRow('Method', order.paymentMethod ?? 'N/A'),
          _infoRow('Status', order.paymentStatus),
        ],
      ),
    );
  }

  Widget _buildOrderItemsTab(Order order) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...order.items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Icon(Icons.image_outlined, size: 20, color: AppColors.textHint.withOpacity(0.5))),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                      Text('₦${item.price.toStringAsFixed(2)} x ${item.quantity}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Text('₦${item.total.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          )),
          const Divider(),
          _infoRow('Subtotal', '₦${order.subtotal.toStringAsFixed(2)}'),
          _infoRow('Shipping', '₦${order.shipping.toStringAsFixed(2)}'),
          _infoRow('Total', '₦${order.total.toStringAsFixed(2)}', isBold: true),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
          Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined, size: 48, color: AppColors.textHint.withOpacity(0.4)),
          const SizedBox(height: 8),
          Text('No orders found', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color bg; Color fg; String label;
    switch (status) {
      case 'delivered': bg = AppColors.success.withOpacity(0.1); fg = AppColors.success; label = 'Delivered'; break;
      case 'packing': bg = AppColors.info.withOpacity(0.1); fg = AppColors.info; label = 'Packing'; break;
      case 'confirmed': bg = AppColors.warning.withOpacity(0.1); fg = AppColors.warning; label = 'Confirmed'; break;
      case 'out_for_delivery': bg = AppColors.purple.withOpacity(0.1); fg = AppColors.purple; label = 'Out for Delivery'; break;
      case 'cancelled': bg = AppColors.error.withOpacity(0.1); fg = AppColors.error; label = 'Cancelled'; break;
      default: bg = AppColors.textHint.withOpacity(0.1); fg = AppColors.textHint; label = status; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget _paymentBadge(String status) {
    Color bg; Color fg; String label;
    switch (status) {
      case 'paid': bg = AppColors.success.withOpacity(0.1); fg = AppColors.success; label = 'Paid'; break;
      case 'pending': bg = AppColors.warning.withOpacity(0.1); fg = AppColors.warning; label = 'Pending'; break;
      case 'refunded': bg = AppColors.info.withOpacity(0.1); fg = AppColors.info; label = 'Refunded'; break;
      default: bg = AppColors.textHint.withOpacity(0.1); fg = AppColors.textHint; label = status; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}
