import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final List<String> _tabs = ['All Stock', 'Low Stock', 'Out of Stock'];

  final _summary = InventorySummary(
    totalItems: 248,
    lowStockItems: 12,
    outOfStockItems: 5,
    inventoryValue: 3845000.0,
  );

  List<Product> _products = [
    Product(id: 'p1', name: 'Handwoven Basket', price: 6250.0, stockQuantity: 15, sku: 'HWB-001', category: 'Home Decor', status: 'published'),
    Product(id: 'p2', name: 'Beaded Necklace', price: 8500.0, stockQuantity: 0, sku: 'BN-002', category: 'Accessories', status: 'published'),
    Product(id: 'p3', name: 'Canvas Painting', price: 32000.0, stockQuantity: 3, sku: 'CP-003', category: 'Art', status: 'published'),
    Product(id: 'p4', name: 'Leather Pouch', price: 2800.0, stockQuantity: 8, sku: 'LP-004', category: 'Accessories', status: 'draft'),
    Product(id: 'p5', name: 'Ankara Dress', price: 18000.0, stockQuantity: 2, sku: 'AD-005', category: 'Fashion', status: 'published'),
    Product(id: 'p6', name: 'Wooden Sculpture', price: 45000.0, stockQuantity: 1, sku: 'WS-006', category: 'Art', status: 'archived'),
    Product(id: 'p7', name: 'Beaded Earrings', price: 3500.0, stockQuantity: 0, sku: 'BE-007', category: 'Accessories', status: 'published'),
    Product(id: 'p8', name: 'Leather Sandals', price: 12000.0, stockQuantity: 4, sku: 'LS-008', category: 'Fashion', status: 'published'),
    Product(id: 'p9', name: 'Ceramic Vase', price: 15000.0, stockQuantity: 20, sku: 'CV-009', category: 'Home Decor', status: 'published'),
    Product(id: 'p10', name: 'Silk Scarf', price: 9500.0, stockQuantity: 7, sku: 'SS-010', category: 'Fashion', status: 'published'),
  ];

  List<Product> get _filteredProducts {
    switch (_tabCtrl.index) {
      case 1:
        return _products.where((p) => p.isLowStock && !p.isOutOfStock).toList();
      case 2:
        return _products.where((p) => p.isOutOfStock).toList();
      default:
        return _products;
    }
  }

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
    final filtered = _filteredProducts;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Inventory', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    _summaryCard('Total Items', '${_summary.totalItems}', Icons.inventory, AppColors.kpiBlue),
                    const SizedBox(width: 8),
                    _summaryCard('Low Stock', '${_summary.lowStockItems}', Icons.warning_amber, AppColors.kpiOrange),
                    const SizedBox(width: 8),
                    _summaryCard('Out of Stock', '${_summary.outOfStockItems}', Icons.highlight_off, AppColors.kpiRed),
                    const SizedBox(width: 8),
                    _summaryCard('Value', '₦${_formatAmount(_summary.inventoryValue)}', Icons.monetization_on, AppColors.kpiGreen),
                  ],
                ),
                if (_summary.lowStockItems > 0 || _summary.outOfStockItems > 0) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, size: 16, color: AppColors.warning),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${_summary.outOfStockItems} product${_summary.outOfStockItems != 1 ? 's' : ''} out of stock, ${_summary.lowStockItems} running low',
                            style: GoogleFonts.inter(fontSize: 11, color: AppColors.warning),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                TabBar(
                  controller: _tabCtrl,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textHint,
                  indicatorColor: AppColors.primary,
                  labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                  unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
                  tabs: _tabs.map((t) => Tab(text: t)).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState(_tabCtrl.index)
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => _buildInventoryRow(filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(height: 4),
            Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text(label, style: GoogleFonts.inter(fontSize: 9, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryRow(Product product) {
    final stockValue = product.price * product.stockQuantity;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Icon(Icons.image_outlined, size: 20, color: AppColors.textHint.withOpacity(0.5))),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('SKU: ${product.sku}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Expanded(
            child: Text(product.category, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _stockBadge(product),
                const SizedBox(height: 2),
                Text('₦${product.displayPrice}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('₦${_formatAmount(stockValue)}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart, size: 18, color: AppColors.primary),
            onPressed: () => _showRestockDialog(product),
            tooltip: 'Restock',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _stockBadge(Product product) {
    Color c;
    String l;
    if (product.isOutOfStock) { c = AppColors.red; l = 'Out of Stock'; }
    else if (product.isLowStock) { c = AppColors.orange; l = 'Low Stock'; }
    else { c = AppColors.green; l = 'In Stock'; }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(l, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w600, color: c)),
    );
  }

  void _showRestockDialog(Product product) {
    final qtyCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Restock ${product.name}', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
        content: TextField(
          controller: qtyCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Quantity to add',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final qty = int.tryParse(qtyCtrl.text) ?? 0;
              if (qty > 0) {
                setState(() {
                  final idx = _products.indexWhere((p) => p.id == product.id);
                  if (idx >= 0) {
                    _products[idx] = Product(
                      id: product.id, name: product.name, description: product.description,
                      category: product.category, price: product.price, stockQuantity: product.stockQuantity + qty,
                      sku: product.sku, status: product.status,
                    );
                  }
                });
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Restock'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(int tabIndex) {
    String msg;
    IconData icon;
    switch (tabIndex) {
      case 1: msg = 'No low stock items'; icon = Icons.check_circle; break;
      case 2: msg = 'No out of stock items'; icon = Icons.check_circle; break;
      default: msg = 'No products in inventory'; icon = Icons.inventory_2_outlined; break;
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: AppColors.textHint.withOpacity(0.4)),
          const SizedBox(height: 8),
          Text(msg, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return amount.toStringAsFixed(0);
  }
}
