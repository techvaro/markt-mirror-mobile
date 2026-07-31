import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import '../product_detail/product_detail_screen.dart';
import '../shop_detail/shop_detail_screen.dart';

final List<ProductWithShop> _allProducts = [
  ProductWithShop(id: 'prod_1', shopId: 'shop_1', name: 'Samsung 55" 4K Smart TV', category: 'Electronics', price: 450000, inStock: true, rating: 4.7, reviewCount: 34, shopName: 'TechCity'),
  ProductWithShop(id: 'prod_5', shopId: 'shop_2', name: 'iPhone 15 Pro Max', category: 'Phones', price: 1250000, inStock: true, rating: 4.8, reviewCount: 41, shopName: 'PhoneHub'),
  ProductWithShop(id: 'prod_9', shopId: 'shop_3', name: 'Premium Swiss Lace', category: 'Fabrics', price: 35000, inStock: true, rating: 4.8, reviewCount: 31, shopName: 'GlobalFabrics'),
  ProductWithShop(id: 'prod_13', shopId: 'shop_4', name: 'Thermocool Chest Freezer 300L', category: 'Appliances', price: 285000, inStock: true, rating: 4.6, reviewCount: 23, shopName: 'Kemis Home Appliances'),
  ProductWithShop(id: 'prod_17', shopId: 'shop_5', name: 'Gabriel Shock Absorbers', category: 'Auto', price: 42000, inStock: true, rating: 4.3, reviewCount: 14, shopName: 'AutoParts Pro'),
  ProductWithShop(id: 'prod_21', shopId: 'shop_6', name: 'Fenty Beauty Foundation', category: 'Beauty', price: 38000, inStock: true, rating: 4.6, reviewCount: 27, shopName: 'BeautyGlow Studio'),
];

final List<Shop> _allShops = [
  Shop(id: 'shop_1', name: 'TechCity', category: 'Electronics', rating: 4.8, reviewCount: 128, productCount: 4, verified: true, location: 'Computer Village', market: 'Computer Village', city: 'Lagos'),
  Shop(id: 'shop_2', name: 'PhoneHub', category: 'Phones', rating: 4.6, reviewCount: 95, productCount: 4, verified: true, location: 'Computer Village', market: 'Computer Village', city: 'Lagos'),
  Shop(id: 'shop_3', name: 'GlobalFabrics', category: 'Fabrics', rating: 4.5, reviewCount: 72, productCount: 4, verified: true, location: 'Trade Fair Complex', market: 'Trade Fair Complex', city: 'Lagos'),
  Shop(id: 'shop_4', name: 'Kemis Home Appliances', category: 'Appliances', rating: 4.7, reviewCount: 84, productCount: 4, verified: true, location: 'Alaba International Market', market: 'Alaba International Market', city: 'Lagos'),
  Shop(id: 'shop_5', name: 'AutoParts Pro', category: 'Auto', rating: 4.4, reviewCount: 56, productCount: 4, verified: true, location: 'Alaba International Market', market: 'Alaba International Market', city: 'Lagos'),
  Shop(id: 'shop_6', name: 'BeautyGlow Studio', category: 'Beauty', rating: 4.2, reviewCount: 43, productCount: 4, verified: false, location: 'Trade Fair Complex', market: 'Trade Fair Complex', city: 'Lagos'),
];

final List<String> _markets = ['Computer Village, Ikeja', 'Alaba International Market, Ojo', 'Trade Fair Complex, Badagry'];

