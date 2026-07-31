import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import '../chat/chat_screen.dart';
import '../call/call_screen.dart';

final List<ProductWithShop> _shopProducts = [
  ProductWithShop(id: 'sp_1', shopId: 'shop_1', name: 'Samsung 55" 4K Smart TV', category: 'Electronics', price: 450000, inStock: true, rating: 4.7, reviewCount: 34, shopName: 'TechCity'),
  ProductWithShop(id: 'sp_2', shopId: 'shop_1', name: 'Sony PlayStation 5', category: 'Electronics', price: 380000, inStock: true, rating: 4.9, reviewCount: 52, shopName: 'TechCity'),
  ProductWithShop(id: 'sp_3', shopId: 'shop_1', name: 'JBL PartyBox 310', category: 'Electronics', price: 210000, inStock: true, rating: 4.6, reviewCount: 28, shopName: 'TechCity'),
  ProductWithShop(id: 'sp_4', shopId: 'shop_1', name: 'LG 1.5HP Split AC', category: 'Electronics', price: 185000, inStock: true, rating: 4.5, reviewCount: 19, shopName: 'TechCity'),
];

final List<Map<String, dynamic>> _shopReviews = [
  {'name': 'Chidi O.', 'rating': 5.0, 'text': 'Bought a PS5 from here. Best price in Lagos!', 'date': '2d ago'},
  {'name': 'Funmi A.', 'rating': 5.0, 'text': 'The TV is amazing. Great service!', 'date': '4d ago'},
  {'name': 'Emeka N.', 'rating': 4.5, 'text': 'Helped me pick the right AC for my apartment.', 'date': '1w ago'},
  {'name': 'Sarah I.', 'rating': 5.0, 'text': 'JBL speaker is fire! Great for parties.', 'date': '2w ago'},
  {'name': 'Tunde O.', 'rating': 4.0, 'text': 'Good prices but delivery took longer expected.', 'date': '3w ago'},
];

class ShopDetailScreen extends StatefulWidget {
  final Shop shop;
  const ShopDetailScreen({super.key, required this.shop});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.shop;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Shop.parseGradient(s.bannerGradient),
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            width: 60, height: 60,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                            child: Center(child: Text(s.name[0], style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary))),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(s.name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                                    if (s.verified) ...[const SizedBox(width: 6), const Icon(Icons.verified, size: 18, color: AppColors.verifiedBadge)],
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(s.category, style: GoogleFonts.sourceSans3(fontSize: 13, color: Colors.white70)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: AppColors.starActive),
                                    const SizedBox(width: 3),
                                    Text(s.rating.toString(), style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                                    const SizedBox(width: 8),
                                    Icon(Icons.location_on, size: 12, color: Colors.white70),
                                    const SizedBox(width: 2),
                                    Text(s.location, style: GoogleFonts.sourceSans3(fontSize: 10, color: Colors.white70)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabCtrl,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                  unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
                  indicatorColor: AppColors.primary,
                  tabs: const [
                    Tab(text: 'Products'),
                    Tab(text: 'About'),
                    Tab(text: 'Reviews'),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabCtrl,
          children: [
            _ProductsTab(shop: s),
            _AboutTab(shop: s),
            _ReviewsTab(shop: s),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(contactName: s.name))),
                icon: const Icon(Icons.phone, size: 18),
                label: Text('Call', style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, side: const BorderSide(color: AppColors.primary), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen(shopName: 'TechCity'))),
                icon: const Icon(Icons.chat, size: 18),
                label: Text('Chat', style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsTab extends StatelessWidget {
  final Shop shop;
  const _ProductsTab({required this.shop});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _shopProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemBuilder: (_, i) {
        final p = _shopProducts[i];
        return Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.shopping_bag, color: AppColors.primary, size: 28),
                ),
              ),
              const SizedBox(height: 8),
              Text(p.name, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text('₦${p.price.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.accent)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.add, size: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AboutTab extends StatelessWidget {
  final Shop shop;
  const _AboutTab({required this.shop});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text(shop.description, style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                const SizedBox(height: 16),
                Text('Contact Information', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                _infoRow(Icons.phone, 'Phone', shop.phone),
                _infoRow(Icons.location_on, 'Location', shop.location),
                _infoRow(Icons.store, 'Market', shop.market),
                _infoRow(Icons.pin_drop, 'Shop No.', shop.shopNumber),
                const SizedBox(height: 16),
                Text('Business Hours', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                _infoRow(Icons.access_time, 'Hours', shop.hours),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 10),
          Text('$label: ', style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          Expanded(child: Text(value, style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary))),
        ],
      ),
    );
  }
}

class _ReviewsTab extends StatefulWidget {
  final Shop shop;
  const _ReviewsTab({required this.shop});

  @override
  State<_ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<_ReviewsTab> {
  final TextEditingController _reviewCtrl = TextEditingController();
  double _userRating = 5.0;

  @override
  void dispose() {
    _reviewCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Column(
              children: [
                Text('Rating Summary', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.shop.rating.toString(), style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        Row(
                          children: List.generate(5, (i) => Icon(i < widget.shop.rating.round() ? Icons.star : Icons.star_border, size: 16, color: AppColors.starActive)),
                        ),
                        Text('${widget.shop.reviewCount} reviews', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Write a Review', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (i) {
                    final star = i + 1.0;
                    return IconButton(
                      icon: Icon(star <= _userRating ? Icons.star : Icons.star_border, color: AppColors.starActive, size: 28),
                      onPressed: () => setState(() => _userRating = star),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _reviewCtrl,
                  maxLines: 3,
                  style: GoogleFonts.sourceSans3(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Share your experience...',
                    hintStyle: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textHint),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary)),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, height: 42,
                  child: ElevatedButton(
                    onPressed: () => _reviewCtrl.clear(),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
                    child: Text('Submit Review', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_shopReviews.length, (i) {
            final r = _shopReviews[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 14, backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(r['name'][0], style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary))),
                      const SizedBox(width: 8),
                      Text(r['name'], style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      const Spacer(),
                      Row(
                        children: List.generate(5, (j) => Icon(j < (r['rating'] as double).round() ? Icons.star : Icons.star_border, size: 12, color: AppColors.starActive)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(r['text'], style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Text(r['date'], style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textHint)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
