import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/screens/vendor/product_form/product_form_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedFilter = 'All';
  String _selectedStock = 'All';
  final List<String> _filters = ['All', 'Published', 'Draft', 'Archived'];
  final List<String> _stockFilters = ['All', 'In Stock', 'Low Stock', 'Out of Stock'];

  List<Product> _products = [
    Product(id: 'p1', name: 'Handwoven Basket', description: 'Beautiful handwoven basket', category: 'Home Decor', price: 6250.0, stockQuantity: 15, sku: 'HWB-001', status: 'published'),
    Product(id: 'p2', name: 'Beaded Necklace', description: 'Colorful beaded necklace', category: 'Accessories', price: 8500.0, stockQuantity: 0, sku: 'BN-002', status: 'published'),
    Product(id: 'p3', name: 'Canvas Painting', description: 'Abstract canvas painting', category: 'Art', price: 32000.0, stockQuantity: 3, sku: 'CP-003', status: 'published'),
    Product(id: 'p4', name: 'Leather Pouch', description: 'Handmade leather pouch', category: 'Accessories', price: 2800.0, stockQuantity: 8, sku: 'LP-004', status: 'draft'),
    Product(id: 'p5', name: 'Ankara Dress', description: 'Beautiful Ankara print dress', category: 'Fashion', price: 18000.0, stockQuantity: 2, sku: 'AD-005', status: 'published'),
    Product(id: 'p6', name: 'Wooden Sculpture', description: 'Hand-carved wooden sculpture', category: 'Art', price: 45000.0, stockQuantity: 1, sku: 'WS-006', status: 'archived'),
    Product(id: 'p7', name: 'Beaded Earrings', description: 'Handmade beaded earrings', category: 'Accessories', price: 3500.0, stockQuantity: 0, sku: 'BE-007', status: 'published'),
    Product(id: 'p8', name: 'Leather Sandals', description: 'Comfortable leather sandals', category: 'Fashion', price: 12000.0, stockQuantity: 4, sku: 'LS-008', status: 'published'),
  ];

  List<Product> get _filteredProducts {
    var list = _products;
    if (_selectedFilter != 'All') {
      list = list.where((p) => p.status.toLowerCase() == _selectedFilter.toLowerCase()).toList();
    }
    if (_selectedStock != 'All') {
      switch (_selectedStock) {
        case 'In Stock':
          list = list.where((p) => p.stockQuantity > 5).toList();
          break;
        case 'Low Stock':
          list = list.where((p) => p.isLowStock).toList();
          break;
        case 'Out of Stock':
          list = list.where((p) => p.isOutOfStock).toList();
          break;
      }
    }
    if (_searchCtrl.text.isNotEmpty) {
      final q = _searchCtrl.text.toLowerCase();
      list = list.where((p) => p.name.toLowerCase().contains(q) || p.sku.toLowerCase().contains(q)).toList();
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
    final products = _filteredProducts;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Products', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductFormScreen())),
            icon: const Icon(Icons.add, size: 18),
            label: Text('Add', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 18, color: AppColors.textHint),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (_) => setState(() {}),
                          style: GoogleFonts.inter(fontSize: 13),
                          decoration: const InputDecoration(
                            hintText: 'Search products...',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _filters.map((f) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _filterChip(f, _selectedFilter == f, () => setState(() => _selectedFilter = f)),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _stockFilters.map((f) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _filterChip(f, _selectedStock == f, () => setState(() => _selectedStock = f), color: _stockChipColor(f)),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${products.length} product${products.length != 1 ? 's' : ''}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: products.length,
                    itemBuilder: (_, i) => _buildProductCard(products[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool selected, VoidCallback onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? (color ?? AppColors.primary) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? (color ?? AppColors.primary) : AppColors.border),
        ),
        child: Center(
          child: Text(label, style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : (color ?? AppColors.textSecondary),
          )),
        ),
      ),
    );
  }

  Color _stockChipColor(String filter) {
    switch (filter) {
      case 'Low Stock': return AppColors.orange;
      case 'Out of Stock': return AppColors.red;
      default: return AppColors.primary;
    }
  }

  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Icon(Icons.image_outlined, size: 36, color: AppColors.textHint.withOpacity(0.4)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: _statusBadge(product.status),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _stockColor(product.stockQuantity).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Stock: ${product.stockQuantity}', style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _stockColor(product.stockQuantity),
                  )),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text('₦${product.displayPrice}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _productMenu(product),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productMenu(Product product) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.more_vert, size: 16, color: AppColors.textHint),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProductFormScreen(product: product)));
            break;
          case 'duplicate':
            break;
          case 'delete':
            _confirmDelete(product);
            break;
        }
      },
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'edit', child: ListTile(leading: Icon(Icons.edit, size: 18), title: Text('Edit', style: TextStyle(fontSize: 13)), dense: true)),
        const PopupMenuItem(value: 'duplicate', child: ListTile(leading: Icon(Icons.copy, size: 18), title: Text('Duplicate', style: TextStyle(fontSize: 13)), dense: true)),
        const PopupMenuItem(value: 'delete', child: ListTile(leading: Icon(Icons.delete, size: 18, color: AppColors.red), title: Text('Delete', style: TextStyle(fontSize: 13, color: AppColors.red)), dense: true)),
      ],
    );
  }

  void _confirmDelete(Product product) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () { Navigator.pop(ctx); setState(() => _products.remove(product)); }, child: const Text('Delete', style: TextStyle(color: AppColors.red))),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined, size: 64, color: AppColors.textHint.withOpacity(0.4)),
          const SizedBox(height: 12),
          Text('No products found', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text('Add your first product to get started', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductFormScreen())),
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Product'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }

  Color _stockColor(int stock) {
    if (stock == 0) return AppColors.red;
    if (stock <= 5) return AppColors.orange;
    return AppColors.green;
  }

  Widget _statusBadge(String status) {
    Color bg; Color fg; String label;
    switch (status) {
      case 'published': bg = AppColors.success.withOpacity(0.1); fg = AppColors.success; label = 'Published'; break;
      case 'draft': bg = AppColors.warning.withOpacity(0.1); fg = AppColors.warning; label = 'Draft'; break;
      case 'archived': bg = AppColors.textHint.withOpacity(0.1); fg = AppColors.textHint; label = 'Archived'; break;
      default: bg = AppColors.textHint.withOpacity(0.1); fg = AppColors.textHint; label = status; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}