final List<String> _suggestions = ['iPhone', 'Samsung TV', 'Swiss Lace', 'PS5', 'Air Conditioner', 'Freezer', 'Foundation'];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchCtrl = TextEditingController();
  late TabController _tabCtrl;
  String _filterTab = 'All';

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 4, vsync: this);
    _tabCtrl.addListener(() {
      final tabs = ['All', 'Products', 'Shops', 'Markets'];
      setState(() => _filterTab = tabs[_tabCtrl.index]);
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _tabCtrl.dispose();
    super.dispose();
  }

  List<ProductWithShop> get _productResults {
    if (_searchCtrl.text.isEmpty) return [];
    return _allProducts.where((p) => p.name.toLowerCase().contains(_searchCtrl.text.toLowerCase())).toList();
  }

  List<Shop> get _shopResults {
    if (_searchCtrl.text.isEmpty) return [];
    return _allShops.where((s) => s.name.toLowerCase().contains(_searchCtrl.text.toLowerCase())).toList();
  }

  List<String> get _marketResults {
    if (_searchCtrl.text.isEmpty) return [];
    return _markets.where((m) => m.toLowerCase().contains(_searchCtrl.text.toLowerCase())).toList();
  }

  bool get _hasQuery => _searchCtrl.text.isNotEmpty;
  bool get _hasResults => _productResults.isNotEmpty || _shopResults.isNotEmpty || _marketResults.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: _searchCtrl,
            autofocus: true,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.sourceSans3(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search products, shops, markets...',
              hintStyle: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textHint),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        actions: [
          if (_hasQuery)
            IconButton(icon: const Icon(Icons.clear, color: AppColors.textPrimary), onPressed: () { _searchCtrl.clear(); setState(() {}); }),
        ],
      ),
      body: _hasQuery
        ? _hasResults
            ? Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabCtrl,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.textSecondary,
                      labelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                      unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
                      indicatorColor: AppColors.primary,
                      tabs: [
                        Tab(text: 'All (${_productResults.length + _shopResults.length + _marketResults.length})'),
                        Tab(text: 'Products (${_productResults.length})'),
                        Tab(text: 'Shops (${_shopResults.length})'),
                        Tab(text: 'Markets (${_marketResults.length})'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabCtrl,
                      children: [
                        _buildAllResults(),
                        _buildProductResults(),
                        _buildShopResults(),
                        _buildMarketResults(),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: AppColors.textHint.withOpacity(0.5)),
                    const SizedBox(height: 12),
                    Text('No results for "${_searchCtrl.text}"', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                    Text('Try a different search term', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textHint)),
                  ],
                ),
              )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 64, color: AppColors.textHint.withOpacity(0.4)),
                const SizedBox(height: 12),
                Text('What are you looking for?', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: _suggestions.map((s) => ActionChip(
                    label: Text(s, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.primary)),
                    onPressed: () { _searchCtrl.text = s; setState(() {}); },
                    backgroundColor: AppColors.primary.withOpacity(0.08),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  )).toList(),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildAllResults() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_productResults.isNotEmpty) ...[
          Text('Products', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          ..._productResults.take(3).map((p) => _productResultTile(p)),
          const SizedBox(height: 16),
        ],
        if (_shopResults.isNotEmpty) ...[
          Text('Shops', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          ..._shopResults.take(3).map((s) => _shopResultTile(s)),
          const SizedBox(height: 16),
        ],
        if (_marketResults.isNotEmpty) ...[
          Text('Markets', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          ..._marketResults.map((m) => _marketResultTile(m)),
        ],
      ],
    );
  }

  Widget _buildProductResults() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _productResults.map((p) => _productResultTile(p)).toList(),
    );
  }

  Widget _buildShopResults() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _shopResults.map((s) => _shopResultTile(s)).toList(),
    );
  }

  Widget _buildMarketResults() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _marketResults.map((m) => _marketResultTile(m)).toList(),
    );
  }

  Widget _productResultTile(ProductWithShop p) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.shopping_bag, color: AppColors.primary, size: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('${p.shopName} - ${p.category}', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Text('₦${p.price.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.accent)),
          ],
        ),
      ),
    );
  }

  Widget _shopResultTile(Shop s) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShopDetailScreen(shop: s))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(s.name[0], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)))),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text('${s.category} - ${s.city}', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: AppColors.starActive),
                const SizedBox(width: 2),
                Text(s.rating.toString(), style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _marketResultTile(String market) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.store, color: AppColors.primary, size: 22)),
          const SizedBox(width: 10),
          Expanded(child: Text(market, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
          const Icon(Icons.chevron_right, color: AppColors.textHint),
        ],
      ),
    );
  }
}
