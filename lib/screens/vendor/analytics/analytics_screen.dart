import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedPeriod = '7d';
  final List<String> _periods = ['7d', '30d', '90d', '1y'];

  final _analytics = AnalyticsData(
    period: '7d',
    revenueChange: 12.5,
    ordersChange: 8.2,
    visitorsChange: -2.1,
    conversionChange: 1.1,
    revenue7Days: [12500, 18200, 9800, 25400, 31200, 15800, 22400],
    orders7Days: [3, 5, 2, 7, 8, 4, 6],
    bestSellingProducts: [
      MapEntry('Handwoven Basket', 48),
      MapEntry('Ankara Dress', 35),
      MapEntry('Beaded Necklace', 29),
      MapEntry('Leather Sandals', 22),
      MapEntry('Canvas Painting', 18),
    ],
    returningCustomerPercent: 42,
    newCustomerPercent: 58,
    topCategories: [
      MapEntry('Home Decor', 45),
      MapEntry('Kitchen', 35),
      MapEntry('Art', 20),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Analytics', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),
            const SizedBox(height: 16),
            _buildMoMCards(),
            const SizedBox(height: 20),
            _buildChartCard('Revenue Trend', _buildRevenueChart()),
            const SizedBox(height: 16),
            _buildChartCard('Daily Orders', _buildDailyOrdersChart()),
            const SizedBox(height: 20),
            _buildBestSellers(),
            const SizedBox(height: 20),
            _buildCustomerInsights(),
            const SizedBox(height: 20),
            _buildTopCategories(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      children: _periods.map((p) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: GestureDetector(
          onTap: () => setState(() => _selectedPeriod = p),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _selectedPeriod == p ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _selectedPeriod == p ? AppColors.primary : AppColors.border),
            ),
            child: Text(p, style: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w600,
              color: _selectedPeriod == p ? Colors.white : AppColors.textSecondary,
            )),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildMoMCards() {
    return Row(
      children: [
        Expanded(child: _momCard('Revenue', '+${_analytics.revenueChange}%', Icons.trending_up, true)),
        const SizedBox(width: 8),
        Expanded(child: _momCard('Orders', '+${_analytics.ordersChange}%', Icons.shopping_cart, true)),
        const SizedBox(width: 8),
        Expanded(child: _momCard('Visitors', '${_analytics.visitorsChange}%', Icons.people, _analytics.visitorsChange > 0)),
        const SizedBox(width: 8),
        Expanded(child: _momCard('Conversion', '+${_analytics.conversionChange}%', Icons.trending_up, true)),
      ],
    );
  }

  Widget _momCard(String label, String change, IconData icon, bool isPositive) {
    final color = isPositive ? AppColors.green : AppColors.red;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(height: 4),
          Text(change, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
          Text(label, style: GoogleFonts.inter(fontSize: 9, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          SizedBox(height: 150, child: chart),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    final maxRev = _analytics.revenue7Days.reduce((a, b) => a > b ? a : b);
    return CustomPaint(
      size: const Size(double.infinity, 150),
      painter: _AreaChartPainter(_analytics.revenue7Days, maxRev, AppColors.kpiGreen),
    );
  }

  Widget _buildDailyOrdersChart() {
    final maxOrd = _analytics.orders7Days.reduce((a, b) => a > b ? a : b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(_analytics.orders7Days.length, (i) {
            final height = maxOrd > 0 ? (_analytics.orders7Days[i] / maxOrd) * 130 : 0.0;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${_analytics.orders7Days[i]}', style: GoogleFonts.inter(fontSize: 9, color: AppColors.textHint)),
                    const SizedBox(height: 4),
                    Container(
                      height: height.clamp(4.0, 130.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.kpiBlue, AppColors.kpiBlue],
                        ),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(['M', 'T', 'W', 'T', 'F', 'S', 'S'][i], style: GoogleFonts.inter(fontSize: 9, color: AppColors.textHint)),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBestSellers() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Best Selling Products', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ..._analytics.bestSellingProducts.asMap().entries.map((entry) {
            final i = entry.key + 1;
            final p = entry.value;
            final maxUnits = _analytics.bestSellingProducts.first.value;
            final percent = maxUnits > 0 ? (p.value / maxUnits) * 100 : 0.0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$i. ${p.key}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500)),
                      Text('${p.value} units', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percent / 100,
                      backgroundColor: AppColors.border,
                      valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCustomerInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Insights', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 80, width: 80,
                            child: CircularProgressIndicator(
                              value: _analytics.returningCustomerPercent / 100,
                              strokeWidth: 8,
                              backgroundColor: AppColors.orange.withOpacity(0.2),
                              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                            ),
                          ),
                          Text('${_analytics.returningCustomerPercent.toInt()}%', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Returning', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 80, width: 80,
                            child: CircularProgressIndicator(
                              value: _analytics.newCustomerPercent / 100,
                              strokeWidth: 8,
                              backgroundColor: AppColors.primary.withOpacity(0.2),
                              valueColor: const AlwaysStoppedAnimation(AppColors.orange),
                            ),
                          ),
                          Text('${_analytics.newCustomerPercent.toInt()}%', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('New', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopCategories() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Categories', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ..._analytics.topCategories.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(c.key, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500)),
                    Text('${c.value.toInt()}%', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: c.value / 100,
                    backgroundColor: AppColors.border,
                    valueColor: const AlwaysStoppedAnimation(AppColors.teal),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class AnalyticsData {
  final String period;
  final double revenueChange;
  final double ordersChange;
  final double visitorsChange;
  final double conversionChange;
  final List<double> revenue7Days;
  final List<int> orders7Days;
  final List<MapEntry<String, int>> bestSellingProducts;
  final double returningCustomerPercent;
  final double newCustomerPercent;
  final List<MapEntry<String, int>> topCategories;

  AnalyticsData({
    this.period = '7d',
    this.revenueChange = 0.0,
    this.ordersChange = 0.0,
    this.visitorsChange = 0.0,
    this.conversionChange = 0.0,
    this.revenue7Days = const [0, 0, 0, 0, 0, 0, 0],
    this.orders7Days = const [0, 0, 0, 0, 0, 0, 0],
    this.bestSellingProducts = const [],
    this.returningCustomerPercent = 0,
    this.newCustomerPercent = 0,
    this.topCategories = const [],
  });
}

class _AreaChartPainter extends CustomPainter {
  final List<double> values;
  final double maxValue;
  final Color color;

  _AreaChartPainter(this.values, this.maxValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty || maxValue == 0) return;

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.3), color.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final stepX = size.width / (values.length - 1);
    path.moveTo(0, size.height);
    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final y = size.height - (values[i] / maxValue) * size.height * 0.9;
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
      final y = size.height - (values[i] / maxValue) * size.height * 0.9;
      if (i == 0) linePath.moveTo(x, y);
      else linePath.lineTo(x, y);
    }
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _AreaChartPainter old) => old.values != values;
}
