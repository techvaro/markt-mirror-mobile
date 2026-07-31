import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/vendor_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Order> _recentOrders = [
    Order(id: 'o1', orderNumber: 'ORD-001', date: DateTime.now().subtract(const Duration(hours: 2)), customerName: 'Amara Eze', total: 12500.0, paymentStatus: 'paid', orderStatus: 'delivered', items: [OrderItem(productId: 'p1', name: 'Handwoven Basket', quantity: 2, price: 6250.0)], subtotal: 12500.0, shipping: 0.0),
    Order(id: 'o2', orderNumber: 'ORD-002', date: DateTime.now().subtract(const Duration(hours: 5)), customerName: 'Tunde Balogun', total: 8500.0, paymentStatus: 'paid', orderStatus: 'packing', items: [OrderItem(productId: 'p2', name: 'Beaded Necklace', quantity: 1, price: 8500.0)], subtotal: 8500.0, shipping: 0.0),
    Order(id: 'o3', orderNumber: 'ORD-003', date: DateTime.now().subtract(const Duration(hours: 8)), customerName: 'Ngozi Okafor', total: 32000.0, paymentStatus: 'pending', orderStatus: 'confirmed', items: [OrderItem(productId: 'p3', name: 'Canvas Painting', quantity: 1, price: 32000.0)], subtotal: 32000.0, shipping: 0.0),
    Order(id: 'o4', orderNumber: 'ORD-004', date: DateTime.now().subtract(const Duration(days: 1)), customerName: 'Kelechi Nwosu', total: 5600.0, paymentStatus: 'paid', orderStatus: 'delivered', items: [OrderItem(productId: 'p4', name: 'Leather Pouch', quantity: 2, price: 2800.0)], subtotal: 5600.0, shipping: 0.0),
    Order(id: 'o5', orderNumber: 'ORD-005', date: DateTime.now().subtract(const Duration(days: 1)), customerName: 'Chioma Obi', total: 18000.0, paymentStatus: 'paid', orderStatus: 'out_for_delivery', items: [OrderItem(productId: 'p5', name: 'Ankara Dress', quantity: 1, price: 18000.0)], subtotal: 18000.0, shipping: 0.0),
  ];

  final List<Product> _lowStockProducts = [
    Product(id: 'p1', name: 'Handwoven Basket', stockQuantity: 2, price: 6250.0, sku: 'HWB-001', status: 'published'),
    Product(id: 'p2', name: 'Beaded Earrings', stockQuantity: 0, price: 3500.0, sku: 'BE-002', status: 'published'),
    Product(id: 'p3', name: 'Leather Sandals', stockQuantity: 4, price: 12000.0, sku: 'LS-003', status: 'published'),
  ];

  final List<Review> _recentReviews = [
    Review(id: 'r1', customerName: 'Amara Eze', date: DateTime.now().subtract(const Duration(days: 1)), rating: 5.0, comment: 'Absolutely beautiful craftsmanship! The basket exceeded my expectations.', productId: 'p1', productName: 'Handwoven Basket'),
    Review(id: 'r2', customerName: 'Tunde Balogun', date: DateTime.now().subtract(const Duration(days: 3)), rating: 4.0, comment: 'Nice necklace, chain could be a bit longer.', productId: 'p2', productName: 'Beaded Necklace'),
    Review(id: 'r3', customerName: 'Ngozi Okafor', date: DateTime.now().subtract(const Duration(days: 5)), rating: 5.0, comment: 'The painting is stunning!', productId: 'p3', productName: 'Canvas Painting'),
  ];

  final _stats = DashboardStats(
    todaysSales: 58450.0,
    todaysOrders: 12,
    pendingOrders: 4,
    completedOrders: 38,
    totalProducts: 156,
    revenueThisMonth: 1245000.0,
    visitors: 1234,
    conversionRate: 5.95,
    revenue7Days: [12500, 18200, 9800, 25400, 31200, 15800, 22400],
    orders7Days: [3, 5, 2, 7, 8, 4, 6],
  );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VendorProvider>();
    final user = provider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hello, ${user?.name ?? 'Vendor'}!',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildKpiRow1(),
            const SizedBox(height: 12),
            _buildKpiRow2(),
            const SizedBox(height: 20),
            _buildChartsRow(),
            const SizedBox(height: 20),
            _buildRecentOrders(),
            const SizedBox(height: 20),
            _buildLowStockAlerts(),
            const SizedBox(height: 20),
            _buildRecentReviews(),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiRow1() {
    return Row(
      children: [
        Expanded(child: _buildKpiCard('Today\'s Sales', '₦${_formatAmount(_stats.todaysSales)}', Icons.trending_up, AppColors.kpiGreen)),
        const SizedBox(width: 10),
        Expanded(child: _buildKpiCard('Today\'s Orders', '${_stats.todaysOrders}', Icons.shopping_cart, AppColors.kpiBlue)),
      ],
    );
  }

  Widget _buildKpiRow2() {
    return Row(
      children: [
        Expanded(child: _buildKpiCard('Pending Orders', '${_stats.pendingOrders}', Icons.hourglass_empty, AppColors.kpiOrange)),
        const SizedBox(width: 10),
        Expanded(child: _buildKpiCard('Completed', '${_stats.completedOrders}', Icons.check_circle, AppColors.kpiPurple)),
      ],
    );
  }

  Widget _buildChartsRow() {
    return Row(
      children: [
        Expanded(child: _buildChartCard('Revenue (7 days)', _miniAreaChart())),
        const SizedBox(width: 10),
        Expanded(child: _buildChartCard('Orders (7 days)', _miniBarChart())),
      ],
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          SizedBox(height: 80, child: chart),
        ],
      ),
    );
  }

  Widget _miniAreaChart() {
    final maxRev = _stats.revenue7Days.reduce((a, b) => a > b ? a : b);
    return CustomPaint(
      size: const Size(double.infinity, 80),
      painter: _MiniAreaChartPainter(_stats.revenue7Days, maxRev, AppColors.kpiGreen),
    );
  }

  Widget _miniBarChart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(_stats.orders7Days.length, (i) {
        final maxOrders = _stats.orders7Days.reduce((a, b) => a > b ? a : b);
        final height = maxOrders > 0 ? (_stats.orders7Days[i] / maxOrders) * 70 : 0.0;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              height: height.clamp(4.0, 70.0),
              decoration: BoxDecoration(
                color: AppColors.kpiBlue,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildKpiCard(String label, String value, IconData icon, Color color) {
    return Container(
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
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildRecentOrders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Orders', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: List.generate(
              _recentOrders.length,
              (i) => _buildOrderRow(_recentOrders[i], i < _recentOrders.length - 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderRow(Order order, bool showDivider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.orderNumber, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 2),
                    Text(order.customerName, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('₦${_formatAmount(order.total)}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              ),
              _statusBadge(order.orderStatus),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  Widget _buildLowStockAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Low Stock Products', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: List.generate(
              _lowStockProducts.length,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: _lowStockProducts[i].isOutOfStock ? AppColors.red.withOpacity(0.1) : AppColors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.inventory, size: 18, color: _lowStockProducts[i].isOutOfStock ? AppColors.red : AppColors.orange),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_lowStockProducts[i].name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                          Text('SKU: ${_lowStockProducts[i].sku}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    Text('${_lowStockProducts[i].stockQuantity} left', style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _lowStockProducts[i].isOutOfStock ? AppColors.red : AppColors.orange,
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Reviews', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: List.generate(
              _recentReviews.length,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_recentReviews[i].customerName, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                        _buildStars(_recentReviews[i].rating),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(_recentReviews[i].comment, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text(_recentReviews[i].productName, style: GoogleFonts.inter(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) => Icon(
        i < rating ? Icons.star : Icons.star_border,
        size: 14,
        color: AppColors.starActive,
      )),
    );
  }

  Widget _statusBadge(String status) {
    Color bg;
    Color fg;
    String label;
    switch (status) {
      case 'delivered':
        bg = AppColors.success.withOpacity(0.1);
        fg = AppColors.success;
        label = 'Delivered';
        break;
      case 'packing':
        bg = AppColors.info.withOpacity(0.1);
        fg = AppColors.info;
        label = 'Packing';
        break;
      case 'confirmed':
        bg = AppColors.warning.withOpacity(0.1);
        fg = AppColors.warning;
        label = 'Confirmed';
        break;
      case 'out_for_delivery':
        bg = AppColors.purple.withOpacity(0.1);
        fg = AppColors.purple;
        label = 'Out for Delivery';
        break;
      case 'cancelled':
        bg = AppColors.error.withOpacity(0.1);
        fg = AppColors.error;
        label = 'Cancelled';
        break;
      default:
        bg = AppColors.textHint.withOpacity(0.1);
        fg = AppColors.textHint;
        label = status;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return amount.toStringAsFixed(0);
  }
}

class DashboardStats {
  final double todaysSales;
  final int todaysOrders;
  final int pendingOrders;
  final int completedOrders;
  final int totalProducts;
  final double revenueThisMonth;
  final int visitors;
  final double conversionRate;
  final List<double> revenue7Days;
  final List<int> orders7Days;

  DashboardStats({
    this.todaysSales = 0.0,
    this.todaysOrders = 0,
    this.pendingOrders = 0,
    this.completedOrders = 0,
    this.totalProducts = 0,
    this.revenueThisMonth = 0.0,
    this.visitors = 0,
    this.conversionRate = 0.0,
    this.revenue7Days = const [0, 0, 0, 0, 0, 0, 0],
    this.orders7Days = const [0, 0, 0, 0, 0, 0, 0],
  });
}

class _MiniAreaChartPainter extends CustomPainter {
  final List<double> values;
  final double maxValue;
  final Color color;

  _MiniAreaChartPainter(this.values, this.maxValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty || maxValue == 0) return;

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.4), color.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final stepX = size.width / (values.length - 1);

    path.moveTo(0, size.height);
    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final y = size.height - (values[i] / maxValue) * size.height * 0.85;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final linePath = Path();
    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final y = size.height - (values[i] / maxValue) * size.height * 0.85;
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
      }
    }
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _MiniAreaChartPainter old) => old.values != values;
}
