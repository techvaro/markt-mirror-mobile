import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class MarketingScreen extends StatefulWidget {
  const MarketingScreen({super.key});

  @override
  State<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  final List<DiscountCode> _discountCodes = [
    DiscountCode(id: 'dc1', code: 'WELCOME10', discountType: 'Percentage', value: 10, usageCount: 45, usageLimit: 100, validity: DateTime.now().add(const Duration(days: 30)), status: 'active'),
    DiscountCode(id: 'dc2', code: 'FLAT500', discountType: 'Fixed', value: 500, usageCount: 12, usageLimit: 50, validity: DateTime.now().add(const Duration(days: 15)), status: 'active'),
    DiscountCode(id: 'dc3', code: 'HOLIDAY20', discountType: 'Percentage', value: 20, usageCount: 0, usageLimit: 200, validity: DateTime.now().add(const Duration(days: 45)), status: 'scheduled'),
    DiscountCode(id: 'dc4', code: 'FREESHIP', discountType: 'Percentage', value: 100, usageCount: 78, usageLimit: 50, validity: DateTime.now().subtract(const Duration(days: 5)), status: 'expired'),
  ];

  final List<FlashSale> _flashSales = [
    FlashSale(id: 'fs1', name: 'Weekend Flash', discountPercentage: 30, endTime: DateTime.now().add(const Duration(hours: 18)), productsCount: 12, status: 'active'),
    FlashSale(id: 'fs2', name: 'Midnight Madness', discountPercentage: 50, endTime: DateTime.now().add(const Duration(hours: 6)), productsCount: 8, status: 'active'),
    FlashSale(id: 'fs3', name: 'Clearance Sale', discountPercentage: 40, endTime: DateTime.now().subtract(const Duration(hours: 2)), productsCount: 25, status: 'ended'),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Marketing', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        actions: [
          TextButton.icon(
            onPressed: () => _showCreatePromoDialog(),
            icon: const Icon(Icons.add, size: 18),
            label: Text('Create', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _statCard('Impressions', '24.5K', Icons.visibility, AppColors.kpiBlue),
                const SizedBox(width: 10),
                _statCard('Clicks', '1,240', Icons.touch_app, AppColors.kpiGreen),
                const SizedBox(width: 10),
                _statCard('Conversions', '186', Icons.shopping_cart_checkout, AppColors.kpiPurple),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabCtrl,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textHint,
                    indicatorColor: AppColors.primary,
                    labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                    tabs: const [
                      Tab(text: 'Discount Codes'),
                      Tab(text: 'Flash Sales'),
                    ],
                  ),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      controller: _tabCtrl,
                      children: [
                        _buildDiscountCodesTab(),
                        _buildFlashSalesTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 6),
            Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800)),
            Text(label, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountCodesTab() {
    if (_discountCodes.isEmpty) return _emptyTab('No discount codes yet');
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _discountCodes.length,
      itemBuilder: (_, i) => _buildDiscountCodeCard(_discountCodes[i]),
    );
  }

  Widget _buildDiscountCodeCard(DiscountCode code) {
    String statusLabel;
    Color statusColor;
    switch (code.status) {
      case 'active': statusLabel = 'Active'; statusColor = AppColors.green; break;
      case 'scheduled': statusLabel = 'Scheduled'; statusColor = AppColors.info; break;
      case 'expired': statusLabel = 'Expired'; statusColor = AppColors.red; break;
      default: statusLabel = code.status; statusColor = AppColors.textHint; break;
    }
    final typeLabel = code.discountType == 'Percentage' ? '${code.value}% Off' : '₦${code.value.toInt()} Off';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(code.code, style: const TextStyle(fontFamily: 'monospace', fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 8),
                    Text(typeLabel, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 4),
                Text('${code.usageCount}/${code.usageLimit} used', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
                Text('Valid until ${code.validity.day}/${code.validity.month}/${code.validity.year}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Text(statusLabel, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: statusColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSalesTab() {
    if (_flashSales.isEmpty) return _emptyTab('No flash sales running');
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _flashSales.length,
      itemBuilder: (_, i) => _buildFlashSaleCard(_flashSales[i]),
    );
  }

  Widget _buildFlashSaleCard(FlashSale sale) {
    final remaining = sale.endTime.difference(DateTime.now());
    final isEnded = remaining.isNegative;
    final hours = remaining.isNegative ? 0 : remaining.inHours;
    final mins = remaining.isNegative ? 0 : remaining.inMinutes.remainder(60);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: isEnded ? null : const LinearGradient(
          colors: [AppColors.primary, AppColors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: isEnded ? Colors.grey.shade100 : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sale.name, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: isEnded ? AppColors.textHint : Colors.white)),
              Row(
                children: [
                  if (!isEnded) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                      child: Text('${sale.discountPercentage.toInt()}% OFF', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                    const SizedBox(width: 8),
                  ],
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, size: 16, color: isEnded ? AppColors.textHint : Colors.white),
                    onSelected: (v) {
                      if (v == 'end') {
                        // end early
                      }
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'edit', child: ListTile(leading: Icon(Icons.edit, size: 18), title: Text('Edit', style: TextStyle(fontSize: 13)), dense: true)),
                      const PopupMenuItem(value: 'end', child: ListTile(leading: Icon(Icons.stop, size: 18, color: AppColors.red), title: Text('End Early', style: TextStyle(fontSize: 13, color: AppColors.red)), dense: true)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('${sale.productsCount} products', style: GoogleFonts.inter(fontSize: 12, color: isEnded ? AppColors.textHint : Colors.white70)),
              const SizedBox(width: 16),
              if (!isEnded)
                Text('${hours}h ${mins}m remaining', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
              if (isEnded)
                Text('Ended', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textHint)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emptyTab(String msg) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_offer_outlined, size: 40, color: AppColors.textHint.withOpacity(0.4)),
          const SizedBox(height: 8),
          Text(msg, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  void _showCreatePromoDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Create Promotion', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.discount, color: AppColors.primary),
              title: const Text('Discount Code'),
              subtitle: const Text('Create a promo code'),
              onTap: () { Navigator.pop(ctx); },
            ),
            ListTile(
              leading: const Icon(Icons.flash_on, color: AppColors.warning),
              title: const Text('Flash Sale'),
              subtitle: const Text('Time-limited discounts'),
              onTap: () { Navigator.pop(ctx); },
            ),
          ],
        ),
      ),
    );
  }
}
