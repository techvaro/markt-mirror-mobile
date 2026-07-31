import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class RegisterVendorScreen extends StatefulWidget {
  const RegisterVendorScreen({super.key});

  @override
  State<RegisterVendorScreen> createState() => _RegisterVendorScreenState();
}

class _RegisterVendorScreenState extends State<RegisterVendorScreen> {
  final _pageController = PageController();
  int _currentStep = 0;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();

  final _businessNameCtrl = TextEditingController();
  final _ownerNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController(text: '+254 ');
  final _descriptionCtrl = TextEditingController();
  String _category = 'Electronics';
  String _market = 'Central Market';

  double _latitude = -1.2833;
  double _longitude = 36.8167;
  double _accuracy = 3.2;
  bool _gpsAcquired = true;
  final _shopNumberCtrl = TextEditingController();

  final Map<PhotoType, bool> _photosCaptured = {
    PhotoType.front: false,
    PhotoType.inside: false,
    PhotoType.signboard: false,
    PhotoType.products: false,
    PhotoType.license: false,
  };

  final _operatingHoursCtrl = TextEditingController(text: '8:00 AM - 8:00 PM');
  final _employeeCountCtrl = TextEditingController(text: '1');
  final _regNumberCtrl = TextEditingController();
  final _taxIdCtrl = TextEditingController();
  final _accessibilityCtrl = TextEditingController();

  final _categories = ['Electronics', 'Fresh Produce', 'Clothing & Fashion', 'Spices & Herbs', 'Hardware', 'Food & Beverages', 'Crafts', 'Books & Stationery', 'Pharmacy', 'Other'];
  final _markets = ['Central Market', 'Downtown Market', 'Westside Market', 'Eastside Market', 'North Market', 'South Market'];

  final _stepLabels = ['Business Info', 'Location', 'Photos', 'Details', 'Review'];

