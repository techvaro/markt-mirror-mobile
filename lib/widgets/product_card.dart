import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import '../screens/buyer/product_detail/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductWithShop product;
  final double? width;
  const ProductCard({super.key, required this.product, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: _categoryColor(product.category).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_categoryIcon(product.category), size: 32, color: _categoryColor(product.category)),
                      const SizedBox(height: 4),
                      Text(product.category, style: GoogleFonts.sourceSans3(fontSize: 10, color: _categoryColor(product.category))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(product.name, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(product.shopName, style: GoogleFonts.sourceSans3(fontSize: 10, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text('₦${_formatPrice(product.price)}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.accent), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  if (!product.inStock)
                    Text('Out of Stock', style: GoogleFonts.sourceSans3(fontSize: 9, color: AppColors.error))
                  else
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.add, size: 14, color: Colors.white),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _categoryColor(String cat) {
    switch (cat) {
      case 'Electronics': return AppColors.blue;
      case 'Phones': return AppColors.purple;
      case 'Fabrics': return AppColors.pink;
      case 'Appliances': return AppColors.teal;
      case 'Auto': return AppColors.orange;
      case 'Beauty': return AppColors.accent;
      default: return AppColors.primary;
    }
  }

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
