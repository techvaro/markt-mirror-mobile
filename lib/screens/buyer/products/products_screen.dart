import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/data/mock_data.dart';
import 'package:market_mirror_mobile/providers/market_provider.dart';
import 'package:market_mirror_mobile/widgets/chat_icon_button.dart';
import 'package:market_mirror_mobile/widgets/city_market_selector.dart';
import 'package:market_mirror_mobile/widgets/product_card.dart';
import 'package:provider/provider.dart';

final List<String> _allCategories = ['All', 'Electronics', 'Phones', 'Fabrics', 'Appliances', 'Auto', 'Beauty', 'Groceries'];

final List<ProductWithShop> _products = [
  ProductWithShop(id: 'prod_1', shopId: 'shop_1', name: 'Samsung 55" 4K Smart TV', category: 'Electronics', price: 450000, inStock: true, rating: 4.7, reviewCount: 34, shopName: 'TechCity'),
  ProductWithShop(id: 'prod_2', shopId: 'shop_1', name: 'Sony PlayStation 5', category: 'Electronics', price: 380000, inStock: true, rating: 4.9, reviewCount: 52, shopName: 'TechCity'),
  ProductWithShop(id: 'prod_3', shopId: 'shop_1', name: 'JBL PartyBox 310', category: 'Electronics', price: 210000, inStock: true, rating: 4.6, reviewCount: 28, shopName: 'TechCity'),
  ProductWithShop(id: 'prod_4', shopId: 'shop_1', name: 'LG 1.5HP Split AC', category: 'Electronics', price: 185000, inStock: true, rating: 4.5, reviewCount: 19, shopName: 'TechCity'),
  ProductWithShop(id: 'prod_5', shopId: 'shop_2', name: 'iPhone 15 Pro Max', category: 'Phones', price: 1250000, inStock: true, rating: 4.8, reviewCount: 41, shopName: 'PhoneHub'),
  ProductWithShop(id: 'prod_6', shopId: 'shop_2', name: 'Samsung Galaxy S24 Ultra', category: 'Phones', price: 1150000, inStock: true, rating: 4.7, reviewCount: 36, shopName: 'PhoneHub'),
  ProductWithShop(id: 'prod_7', shopId: 'shop_2', name: 'Samsung Freepods Pro', category: 'Phones', price: 25000, inStock: true, rating: 4.3, reviewCount: 18, shopName: 'PhoneHub'),
  ProductWithShop(id: 'prod_8', shopId: 'shop_2', name: 'Anker Power Bank 20000mAh', category: 'Phones', price: 18500, inStock: true, rating: 4.4, reviewCount: 22, shopName: 'PhoneHub'),
  ProductWithShop(id: 'prod_9', shopId: 'shop_3', name: 'Premium Swiss Lace', category: 'Fabrics', price: 35000, inStock: true, rating: 4.8, reviewCount: 31, shopName: 'GlobalFabrics'),
  ProductWithShop(id: 'prod_10', shopId: 'shop_3', name: 'Vlisco Ankara', category: 'Fabrics', price: 28000, inStock: true, rating: 4.6, reviewCount: 25, shopName: 'GlobalFabrics'),
  ProductWithShop(id: 'prod_11', shopId: 'shop_3', name: 'Senator Fabric', category: 'Fabrics', price: 15000, inStock: true, rating: 4.4, reviewCount: 16, shopName: 'GlobalFabrics'),
  ProductWithShop(id: 'prod_12', shopId: 'shop_3', name: 'Aso-Oke (Handwoven)', category: 'Fabrics', price: 12000, inStock: true, rating: 4.7, reviewCount: 20, shopName: 'GlobalFabrics'),
  ProductWithShop(id: 'prod_13', shopId: 'shop_4', name: 'Thermocool Chest Freezer 300L', category: 'Appliances', price: 285000, inStock: true, rating: 4.6, reviewCount: 23, shopName: 'Kemis Home Appliances'),
  ProductWithShop(id: 'prod_14', shopId: 'shop_4', name: 'Maya Standing Fan 20"', category: 'Appliances', price: 45000, inStock: true, rating: 4.3, reviewCount: 15, shopName: 'Kemis Home Appliances'),
  ProductWithShop(id: 'prod_15', shopId: 'shop_4', name: 'Moulinex Food Processor', category: 'Appliances', price: 85000, inStock: true, rating: 4.5, reviewCount: 18, shopName: 'Kemis Home Appliances'),
  ProductWithShop(id: 'prod_16', shopId: 'shop_4', name: 'Scanfrost Gas Cooker 4-Burner', category: 'Appliances', price: 32000, inStock: true, rating: 4.4, reviewCount: 21, shopName: 'Kemis Home Appliances'),
  ProductWithShop(id: 'prod_17', shopId: 'shop_5', name: 'Gabriel Shock Absorbers', category: 'Auto', price: 42000, inStock: true, rating: 4.3, reviewCount: 14, shopName: 'AutoParts Pro'),
  ProductWithShop(id: 'prod_18', shopId: 'shop_5', name: 'Michelin Tyres 205/55R16', category: 'Auto', price: 65000, inStock: true, rating: 4.5, reviewCount: 17, shopName: 'AutoParts Pro'),
  ProductWithShop(id: 'prod_19', shopId: 'shop_5', name: 'NGK Spark Plugs (Set of 4)', category: 'Auto', price: 12000, inStock: true, rating: 4.2, reviewCount: 11, shopName: 'AutoParts Pro'),
  ProductWithShop(id: 'prod_20', shopId: 'shop_5', name: 'Bosch Ceramic Brake Pads', category: 'Auto', price: 18500, inStock: true, rating: 4.4, reviewCount: 13, shopName: 'AutoParts Pro'),
  ProductWithShop(id: 'prod_21', shopId: 'shop_6', name: 'Fenty Beauty Pro Filt\'r Foundation', category: 'Beauty', price: 38000, inStock: true, rating: 4.6, reviewCount: 27, shopName: 'BeautyGlow Studio'),
  ProductWithShop(id: 'prod_22', shopId: 'shop_6', name: 'MAC Fix+ Setting Mist', category: 'Beauty', price: 15000, inStock: true, rating: 4.4, reviewCount: 19, shopName: 'BeautyGlow Studio'),
  ProductWithShop(id: 'prod_23', shopId: 'shop_6', name: 'Charlotte Tilbury Lipstick', category: 'Beauty', price: 18500, inStock: true, rating: 4.7, reviewCount: 33, shopName: 'BeautyGlow Studio'),
  ProductWithShop(id: 'prod_24', shopId: 'shop_6', name: 'CeraVe Hydrating Facial Cleanser', category: 'Beauty', price: 12500, inStock: true, rating: 4.5, reviewCount: 24, shopName: 'BeautyGlow Studio'),
];

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedCategory = 'All';
  String _sortOption = 'Recommended';
  bool _inStockOnly = false;
  final TextEditingController _searchCtrl = TextEditingController();

  List<ProductWithShop> get _filteredProducts {
    var list = _products.where((p) {
      if (_selectedCategory != 'All' && p.category != _selectedCategory) return false;
      if (_inStockOnly && !p.inStock) return false;
      if (_searchCtrl.text.isNotEmpty && !p.name.toLowerCase().contains(_searchCtrl.text.toLowerCase())) return false;
      return true;
    }).toList();
    switch (_sortOption) {
      case 'Price Low-High':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price High-Low':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Top Rated':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
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
    final shopsInMarket = _marketShopIds(activeMarket);
    final filtered = _filteredProducts.where((product) => activeMarket.isEmpty || shopsInMarket.contains(product.shopId)).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Products', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
        actions: const [ChatIconButton()],
      ),
      body: Column(
        children: [
          const CityMarketSelector(),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
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
                      hintText: 'Search products...',
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
                const SizedBox(height: 10),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _allCategories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) {
                      final cat = _allCategories[i];
                      final isSelected = cat == _selectedCategory;
                      return FilterChip(
                        label: Text(cat, style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textSecondary)),
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
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${filtered.length} products', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary)),
                Row(
                  children: [
                    Row(
                      children: [
                        Text('In Stock', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                        const SizedBox(width: 4),
                        SizedBox(
                          height: 24,
                          child: Switch(
                            value: _inStockOnly,
                            onChanged: (v) => setState(() => _inStockOnly = v),
                            activeColor: AppColors.primary,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _sortOption,
                          isDense: true,
                          style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textPrimary),
                          items: ['Recommended', 'Price Low-High', 'Price High-Low', 'Top Rated'].map((s) => DropdownMenuItem(value: s, child: Text(s, style: GoogleFonts.sourceSans3(fontSize: 12)))).toList(),
                          onChanged: (v) => setState(() => _sortOption = v!),
                        ),
                      ),
                    ),
                  ],
                ),
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
                      Icon(Icons.search_off, size: 60, color: AppColors.textHint.withOpacity(0.5)),
                      const SizedBox(height: 12),
                      Text('No products found', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  itemBuilder: (_, i) => ProductCard(product: filtered[i]),
                ),
          ),
        ],
      ),
    );
  }

  Set<String> _marketShopIds(String market) {
    if (market.isEmpty) return const {};
    return MockData.shops
        .where((shop) => shop.market == market)
        .map((shop) => shop.id)
        .toSet();
  }
}
