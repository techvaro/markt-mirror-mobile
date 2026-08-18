import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import '../shops/shops_screen.dart';

final List<ProductWithShop> _relatedProducts = [
  ProductWithShop(id: 'rel_1', shopId: 'shop_1', name: 'Sony PlayStation 5', category: 'Electronics', price: 380000, inStock: true, rating: 4.9, reviewCount: 52, shopName: 'TechCity'),
  ProductWithShop(id: 'rel_2', shopId: 'shop_1', name: 'JBL PartyBox 310', category: 'Electronics', price: 210000, inStock: true, rating: 4.6, reviewCount: 28, shopName: 'TechCity'),
  ProductWithShop(id: 'rel_3', shopId: 'shop_2', name: 'Samsung Galaxy S24 Ultra', category: 'Phones', price: 1150000, inStock: true, rating: 4.7, reviewCount: 36, shopName: 'PhoneHub'),
];

class ProductDetailScreen extends StatefulWidget {
  final ProductWithShop product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  String? _selectedVariant;

  @override
  void initState() {
    super.initState();
    if (widget.product.variants.isNotEmpty) {
      _selectedVariant = widget.product.variants.first.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary), onPressed: () {}),
          IconButton(icon: const Icon(Icons.favorite_border, color: AppColors.textPrimary), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220, width: double.infinity,
              decoration: BoxDecoration(color: _grey.withOpacity(0.08)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_categoryIcon(p.category), size: 64, color: _grey),
                    const SizedBox(height: 12),
                    Text(p.category, style: GoogleFonts.poppins(fontSize: 14, color: _grey, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.name, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                            const SizedBox(height: 6),
                            Text('₦${_formatPrice(p.price)}', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.accent)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: _grey.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                        child: Text(p.category, style: GoogleFonts.sourceSans3(fontSize: 11, fontWeight: FontWeight.w600, color: _grey)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (p.variants.isNotEmpty) ...[
                    Text('Available Variants', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: p.variants.map((v) {
                        final isSelected = _selectedVariant == v.value;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedVariant = v.value),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? _grey : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: isSelected ? _grey : AppColors.border),
                            ),
                            child: Text(v.value, style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textPrimary)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text('Description', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 6),
                  Text(p.description.isNotEmpty ? p.description : 'High-quality product from ${p.shopName}. Available at a competitive price with fast delivery across Nigeria.', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, size: 18, color: AppColors.textHint),
                          const SizedBox(width: 4),
                          Text(p.rating.toString(), style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          const SizedBox(width: 4),
                          Text('(${p.reviewCount} reviews)', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text('Quantity:', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary)),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 18),
                                  onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                ),
                                Text('$_quantity', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 18),
                                  onPressed: () => setState(() => _quantity++),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                    child: Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: _grey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.store, color: AppColors.textSecondary, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(p.shopName, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.verified, size: 16, color: AppColors.textHint),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text('Computer Village, Ikeja, Lagos', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.textHint),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (!p.inStock)
                    Container(
                      width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(color: AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: Text('Out of Stock', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.error)),
                    )
                  else
                    SizedBox(
                      width: double.infinity, height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to cart!', style: GoogleFonts.sourceSans3(fontSize: 14)), backgroundColor: _grey));
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: _grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                        child: Text('Add to Cart', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text('Related Products', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _relatedProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) {
                        final r = _relatedProducts[i];
                        return Container(
                          width: 140,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60, width: double.infinity,
                                decoration: BoxDecoration(color: _grey.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                child: Icon(_categoryIcon(r.category), color: _grey, size: 24),
                              ),
                              const SizedBox(height: 6),
                              Text(r.name, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const Spacer(),
                              Text('₦${_formatPrice(r.price)}', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.accent)),
                            ],
                          ),
                        );
                      },
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

  static const Color _grey = Color(0xFF64748B);

  IconData _categoryIcon(String cat) {
    switch (cat) {
      case 'Electronics': return Icons.tv;
      case 'Phones': return Icons.phone_android;
      case 'Fabrics': return Icons.style;
      case 'Appliances': return Icons.kitchen;
      case 'Auto': return Icons.directions_car;
      case 'Beauty': return Icons.spa;
      default: return Icons.shopping_bag;
    }
  }

  String _formatPrice(double p) {
    if (p >= 1000000) return '${(p / 1000000).toStringAsFixed(1)}M';
    if (p >= 1000) return '${(p / 1000).toStringAsFixed(0)}K';
    return p.toStringAsFixed(0);
  }
}
