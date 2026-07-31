import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _cartItems = [
    CartItem(product: ProductWithShop(id: 'prod_1', shopId: 'shop_1', name: 'Samsung 55" 4K Smart TV', category: 'Electronics', price: 450000, shopName: 'TechCity'), variant: '55" 4K', quantity: 1),
    CartItem(product: ProductWithShop(id: 'prod_5', shopId: 'shop_2', name: 'iPhone 15 Pro Max', category: 'Phones', price: 1250000, shopName: 'PhoneHub'), variant: '256GB', quantity: 1),
    CartItem(product: ProductWithShop(id: 'prod_9', shopId: 'shop_3', name: 'Premium Swiss Lace', category: 'Fabrics', price: 35000, shopName: 'GlobalFabrics'), variant: 'White', quantity: 2),
  ];

  double get _subtotal => _cartItems.fold(0.0, (s, i) => s + i.totalPrice);
  double get _deliveryFee => 1500.0;
  double get _total => _subtotal + _deliveryFee;

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Login Required', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        content: Text('Please log in to proceed with checkout.', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: GoogleFonts.sourceSans3(color: AppColors.textSecondary))),
          ElevatedButton(onPressed: () => Navigator.pop(ctx), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0), child: Text('Login', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Shopping Cart', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
        actions: [
          if (_cartItems.isNotEmpty)
            TextButton(
              onPressed: () => setState(() => _cartItems.clear()),
              child: Text('Clear', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.error, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
      body: _cartItems.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 80, color: AppColors.textHint.withOpacity(0.4)),
                const SizedBox(height: 16),
                Text('Your cart is empty', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text('Browse products and add items to your cart', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
                  child: Text('Start Shopping', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _cartItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final item = _cartItems[i];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                      child: Row(
                        children: [
                          Container(
                            width: 64, height: 64,
                            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.shopping_bag, color: AppColors.primary, size: 28),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.product.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary), maxLines: 2, overflow: TextOverflow.ellipsis),
                                if (item.variant.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text('Variant: ${item.variant}', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                                ],
                                const SizedBox(height: 2),
                                Text(item.product.shopName, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textHint)),
                                const SizedBox(height: 4),
                                Text('₦${_formatPrice(item.product.price)}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.accent)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _qtyBtn(Icons.remove, item.quantity > 1 ? () {
                                      setState(() => item.quantity--);
                                    } : null),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                      child: Text('${item.quantity}', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                                    ),
                                    _qtyBtn(Icons.add, () => setState(() => item.quantity++)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: () => setState(() => _cartItems.removeAt(i)),
                                child: Icon(Icons.delete_outline, size: 18, color: AppColors.error.withOpacity(0.7)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))]),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _summaryRow('Subtotal', _subtotal),
                    const SizedBox(height: 6),
                    _summaryRow('Delivery Fee', _deliveryFee),
                    const Divider(height: 16),
                    _summaryRow('Total', _total, isBold: true),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity, height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_cartItems.isEmpty) return;
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(cartItems: _cartItems)));
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                        child: Text('Proceed to Checkout', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16, color: onPressed != null ? AppColors.textPrimary : AppColors.textHint),
      ),
    );
  }

  Widget _summaryRow(String label, double amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.sourceSans3(fontSize: isBold ? 15 : 13, fontWeight: isBold ? FontWeight.w600 : FontWeight.normal, color: AppColors.textSecondary)),
        Text('₦${amount.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: isBold ? 16 : 13, fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, color: AppColors.textPrimary)),
      ],
    );
  }

  String _formatPrice(double p) {
    if (p >= 1000000) return '${(p / 1000000).toStringAsFixed(1)}M';
    if (p >= 1000) return '${(p / 1000).toStringAsFixed(0)}K';
    return p.toStringAsFixed(0);
  }
}
