import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class ShopProfileScreen extends StatefulWidget {
  const ShopProfileScreen({super.key});

  @override
  State<ShopProfileScreen> createState() => _ShopProfileScreenState();
}

class _ShopProfileScreenState extends State<ShopProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'Chidi\'s Crafts');
  final _descCtrl = TextEditingController(text: 'Handcrafted African art and accessories. We specialize in traditional weaving, beadwork, and leather crafting.');
  final _phoneCtrl = TextEditingController(text: '+234 812 345 6789');
  final _emailCtrl = TextEditingController(text: 'chidi@craftmarket.com');
  final _websiteCtrl = TextEditingController(text: 'www.chidiscrafts.com');
  final _marketCtrl = TextEditingController(text: 'Ikeja Craft Market');
  final _stallCtrl = TextEditingController(text: 'Stall B12');
  final _addressCtrl = TextEditingController(text: '12B Market Road');
  final _cityCtrl = TextEditingController(text: 'Ikeja, Lagos');
  final _gpsLatCtrl = TextEditingController(text: '6.6018');
  final _gpsLngCtrl = TextEditingController(text: '3.3515');
  final _regCtrl = TextEditingController(text: 'RC-2024-12345');
  final _igCtrl = TextEditingController(text: '@chidiscrafts');
  final _fbCtrl = TextEditingController(text: 'ChidisCrafts');
  final _twCtrl = TextEditingController(text: '@chidiscrafts');

  String _category = 'Arts & Crafts';
  final List<bool> _closedDays = List.generate(7, (_) => false);

  final _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _websiteCtrl.dispose();
    _marketCtrl.dispose();
    _stallCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _gpsLatCtrl.dispose();
    _gpsLngCtrl.dispose();
    _regCtrl.dispose();
    _igCtrl.dispose();
    _fbCtrl.dispose();
    _twCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.textPrimary),
        title: Text('Shop Profile', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Save', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildUploadSection('Banner Image', Icons.photo_library),
            const SizedBox(height: 12),
            _buildUploadSection('Shop Logo', Icons.image),
            const SizedBox(height: 20),
            _buildFormSection('Basic Information', [
              _textField(_nameCtrl, 'Shop Name'),
              _textArea(_descCtrl, 'Description'),
              _dropdown('Category', _category, ['Arts & Crafts', 'Fashion', 'Home Decor', 'Accessories', 'Food'], (v) => setState(() => _category = v!)),
              _textField(_regCtrl, 'Business Reg. Number'),
            ]),
            const SizedBox(height: 16),
            _buildFormSection('Contact', [
              _textField(_phoneCtrl, 'Phone Number'),
              _textField(_emailCtrl, 'Email'),
              _textField(_websiteCtrl, 'Website'),
            ]),
            const SizedBox(height: 16),
            _buildFormSection('Location', [
              _textField(_marketCtrl, 'Market Name'),
              _textField(_stallCtrl, 'Stall Number'),
              _textField(_addressCtrl, 'Address'),
              _textField(_cityCtrl, 'City'),
              Row(
                children: [
                  Expanded(child: _textField(_gpsLatCtrl, 'GPS Latitude')),
                  const SizedBox(width: 8),
                  Expanded(child: _textField(_gpsLngCtrl, 'GPS Longitude')),
                ],
              ),
            ]),
            const SizedBox(height: 16),
            _buildFormSection('Opening Hours', [
              ...List.generate(7, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(width: 80, child: Text(_days[i], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500))),
                      Expanded(
                        child: _closedDays[i]
                            ? Text('Closed', style: GoogleFonts.inter(fontSize: 11, color: AppColors.red))
                            : Text('09:00 AM - 06:00 PM', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                      ),
                      Switch(
                        value: _closedDays[i],
                        activeColor: AppColors.red,
                        onChanged: (v) => setState(() => _closedDays[i] = v),
                      ),
                    ],
                  ),
                );
              }),
            ]),
            const SizedBox(height: 16),
            _buildFormSection('Social Media', [
              _textField(_igCtrl, 'Instagram'),
              _textField(_fbCtrl, 'Facebook'),
              _textField(_twCtrl, 'Twitter'),
            ]),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Save Changes', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 64, height: 48,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Center(child: Icon(icon, size: 24, color: AppColors.textHint)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                Text('Tap to upload image', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
              ],
            ),
          ),
          const Icon(Icons.cloud_upload_outlined, color: AppColors.primary, size: 20),
        ],
      ),
    );
  }

  Widget _buildFormSection(String title, List<Widget> children) {
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
          Row(
            children: [
              Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
              const Spacer(),
              if (title == 'Basic Information')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text('Verified', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.green)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _textField(TextEditingController ctrl, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
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
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        maxLines: 3,
        style: GoogleFonts.inter(fontSize: 13),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint),
          alignLabelWithHint: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontSize: 13)))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          isDense: true,
        ),
      ),
    );
  }
}
