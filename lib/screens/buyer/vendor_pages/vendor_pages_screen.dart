import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

final List<String> _categories = ['Electronics', 'Phones', 'Fabrics', 'Appliances', 'Auto', 'Beauty', 'Groceries'];
final List<String> _markets = ['Computer Village, Ikeja', 'Alaba International Market, Ojo', 'Trade Fair Complex, Badagry', 'Balogun Market, Lagos', 'Mile 12 Market, Lagos', 'Kurmi Market, Kano', 'Ogbete Main Market, Enugu', 'Bodija Market, Ibadan'];

class VendorPagesScreen extends StatefulWidget {
  const VendorPagesScreen({super.key});

  @override
  State<VendorPagesScreen> createState() => _VendorPagesScreenState();
}

class _VendorPagesScreenState extends State<VendorPagesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  final _shopNameCtrl = TextEditingController();
  final _ownerCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String _selectedCategory = _categories.first;
  String _selectedMarket = _markets.first;
  final _descCtrl = TextEditingController();

  bool _hasShop = false;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _shopNameCtrl.dispose();
    _ownerCtrl.dispose();
    _phoneCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Vendor', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
        bottom: TabBar(
          controller: _tabCtrl,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Open Shop'),
            Tab(text: 'Dashboard'),
            Tab(text: 'Seller Policies'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _OpenShopTab(
            shopNameCtrl: _shopNameCtrl,
            ownerCtrl: _ownerCtrl,
            phoneCtrl: _phoneCtrl,
            selectedCategory: _selectedCategory,
            selectedMarket: _selectedMarket,
            descCtrl: _descCtrl,
            categories: _categories,
            markets: _markets,
            onCategoryChanged: (v) => setState(() => _selectedCategory = v!),
            onMarketChanged: (v) => setState(() => _selectedMarket = v!),
            onSubmit: () {
              setState(() => _hasShop = true);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Shop application submitted!', style: GoogleFonts.sourceSans3(fontSize: 13)), backgroundColor: AppColors.success));
            },
          ),
          _DashboardTab(hasShop: _hasShop),
          _PoliciesTab(),
        ],
      ),
    );
  }
}

class _OpenShopTab extends StatelessWidget {
  final TextEditingController shopNameCtrl;
  final TextEditingController ownerCtrl;
  final TextEditingController phoneCtrl;
  final String selectedCategory;
  final String selectedMarket;
  final TextEditingController descCtrl;
  final List<String> categories;
  final List<String> markets;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onMarketChanged;
  final VoidCallback onSubmit;

  const _OpenShopTab({
    required this.shopNameCtrl,
    required this.ownerCtrl,
    required this.phoneCtrl,
    required this.selectedCategory,
    required this.selectedMarket,
    required this.descCtrl,
    required this.categories,
    required this.markets,
    required this.onCategoryChanged,
    required this.onMarketChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.storefront, color: AppColors.primary, size: 26)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Open a Shop', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    Text('Start selling on Market Mirror', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _field('Shop Name', shopNameCtrl),
            const SizedBox(height: 12),
            _field('Owner Name', ownerCtrl),
            const SizedBox(height: 12),
            _field('Phone Number', phoneCtrl),
            const SizedBox(height: 12),
            _dropdown('Category', selectedCategory, categories, onCategoryChanged),
            const SizedBox(height: 12),
            _dropdown('Market', selectedMarket, markets, onMarketChanged),
            const SizedBox(height: 12),
            _field('Shop Description', descCtrl, maxLines: 4),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                child: Text('Submit Application', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: GoogleFonts.sourceSans3(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: AppColors.background,
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      isDense: true,
      style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: AppColors.background,
      ),
      items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: GoogleFonts.sourceSans3(fontSize: 13)))).toList(),
      onChanged: onChanged,
    );
  }
}

class _DashboardTab extends StatelessWidget {
  final bool hasShop;
  const _DashboardTab({required this.hasShop});

  @override
  Widget build(BuildContext context) {
    if (!hasShop) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 80, height: 80, decoration: BoxDecoration(color: AppColors.textHint.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.store_mall_directory, size: 40, color: AppColors.textHint)),
            const SizedBox(height: 16),
            Text('No Shop Yet', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text('Open a shop to see your dashboard', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
              child: Text('Open a Shop', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _kpiCard('Today\'s Sales', '₦125,000', AppColors.kpiBlue, Icons.trending_up)),
              const SizedBox(width: 10),
              Expanded(child: _kpiCard('Orders', '12', AppColors.kpiGreen, Icons.receipt_long)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _kpiCard('Products', '24', AppColors.kpiOrange, Icons.inventory_2)),
              const SizedBox(width: 10),
              Expanded(child: _kpiCard('Revenue (30d)', '₦2.4M', AppColors.kpiPurple, Icons.account_balance_wallet)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _kpiCard('Pending Orders', '3', AppColors.kpiPink, Icons.pending_actions)),
              const SizedBox(width: 10),
              Expanded(child: _kpiCard('Rating', '4.8', AppColors.kpiTeal, Icons.star)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kpiCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 32, decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 18)),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          Text(label, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _PoliciesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final policies = [
      {'title': 'Verification', 'desc': 'All sellers must complete verification, including government ID, proof of business registration, and valid contact information before listing products.', 'icon': Icons.verified_user},
      {'title': 'Fees & Payouts', 'desc': 'Market Mirror charges a 5% commission on each sale. Payouts are processed weekly for completed orders. No hidden fees or monthly charges.', 'icon': Icons.payments},
      {'title': 'Listing Standards', 'desc': 'Products must be accurately described with clear images, correct pricing, and proper categorization. Misleading listings will be removed.', 'icon': Icons.assignment},
      {'title': 'Fulfilment', 'desc': 'Orders must be processed within 24 hours and shipped within 48 hours. Tracking information should be provided for all shipments.', 'icon': Icons.local_shipping},
      {'title': 'Prohibited Items', 'desc': 'Selling counterfeit goods, restricted items, or products that violate Nigerian law is strictly forbidden and will result in permanent account suspension.', 'icon': Icons.block},
      {'title': 'Disputes', 'desc': 'Disputes are handled by our mediation team. Sellers are expected to respond within 48 hours. Escrow protects both parties during resolution.', 'icon': Icons.gavel},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: policies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final p = policies[i];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                child: Icon(p['icon'] as IconData, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['title'] as String, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(p['desc'] as String, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
