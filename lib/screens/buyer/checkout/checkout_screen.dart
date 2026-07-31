import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

final List<Map<String, String>> _nigerianStates = [
  {'name': 'Lagos', 'cities': 'Ikeja,Lekki,Surulere,Victoria Island,Ajah,Yaba,Mainland,Ikorodu,Badagry,Epe'},
  {'name': 'FCT', 'cities': 'Abuja,Garki,Wuse,Maitama,Kuje,Gwagwalada,Kubwa,Bwari,Karu'},
  {'name': 'Rivers', 'cities': 'Port Harcourt,Obio-Akpor,Eleme,Okrika,Etche,Ahoada,Omoku,Bonny'},
  {'name': 'Oyo', 'cities': 'Ibadan,Ogbomoso,Oyo,Iseyin,Saki,Okeho,Kisi,Igbo-Ora'},
  {'name': 'Kaduna', 'cities': 'Kaduna,Zaria,Kafanchan,Saminaka,Birnin Gwari,Giwa,Ikara'},
  {'name': 'Kano', 'cities': 'Kano,Wudil,Rano,Gwarzo,Karaye,Sumaila,Bichi,Minjibir'},
  {'name': 'Enugu', 'cities': 'Enugu,Nsukka,Nkanu,Oji River,Udi,Ezeagu,Igbo-Eze'},
  {'name': 'Delta', 'cities': 'Warri,Asaba,Sapele,Ughelli,Agbor,Oleh,Burutu,Kwale'},
  {'name': 'Ogun', 'cities': 'Abeokuta,Ijebu Ode,Ota,Sagamu,Ilaro,Ayetoro,Owode,Ifo'},
  {'name': 'Anambra', 'cities': 'Awka,Onitsha,Nnewi,Ekwulobia,Ihiala,Aguata,Otuocha'},
  {'name': 'Edo', 'cities': 'Benin City,Uromi,Irrua,Igueben,Ekpoma,Auchi,Okpella,Igarra'},
  {'name': 'Plateau', 'cities': 'Jos,Pankshin,Shendam,Bokkos,Langtang,Kanke,Barakin Ladi'},
  {'name': 'Kwara', 'cities': 'Ilorin,Offa,Kaiama,Patigi,Jebba,Share,Osi,Lafiagi'},
  {'name': 'Borno', 'cities': 'Maiduguri,Biu,Bama,Monguno,Dikwa,Askira/Uba,Gwoza,Konduga'},
  {'name': 'Bauchi', 'cities': 'Bauchi,Jama\'are,Katagum,Alkaleri,Misau,Darazo,Ningi,Ganjuwa'},
];

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  const CheckoutScreen({super.key, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  String _deliveryMethod = 'Home Delivery';
  String _paymentMethod = 'Paystack';

  final _firstNameCtrl = TextEditingController(text: 'Chidi');
  final _lastNameCtrl = TextEditingController(text: 'Okeke');
  final _phoneCtrl = TextEditingController(text: '+234 802 222 3333');
  final _streetCtrl = TextEditingController(text: '42 Awolowo Road, Ikoyi');
  String _selectedState = 'Lagos';
  String _selectedCity = 'Ikeja';

  List<String> get _citiesForSelectedState {
    final state = _nigerianStates.firstWhere((s) => s['name'] == _selectedState, orElse: () => {'name': 'Lagos', 'cities': 'Ikeja'});
    return (state['cities'] ?? '').split(',');
  }

  double get _subtotal => widget.cartItems.fold(0.0, (s, i) => s + i.totalPrice);
  double get _deliveryFee => _deliveryMethod == 'Home Delivery' ? 1500.0 : 0.0;
  double get _total => _subtotal + _deliveryFee;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _streetCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Checkout', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                _stepIndicator('Delivery', 0),
                Expanded(child: Container(height: 2, color: _currentStep >= 1 ? AppColors.primary : AppColors.border)),
                _stepIndicator('Payment', 1),
                Expanded(child: Container(height: 2, color: _currentStep >= 2 ? AppColors.primary : AppColors.border)),
                _stepIndicator('Confirm', 2),
              ],
            ),
          ),
          Expanded(
            child: _currentStep == 0 ? _buildDeliveryStep() : _currentStep == 1 ? _buildPaymentStep() : _buildConfirmStep(),
          ),
        ],
      ),
    );
  }

  Widget _stepIndicator(String label, int index) {
    final active = _currentStep >= index;
    final done = _currentStep > index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(shape: BoxShape.circle, color: active ? AppColors.primary : AppColors.border),
          child: Center(child: done ? const Icon(Icons.check, size: 18, color: Colors.white) : Text('${index + 1}', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: active ? Colors.white : AppColors.textHint))),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.sourceSans3(fontSize: 10, color: active ? AppColors.primary : AppColors.textHint)),
      ],
    );
  }

  Widget _buildDeliveryStep() {
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
                Text('Delivery Method', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 10),
                _deliveryOption('Home Delivery', '₦1,500', Icons.local_shipping),
                const SizedBox(height: 8),
                _deliveryOption('Alaba Pickup', 'Free', Icons.store),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Delivery Address', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _textField('First Name', _firstNameCtrl)),
                    const SizedBox(width: 10),
                    Expanded(child: _textField('Last Name', _lastNameCtrl)),
                  ],
                ),
                const SizedBox(height: 10),
                _textField('Phone Number', _phoneCtrl),
                const SizedBox(height: 10),
                _textField('Street Address', _streetCtrl, maxLines: 2),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _dropdown('State', _selectedState, _nigerianStates.map((s) => s['name']!).toList(), (v) => setState(() { _selectedState = v!; _selectedCity = _citiesForSelectedState.first; }))),
                    const SizedBox(width: 10),
                    Expanded(child: _dropdown('City/LGA', _selectedCity, _citiesForSelectedState, (v) => setState(() => _selectedCity = v!))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, height: 50,
            child: ElevatedButton(
              onPressed: () => setState(() => _currentStep = 1),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
              child: Text('Continue to Payment', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deliveryOption(String title, String price, IconData icon) {
    final selected = _deliveryMethod == title;
    return GestureDetector(
      onTap: () => setState(() => _deliveryMethod = title),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: selected ? AppColors.primary : AppColors.textHint),
            const SizedBox(width: 10),
            Expanded(child: Text(title, style: GoogleFonts.sourceSans3(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
            Text(price, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: selected ? AppColors.primary : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStep() {
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
                Text('Payment Method', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 10),
                _paymentOption('Paystack', Icons.credit_card, 'Pay with debit/credit card'),
                const SizedBox(height: 8),
                _paymentOption('Bank Transfer', Icons.account_balance, 'Transfer to our bank account'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.success.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.success.withOpacity(0.3))),
            child: Row(
              children: [
                const Icon(Icons.security, color: AppColors.success, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Escrow Protection', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.success)),
                      Text('Your payment is held securely until you confirm delivery.', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, height: 50,
            child: ElevatedButton(
              onPressed: () => setState(() => _currentStep = 2),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
              child: Text('Review Order', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption(String title, IconData icon, String subtitle) {
    final selected = _paymentMethod == title;
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = title),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: selected ? AppColors.primary : AppColors.textHint),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.sourceSans3(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text(subtitle, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Container(
              width: 20, height: 20,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: selected ? AppColors.primary : AppColors.border)),
              child: selected ? Center(child: Container(width: 12, height: 12, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary))) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmStep() {
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
                Text('Order Summary', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 10),
                ...widget.cartItems.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.shopping_bag, size: 18, color: AppColors.primary)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.product.name, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text('x${item.quantity} ₦${item.product.price.toStringAsFixed(0)}', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      Text('₦${item.totalPrice.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    ],
                  ),
                )),
                const Divider(height: 16),
                _sumRow('Subtotal', _subtotal),
                _sumRow('Delivery Fee', _deliveryFee),
                const Divider(height: 8),
                _sumRow('Total', _total, isBold: true),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Delivery Address', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('${_firstNameCtrl.text} ${_lastNameCtrl.text}', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textPrimary)),
                Text(_phoneCtrl.text, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                Text('${_streetCtrl.text}, $_selectedCity, $_selectedState', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
            child: Row(
              children: [
                const Icon(Icons.verified, color: AppColors.success, size: 20),
                const SizedBox(width: 8),
                Text('Pay with $_paymentMethod', style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const Spacer(),
                Text('₦${_total.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.accent)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, height: 50,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Text('Order Placed!', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
                    content: Text('Your order has been placed successfully. You\'ll receive a confirmation shortly.', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary)),
                    actions: [
                      ElevatedButton(
                        onPressed: () { Navigator.pop(ctx); Navigator.pop(context); },
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0),
                        child: Text('OK', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
              child: Text('Pay ₦${_total.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sumRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.sourceSans3(fontSize: isBold ? 15 : 13, fontWeight: isBold ? FontWeight.w600 : FontWeight.normal, color: AppColors.textSecondary)),
          Text('₦${amount.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: isBold ? 16 : 13, fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _textField(String label, TextEditingController ctrl, {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: GoogleFonts.sourceSans3(fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: AppColors.background,
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      isDense: true,
      style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: AppColors.background,
      ),
      items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: GoogleFonts.sourceSans3(fontSize: 13)))).toList(),
      onChanged: onChanged,
    );
  }
}