  @override
  void dispose() {
    _pageController.dispose();
    _businessNameCtrl.dispose();
    _ownerNameCtrl.dispose();
    _phoneCtrl.dispose();
    _descriptionCtrl.dispose();
    _shopNumberCtrl.dispose();
    _operatingHoursCtrl.dispose();
    _employeeCountCtrl.dispose();
    _regNumberCtrl.dispose();
    _taxIdCtrl.dispose();
    _accessibilityCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0 && !(_formKey1.currentState?.validate() ?? false)) return;
    if (_currentStep == 1 && !(_formKey2.currentState?.validate() ?? false)) return;
    if (_currentStep == 3 && !(_formKey4.currentState?.validate() ?? false)) return;
    if (_currentStep < 4) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() => _currentStep--);
    }
  }

  void _simulateGps() {
    final rng = Random();
    setState(() {
      _latitude = -1.2833 + rng.nextDouble() * 0.01;
      _longitude = 36.8167 + rng.nextDouble() * 0.01;
      _accuracy = 1.5 + rng.nextDouble() * 4;
      _gpsAcquired = true;
    });
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Draft saved at step ${_currentStep + 1}'), backgroundColor: AppColors.accent),
    );
  }

  void _submitRegistration() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vendor registration submitted successfully!'), backgroundColor: AppColors.success),
    );
    Navigator.pop(context);
  }

  void _capturePhoto(PhotoType type) {
    setState(() => _photosCaptured[type] = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${type.name} photo captured'), backgroundColor: AppColors.success),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Register Vendor', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          TextButton(
            onPressed: _saveDraft,
            child: Text('Save Draft', style: GoogleFonts.inter(color: AppColors.primary, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      body: Column(
        children: [
          _StepProgressIndicator(currentStep: _currentStep, labels: _stepLabels),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (i) => setState(() => _currentStep = i),
              children: [
                _BusinessInfoStep(
                  formKey: _formKey1,
                  businessNameCtrl: _businessNameCtrl,
                  ownerNameCtrl: _ownerNameCtrl,
                  phoneCtrl: _phoneCtrl,
                  descriptionCtrl: _descriptionCtrl,
                  category: _category,
                  market: _market,
                  categories: _categories,
                  markets: _markets,
                  onCategoryChanged: (v) => setState(() => _category = v),
                  onMarketChanged: (v) => setState(() => _market = v),
                ),
                _LocationStep(
                  formKey: _formKey2,
                  latitude: _latitude,
                  longitude: _longitude,
                  accuracy: _accuracy,
                  gpsAcquired: _gpsAcquired,
                  shopNumberCtrl: _shopNumberCtrl,
                  onSimulateGps: _simulateGps,
                ),
                _PhotosStep(
                  photosCaptured: _photosCaptured,
                  onCapture: _capturePhoto,
                ),
                _DetailsStep(
                  formKey: _formKey4,
                  operatingHoursCtrl: _operatingHoursCtrl,
                  employeeCountCtrl: _employeeCountCtrl,
                  regNumberCtrl: _regNumberCtrl,
                  taxIdCtrl: _taxIdCtrl,
                  accessibilityCtrl: _accessibilityCtrl,
                ),
                _ReviewStep(
                  businessName: _businessNameCtrl.text,
                  ownerName: _ownerNameCtrl.text,
                  phone: _phoneCtrl.text,
                  category: _category,
                  market: _market,
                  description: _descriptionCtrl.text,
                  latitude: _latitude,
                  longitude: _longitude,
                  accuracy: _accuracy,
                  shopNumber: _shopNumberCtrl.text,
                  photosCaptured: _photosCaptured,
                  operatingHours: _operatingHoursCtrl.text,
                  employeeCount: _employeeCountCtrl.text,
                  regNumber: _regNumberCtrl.text,
                  taxId: _taxIdCtrl.text,
                  accessibility: _accessibilityCtrl.text,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNav(currentStep: _currentStep, onPrev: _prevStep, onNext: _nextStep, onSubmit: _submitRegistration),
    );
  }
}

class _StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> labels;
  const _StepProgressIndicator({required this.currentStep, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      color: AppColors.surface,
      child: Column(
        children: [
          Row(
            children: List.generate(labels.length, (i) {
              final isActive = i <= currentStep;
              final isLast = i == labels.length - 1;
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primary : AppColors.border,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text('${i + 1}', style: GoogleFonts.inter(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: i < currentStep ? AppColors.primary : AppColors.border,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 4),
          Text(labels[currentStep], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _BusinessInfoStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController businessNameCtrl, ownerNameCtrl, phoneCtrl, descriptionCtrl;
  final String category, market;
  final List<String> categories, markets;
  final ValueChanged<String> onCategoryChanged, onMarketChanged;

  const _BusinessInfoStep({
    required this.formKey,
    required this.businessNameCtrl,
    required this.ownerNameCtrl,
    required this.phoneCtrl,
    required this.descriptionCtrl,
    required this.category,
    required this.market,
    required this.categories,
    required this.markets,
    required this.onCategoryChanged,
    required this.onMarketChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 1: Business Information', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildField('Business Name', businessNameCtrl, required: true),
            const SizedBox(height: 12),
            _buildField('Owner Name', ownerNameCtrl, required: true),
            const SizedBox(height: 12),
            _buildField('Phone Number', phoneCtrl, keyboardType: TextInputType.phone, required: true),
            const SizedBox(height: 12),
            _buildDropdown('Category', category, categories, onCategoryChanged),
            const SizedBox(height: 12),
            _buildDropdown('Market', market, markets, onMarketChanged),
            const SizedBox(height: 12),
            _buildField('Description', descriptionCtrl, maxLines: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, {bool required = false, int maxLines = 1, TextInputType? keyboardType}) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: required ? (v) => (v == null || v.trim().isEmpty) ? '$label is required' : null : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      style: GoogleFonts.inter(fontSize: 14),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontSize: 14)))).toList(),
      onChanged: (v) { if (v != null) onChanged(v); },
      style: GoogleFonts.inter(fontSize: 14),
    );
  }
}

class _LocationStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final double latitude, longitude, accuracy;
  final bool gpsAcquired;
  final TextEditingController shopNumberCtrl;
  final VoidCallback onSimulateGps;

  const _LocationStep({
    required this.formKey,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.gpsAcquired,
    required this.shopNumberCtrl,
    required this.onSimulateGps,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 2: Location', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(size: const Size(double.infinity, double.infinity), painter: _MockMapPainter()),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.my_location, size: 40, color: gpsAcquired ? AppColors.primary : AppColors.textHint),
                      const SizedBox(height: 4),
                      if (gpsAcquired)
                        Text('${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600))
                      else
                        Text('GPS not acquired', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: FloatingActionButton.small(
                      heroTag: 'locate',
                      onPressed: onSimulateGps,
                      backgroundColor: AppColors.primary,
                      child: const Icon(Icons.gps_fixed, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AbsorbPointer(
                    child: _buildField('Latitude', TextEditingController(text: latitude.toStringAsFixed(4))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AbsorbPointer(
                    child: _buildField('Longitude', TextEditingController(text: longitude.toStringAsFixed(4))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (gpsAcquired)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.gps_off, size: 16, color: AppColors.success),
                    const SizedBox(width: 6),
                    Text('Accuracy: ${accuracy.toStringAsFixed(1)}m', style: GoogleFonts.inter(fontSize: 12, color: AppColors.success, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            _buildField('Shop Number', shopNumberCtrl, required: true),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, {bool required = false}) {
    return TextFormField(
      controller: ctrl,
      validator: required ? (v) => (v == null || v.trim().isEmpty) ? '$label is required' : null : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      style: GoogleFonts.inter(fontSize: 14),
    );
  }
}

class _MockMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()..color = AppColors.mapGrid..strokeWidth = 1;
    final roadPaint = Paint()..color = AppColors.mapRoad..strokeWidth = 3;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _PhotosStep extends StatelessWidget {
  final Map<PhotoType, bool> photosCaptured;
  final void Function(PhotoType) onCapture;

  const _PhotosStep({required this.photosCaptured, required this.onCapture});

  @override
  Widget build(BuildContext context) {
    final types = PhotoType.values;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Step 3: Photos', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Capture photos for each category', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1),
            itemCount: types.length,
            itemBuilder: (_, i) {
              final type = types[i];
              final captured = photosCaptured[type] ?? false;
              return Container(
                decoration: BoxDecoration(
                  color: captured ? AppColors.successLight : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: captured ? AppColors.success : AppColors.border),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      captured ? Icons.check_circle : Icons.camera_alt_outlined,
                      size: 40,
                      color: captured ? AppColors.success : AppColors.textHint,
                    ),
                    const SizedBox(height: 8),
                    Text(_photoTypeLabel(type), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(captured ? 'Captured' : 'Not captured', style: GoogleFonts.inter(fontSize: 11, color: captured ? AppColors.success : AppColors.textSecondary)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.camera_alt, size: 18),
                          onPressed: () => onCapture(type),
                          color: AppColors.primary,
                          tooltip: 'Capture',
                        ),
                        IconButton(
                          icon: const Icon(Icons.upload_file, size: 18),
                          onPressed: () => onCapture(type),
                          color: AppColors.textSecondary,
                          tooltip: 'Upload',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _photoTypeLabel(PhotoType type) {
    switch (type) {
      case PhotoType.front: return 'Front View';
      case PhotoType.inside: return 'Inside Shop';
      case PhotoType.signboard: return 'Signboard';
      case PhotoType.products: return 'Products';
      case PhotoType.license: return 'License';
    }
  }
}

class _DetailsStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController operatingHoursCtrl, employeeCountCtrl, regNumberCtrl, taxIdCtrl, accessibilityCtrl;

  const _DetailsStep({
    required this.formKey,
    required this.operatingHoursCtrl,
    required this.employeeCountCtrl,
    required this.regNumberCtrl,
    required this.taxIdCtrl,
    required this.accessibilityCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 4: Additional Details', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildField('Operating Hours', operatingHoursCtrl, required: true),
            const SizedBox(height: 12),
            _buildField('Employee Count', employeeCountCtrl, keyboardType: TextInputType.number, required: true),
            const SizedBox(height: 12),
            _buildField('Registration Number', regNumberCtrl),
            const SizedBox(height: 12),
            _buildField('Tax ID', taxIdCtrl),
            const SizedBox(height: 12),
            _buildField('Accessibility Notes', accessibilityCtrl, maxLines: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, {bool required = false, int maxLines = 1, TextInputType? keyboardType}) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: required ? (v) => (v == null || v.trim().isEmpty) ? '$label is required' : null : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      style: GoogleFonts.inter(fontSize: 14),
    );
  }
}

class _ReviewStep extends StatelessWidget {
  final String businessName, ownerName, phone, category, market, description;
  final double latitude, longitude, accuracy;
  final String shopNumber;
  final Map<PhotoType, bool> photosCaptured;
  final String operatingHours, employeeCount, regNumber, taxId, accessibility;

  const _ReviewStep({
    required this.businessName,
    required this.ownerName,
    required this.phone,
    required this.category,
    required this.market,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.shopNumber,
    required this.photosCaptured,
    required this.operatingHours,
    required this.employeeCount,
    required this.regNumber,
    required this.taxId,
    required this.accessibility,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 24),
              const SizedBox(width: 8),
              Text('Step 5: Review & Submit', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Please review all information before submitting', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          _buildSection('Business Information', [
            _reviewItem('Business Name', businessName),
            _reviewItem('Owner Name', ownerName),
            _reviewItem('Phone', phone),
            _reviewItem('Category', category),
            _reviewItem('Market', market),
            if (description.isNotEmpty) _reviewItem('Description', description),
          ]),
          const SizedBox(height: 12),
          _buildSection('Location', [
            _reviewItem('Coordinates', '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}'),
            _reviewItem('Accuracy', '${accuracy.toStringAsFixed(1)}m'),
            if (shopNumber.isNotEmpty) _reviewItem('Shop Number', shopNumber),
          ]),
          const SizedBox(height: 12),
          _buildSection('Photos', [
            ...PhotoType.values.map((t) => _reviewItem(_photoLabel(t), photosCaptured[t] == true ? 'Captured' : 'Missing')),
          ]),
          const SizedBox(height: 12),
          _buildSection('Additional Details', [
            _reviewItem('Operating Hours', operatingHours),
            _reviewItem('Employees', employeeCount),
            if (regNumber.isNotEmpty) _reviewItem('Registration No.', regNumber),
            if (taxId.isNotEmpty) _reviewItem('Tax ID', taxId),
            if (accessibility.isNotEmpty) _reviewItem('Accessibility', accessibility),
          ]),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...items,
        ],
      ),
    );
  }

  Widget _reviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  String _photoLabel(PhotoType t) {
    switch (t) {
      case PhotoType.front: return 'Front View';
      case PhotoType.inside: return 'Inside Shop';
      case PhotoType.signboard: return 'Signboard';
      case PhotoType.products: return 'Products';
      case PhotoType.license: return 'License';
    }
  }
}

class _BottomNav extends StatelessWidget {
  final int currentStep;
  final VoidCallback onPrev, onNext, onSubmit;

  const _BottomNav({required this.currentStep, required this.onPrev, required this.onNext, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: onPrev,
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: Text('Previous', style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                ),
              ),
            if (currentStep > 0) const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: currentStep == 4 ? onSubmit : onNext,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: currentStep == 4 ? AppColors.success : null,
                ),
                child: Text(
                  currentStep == 4 ? 'Submit Registration' : 'Next',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
