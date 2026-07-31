import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _discountCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();
  final _skuCtrl = TextEditingController();
  final _tagCtrl = TextEditingController();

  String _category = 'Home Decor';
  String _subcategory = '';
  bool _isPublished = false;

  final List<String> _tags = [];
  final List<ProductVariant> _variants = [];
  final List<String> _categories = ['Home Decor', 'Art', 'Fashion', 'Accessories', 'Kitchen', 'Jewelry'];
  final List<String> _variantTypes = ['Color', 'Size', 'Material'];

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final p = widget.product!;
      _nameCtrl.text = p.name;
      _descCtrl.text = p.description;
      _priceCtrl.text = p.price.toString();
      _discountCtrl.text = p.discountPercentage.toString();
      _stockCtrl.text = p.stockQuantity.toString();
      _skuCtrl.text = p.sku;
      _tags.addAll(p.tags);
      _variants.addAll(p.variants.map((v) => ProductVariant(type: v.type, value: v.value, stock: v.stock)));
      _category = p.category;
      _subcategory = p.subcategory;
      _isPublished = p.status == 'published';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _discountCtrl.dispose();
    _stockCtrl.dispose();
    _skuCtrl.dispose();
    _tagCtrl.dispose();
    super.dispose();
  }

  void _save(String status) {
    final product = Product(
      id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text,
      description: _descCtrl.text,
      category: _category,
      subcategory: _subcategory,
      price: double.tryParse(_priceCtrl.text) ?? 0,
      discountPercentage: double.tryParse(_discountCtrl.text) ?? 0,
      stockQuantity: int.tryParse(_stockCtrl.text) ?? 0,
      sku: _skuCtrl.text,
      tags: List.from(_tags),
      variants: List.from(_variants),
      status: status,
    );
    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.product != null ? 'Edit Product' : 'Add Product',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => _save('published'),
            child: Text('Publish', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Basic Information', [
              _textField(_nameCtrl, 'Product Name'),
              _textArea(_descCtrl, 'Description'),
              _dropdown('Category', _category, _categories, (v) => setState(() => _category = v!)),
              _textField(_skuCtrl, 'SKU'),
            ]),
            const SizedBox(height: 16),
            _buildSection('Pricing & Stock', [
              _textField(_priceCtrl, 'Price (₦)', keyboardType: TextInputType.number),
              _textField(_discountCtrl, 'Discount (%)', keyboardType: TextInputType.number),
              _textField(_stockCtrl, 'Stock Quantity', keyboardType: TextInputType.number),
            ]),
            const SizedBox(height: 16),
            _buildSection('Tags', [
              _buildTagsInput(),
              if (_tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _tags.map((t) => Chip(
                    label: Text(t, style: GoogleFonts.inter(fontSize: 12, color: AppColors.primary)),
                    deleteIcon: const Icon(Icons.close, size: 14, color: AppColors.primary),
                    onDeleted: () => setState(() => _tags.remove(t)),
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    side: BorderSide.none,
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
              ],
            ]),
            const SizedBox(height: 16),
            _buildSection('Variants', [
              _buildVariantsSection(),
            ]),
            const SizedBox(height: 16),
            _buildSection('Status', [
              SwitchListTile(
                title: Text('Published', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
                subtitle: Text(
                  _isPublished ? 'Product is visible to customers' : 'Product is saved as draft',
                  style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                ),
                value: _isPublished,
                activeColor: AppColors.primary,
                onChanged: (v) => setState(() => _isPublished = v),
                contentPadding: EdgeInsets.zero,
              ),
            ]),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Cancel', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _save('draft'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Save Draft', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _save('published'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Publish', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _textField(TextEditingController ctrl, String label, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        style: GoogleFonts.inter(fontSize: 13),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          isDense: true,
        ),
      ),
    );
  }

  Widget _textArea(TextEditingController ctrl, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        maxLines: 4,
        style: GoogleFonts.inter(fontSize: 13),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint),
          alignLabelWithHint: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontSize: 13)))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildTagsInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _tagCtrl,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Type tag and press Enter',
              hintStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              isDense: true,
            ),
            onSubmitted: (v) => _addTag(v),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.add_circle, color: AppColors.primary),
          onPressed: () => _addTag(_tagCtrl.text),
        ),
      ],
    );
  }

  void _addTag(String v) {
    if (v.trim().isNotEmpty && !_tags.contains(v.trim())) {
      setState(() => _tags.add(v.trim()));
      _tagCtrl.clear();
    }
  }

  Widget _buildVariantsSection() {
    return Column(
      children: [
        ..._variants.asMap().entries.map((entry) {
          final i = entry.key;
          final v = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: v.type,
                    items: _variantTypes.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontSize: 12)))).toList(),
                    onChanged: (val) => setState(() => _variants[i].type = val!),
                    decoration: InputDecoration(
                      labelText: 'Type',
                      labelStyle: GoogleFonts.inter(fontSize: 12, color: AppColors.textHint),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.border)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: v.value),
                    style: GoogleFonts.inter(fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'Value',
                      labelStyle: GoogleFonts.inter(fontSize: 12, color: AppColors.textHint),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.border)),
                    ),
                    onChanged: (val) => _variants[i].value = val,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: TextEditingController(text: v.stock.toString()),
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'Stock',
                      labelStyle: GoogleFonts.inter(fontSize: 12, color: AppColors.textHint),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: AppColors.border)),
                    ),
                    onChanged: (val) => _variants[i].stock = int.tryParse(val) ?? 0,
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: AppColors.red, size: 20),
                  onPressed: () => setState(() => _variants.removeAt(i)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 4),
        TextButton.icon(
          onPressed: () {
            setState(() => _variants.add(ProductVariant(type: 'Color', value: '', stock: 0)));
          },
          icon: const Icon(Icons.add, size: 16),
          label: Text('Add Variant', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
        ),
      ],
    );
  }
}
