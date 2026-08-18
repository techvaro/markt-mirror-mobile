import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/data/mock_data.dart';
import 'package:market_mirror_mobile/providers/market_provider.dart';
import 'package:market_mirror_mobile/widgets/app_logo.dart';
import 'package:market_mirror_mobile/widgets/chat_icon_button.dart';
import 'package:market_mirror_mobile/widgets/city_market_selector.dart';
import 'package:market_mirror_mobile/widgets/product_card.dart';
import 'package:provider/provider.dart';
import '../maps/maps_screen.dart';
import '../search/search_screen.dart';
import '../shop_detail/shop_detail_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';

final List<Map<String, String>> _categories = [
  {'name': 'Electronics', 'icon': '💻'},
  {'name': 'Phones', 'icon': '📱'},
  {'name': 'Fabrics', 'icon': '🧵'},
  {'name': 'Appliances', 'icon': '🔌'},
  {'name': 'Auto', 'icon': '🚗'},
  {'name': 'Beauty', 'icon': '💄'},
  {'name': 'Groceries', 'icon': '🛒'},
];

final List<Shop> _featuredShops = MockData.shops;

final List<ProductWithShop> _trendingProducts = [
  ProductWithShop(id: 'prod_1', shopId: 'shop_1', name: 'Samsung 55" 4K Smart TV', category: 'Electronics', price: 450000, inStock: true, rating: 4.7, reviewCount: 34, shopName: 'TechCity'),
  ProductWithShop(id: 'prod_5', shopId: 'shop_2', name: 'iPhone 15 Pro Max', category: 'Phones', price: 1250000, inStock: true, rating: 4.8, reviewCount: 41, shopName: 'PhoneHub'),
  ProductWithShop(id: 'prod_9', shopId: 'shop_3', name: 'Premium Swiss Lace', category: 'Fabrics', price: 35000, inStock: true, rating: 4.8, reviewCount: 31, shopName: 'GlobalFabrics'),
  ProductWithShop(id: 'prod_13', shopId: 'shop_4', name: 'Thermocool Chest Freezer 300L', category: 'Appliances', price: 285000, inStock: true, rating: 4.6, reviewCount: 23, shopName: 'Kemis Home Appliances'),
  ProductWithShop(id: 'prod_17', shopId: 'shop_5', name: 'Gabriel Shock Absorbers', category: 'Auto', price: 42000, inStock: true, rating: 4.3, reviewCount: 14, shopName: 'AutoParts Pro'),
  ProductWithShop(id: 'prod_21', shopId: 'shop_6', name: 'Fenty Beauty Foundation', category: 'Beauty', price: 38000, inStock: true, rating: 4.6, reviewCount: 27, shopName: 'BeautyGlow Studio'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedMarket = context.watch<MarketProvider>().selectedMarket;
    final featuredShops = selectedMarket.isEmpty
        ? _featuredShops
        : _featuredShops.where((shop) => shop.market == selectedMarket).toList();
    final trendingProducts = selectedMarket.isEmpty
        ? _trendingProducts
        : _trendingProducts.where((product) {
            final shop = _featuredShops.where((item) => item.id == product.shopId);
            return shop.isNotEmpty && shop.first.market == selectedMarket;
          }).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const AppLogo(size: 30),
        actions: [
          const ChatIconButton(),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const CityMarketSelector(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MapCard(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapsScreen()))),
                  _WelcomeBanner(),
                  _SearchBar(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()))),
                  _SectionHeader(title: 'Categories'),
                  _CategoriesRow(),
                  _SectionHeader(title: 'Products for Sale'),
                  _TrendingProducts(products: trendingProducts),
                  _SectionHeader(title: 'Featured Shops'),
                  _FeaturedShops(shops: featuredShops),
                  _TrustBanner(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  final VoidCallback? onTap;
  const _MapCard({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.navy],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.map_rounded, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Explore the Market Map', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text('Find your way to any shop inside the market.', style: GoogleFonts.sourceSans3(fontSize: 12, color: Colors.white.withOpacity(0.85))),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_forward, color: AppColors.primary, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF2A5DB0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back,', style: GoogleFonts.sourceSans3(fontSize: 14, color: Colors.white70)),
                const SizedBox(height: 2),
                Text('Chidi! 👋', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 6),
                Text('Discover amazing products from trusted shops near you.', style: GoogleFonts.sourceSans3(fontSize: 13, color: Colors.white.withOpacity(0.85))),
              ],
            ),
          ),
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.shopping_bag, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  const _SearchBar({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
          child: Row(
            children: [
              const Icon(Icons.search, color: AppColors.textHint, size: 20),
              const SizedBox(width: 10),
              Text('Search products, shops, markets...', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textHint)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          Text('See All', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _CategoriesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = _categories[i];
          return Column(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                child: Center(child: Text(cat['icon']!, style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(height: 4),
              Text(cat['name']!, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
            ],
          );
        },
      ),
    );
  }
}

class _FeaturedShops extends StatelessWidget {
  final List<Shop> shops;
  const _FeaturedShops({required this.shops});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: shops.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final shop = shops[i];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShopDetailScreen(shop: shop))),
            child: Container(
              width: 180,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: Shop.parseGradient(shop.bannerGradient)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text(shop.name[0], style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700))),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(shop.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary), overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(shop.category, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: AppColors.starActive),
                      const SizedBox(width: 3),
                      Text(shop.rating.toString(), style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      const SizedBox(width: 4),
                      Text('(${shop.reviewCount})', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textHint)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TrendingProducts extends StatelessWidget {
  final List<ProductWithShop> products;
  const _TrendingProducts({required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => ProductCard(product: products[i], width: 160),
      ),
    );
  }
}

class _TrustBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.verified_user, 'label': 'Verified\nSellers'},
      {'icon': Icons.local_shipping, 'label': 'Direct\nDelivery'},
      {'icon': Icons.security, 'label': 'Escrow\nPayment'},
      {'icon': Icons.support_agent, 'label': '24/7\nSupport'},
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return Column(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                child: Icon(item['icon'] as IconData, color: AppColors.primary, size: 22),
              ),
              const SizedBox(height: 6),
              Text(item['label'] as String, style: GoogleFonts.sourceSans3(fontSize: 10, color: AppColors.textSecondary, height: 1.3), textAlign: TextAlign.center),
            ],
          );
        }).toList(),
      ),
    );
  }
}
