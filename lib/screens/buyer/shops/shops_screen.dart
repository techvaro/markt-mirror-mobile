import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/market_provider.dart';
import 'package:provider/provider.dart';
import '../shop_detail/shop_detail_screen.dart';

final List<String> _allCategories = ['All', 'Electronics', 'Phones', 'Fabrics', 'Appliances', 'Auto', 'Beauty'];
final List<String> _markets = ['All Markets', 'Computer Village', 'Alaba International Market', 'Trade Fair Complex'];

final List<Shop> _allShops = [
  Shop(id: 'shop_1', name: 'TechCity', category: 'Electronics', rating: 4.8, reviewCount: 128, productCount: 4, verified: true, location: 'Shop A12, Computer Village, Ikeja', market: 'Computer Village', city: 'Lagos', phone: '+234 802 345 6789', hours: 'Mon-Sat: 8AM-7PM', shopNumber: 'A12', bannerGradient: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)'),
  Shop(id: 'shop_2', name: 'PhoneHub', category: 'Phones', rating: 4.6, reviewCount: 95, productCount: 4, verified: true, location: 'Shop B5, Computer Village, Ikeja', market: 'Computer Village', city: 'Lagos', phone: '+234 803 456 7890', hours: 'Mon-Sat: 8:30AM-7PM', shopNumber: 'B5', bannerGradient: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)'),
  Shop(id: 'shop_3', name: 'GlobalFabrics', category: 'Fabrics', rating: 4.5, reviewCount: 72, productCount: 4, verified: true, location: 'Shop C8, Trade Fair Complex, Badagry', market: 'Trade Fair Complex', city: 'Lagos', phone: '+234 805 678 9012', hours: 'Mon-Sat: 8AM-6PM', shopNumber: 'C8', bannerGradient: 'linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%)'),
  Shop(id: 'shop_4', name: 'Kemis Home Appliances', category: 'Appliances', rating: 4.7, reviewCount: 84, productCount: 4, verified: true, location: 'Shop D15, Alaba International Market, Ojo', market: 'Alaba International Market', city: 'Lagos', phone: '+234 806 789 0123', hours: 'Mon-Sat: 7AM-6:30PM', shopNumber: 'D15', bannerGradient: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)'),
  Shop(id: 'shop_5', name: 'AutoParts Pro', category: 'Auto', rating: 4.4, reviewCount: 56, productCount: 4, verified: true, location: 'Shop E7, Alaba International Market, Ojo', market: 'Alaba International Market', city: 'Lagos', phone: '+234 807 890 1234', hours: 'Mon-Sat: 7:30AM-6PM', shopNumber: 'E7', bannerGradient: 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)'),
  Shop(id: 'shop_6', name: 'BeautyGlow Studio', category: 'Beauty', rating: 4.2, reviewCount: 43, productCount: 4, verified: false, location: 'Shop F3, Trade Fair Complex, Badagry', market: 'Trade Fair Complex', city: 'Lagos', phone: '+234 808 901 2345', hours: 'Mon-Sat: 9AM-7PM', shopNumber: 'F3', bannerGradient: 'linear-gradient(135deg, #fccb90 0%, #d57eeb 100%)'),
];

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  String _selectedCategory = 'All';
  String _selectedMarket = 'All Markets';
  String _sortOption = 'Recommended';
  final TextEditingController _searchCtrl = TextEditingController();

  List<Shop> get _filteredShops {
    var list = _allShops.where((s) {
      if (_selectedCategory != 'All' && s.category != _selectedCategory) return false;
      if (_selectedMarket != 'All Markets' && s.market != _selectedMarket) return false;
      if (_searchCtrl.text.isNotEmpty && !s.name.toLowerCase().contains(_searchCtrl.text.toLowerCase())) return false;
      return true;
    }).toList();
    if (_sortOption == 'Top Rated') list.sort((a, b) => b.rating.compareTo(a.rating));
    if (_sortOption == 'Most Products') list.sort((a, b) => b.productCount.compareTo(a.productCount));
    return list;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeMarket = context.watch<MarketProvider>().selectedMarket;
    final filtered = _filteredShops.where((shop) => activeMarket.isEmpty || shop.market == activeMarket).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(activeMarket.isEmpty ? 'Shops' : activeMarket, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.sourceSans3(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search shops...',
                      hintStyle: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textHint),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: AppColors.textHint, size: 20),
                      suffixIcon: _searchCtrl.text.isNotEmpty ? IconButton(
                        icon: const Icon(Icons.clear, size: 18, color: AppColors.textHint),
                        onPressed: () { _searchCtrl.clear(); setState(() {}); },
                      ) : null,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 34,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _allCategories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 6),
                    itemBuilder: (_, i) {
                      final cat = _allCategories[i];
                      final isSelected = cat == _selectedCategory;
                      return FilterChip(
                        label: Text(cat, style: GoogleFonts.sourceSans3(fontSize: 11, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textSecondary)),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _selectedCategory = cat),
                        selectedColor: AppColors.primary,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedMarket,
                      isDense: true,
                      style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textPrimary),
                      items: _markets.map((m) => DropdownMenuItem(value: m, child: Text(m, style: GoogleFonts.sourceSans3(fontSize: 12)))).toList(),
                      onChanged: (v) => setState(() => _selectedMarket = v!),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _sortOption,
                      isDense: true,
                      style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textPrimary),
                      items: ['Recommended', 'Top Rated', 'Most Products'].map((s) => DropdownMenuItem(value: s, child: Text(s, style: GoogleFonts.sourceSans3(fontSize: 12)))).toList(),
                      onChanged: (v) => setState(() => _sortOption = v!),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${filtered.length} shops', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Expanded(
            child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.store_mall_directory, size: 60, color: AppColors.textHint.withOpacity(0.5)),
                      const SizedBox(height: 12),
                      Text('No shops found', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.0, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  itemBuilder: (_, i) => _ShopCard(shop: filtered[i]),
                ),
          ),
        ],
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  final Shop shop;
  const _ShopCard({required this.shop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShopDetailScreen(shop: shop))),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: Shop.parseGradient(shop.bannerGradient)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: Text(shop.name.substring(0, 1), style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white))),
            ),
            const SizedBox(height: 8),
            Text(shop.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(shop.category, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, size: 14, color: AppColors.starActive),
                const SizedBox(width: 2),
                Text(shop.rating.toString(), style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(width: 4),
                Text('(${shop.reviewCount})', style: GoogleFonts.sourceSans3(fontSize: 10, color: AppColors.textHint)),
              ],
            ),
            const SizedBox(height: 4),
            Text('${shop.productCount} products', style: GoogleFonts.sourceSans3(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
