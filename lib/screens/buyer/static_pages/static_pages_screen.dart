import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

final List<String> _pages = ['Help', 'Returns', 'About', 'Terms', 'Privacy'];

class StaticPagesScreen extends StatefulWidget {
  final String? initialPage;
  const StaticPagesScreen({super.key, this.initialPage});

  @override
  State<StaticPagesScreen> createState() => _StaticPagesScreenState();
}

class _StaticPagesScreenState extends State<StaticPagesScreen> {
  String _selectedPage = 'Help';

  @override
  void initState() {
    super.initState();
    if (widget.initialPage != null && _pages.contains(widget.initialPage)) {
      _selectedPage = widget.initialPage!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(_selectedPage, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _pages.map((page) {
                  final isSelected = page == _selectedPage;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(page, style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textSecondary)),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedPage = page),
                      selectedColor: AppColors.primary,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedPage) {
      case 'Help':
        return _HelpContent();
      case 'Returns':
        return _ReturnsContent();
      case 'About':
        return _AboutContent();
      case 'Terms':
        return _TermsContent();
      case 'Privacy':
        return _PrivacyContent();
      default:
        return const SizedBox();
    }
  }
}

class _HelpContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final faqs = [
      {'q': 'How do I place an order?', 'a': 'Browse products, add items to your cart, and proceed to checkout. Fill in your delivery address and choose a payment method to complete your order.'},
      {'q': 'How long does delivery take?', 'a': 'Delivery typically takes 1-3 business days for Lagos and major cities, and 3-7 business days for other locations across Nigeria.'},
      {'q': 'What payment methods are accepted?', 'a': 'We accept Paystack (debit/credit cards), Bank Transfer, and Cash on Delivery for eligible orders.'},
      {'q': 'Can I cancel my order?', 'a': 'Yes, you can cancel an order before it is shipped. Go to your Orders page, select the order, and click Cancel.'},
      {'q': 'How do I return an item?', 'a': 'If you receive a damaged or incorrect item, open a dispute within 48 hours of delivery. Our team will guide you through the return process.'},
      {'q': 'What is escrow protection?', 'a': 'Your payment is held securely by Market Mirror until you confirm delivery. This protects both buyers and sellers during transactions.'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(faqs[i]['q']!, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 6),
              Text(faqs[i]['a']!, style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
            ],
          ),
        );
      },
    );
  }
}

class _ReturnsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Return Policy', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            _section('Eligibility', 'Items must be returned within 7 days of delivery. Products must be unused, in original packaging, and with all accessories intact.'),
            _section('Non-Returnable Items', 'Perishable goods, intimate apparel, custom-made products, and digital downloads cannot be returned.'),
            _section('Condition Requirements', 'All returned items are inspected. Items showing signs of use, damage, or missing components may be rejected or subject to a restocking fee.'),
            _section('Refund Process', 'Once we receive and inspect your return, refunds are processed within 5-7 business days. Refunds are issued to the original payment method.'),
            _section('Return Shipping', 'Return shipping costs are covered by Market Mirror for defective or incorrect items. For other returns, the buyer is responsible for return shipping.'),
            _section('Refund Timeline', 'Bank transfers: 3-5 business days. Card payments: 5-10 business days. Cash on Delivery: Refunded via bank transfer within 5 business days.'),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(body, style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About Market Mirror', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            Text(
              'Market Mirror is Nigeria\'s premier marketplace connecting buyers directly with verified vendors in physical markets across the country.',
              style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
            ),
            const SizedBox(height: 16),
            Text(
              'Our platform bridges the gap between traditional market shopping and modern e-commerce. We partner with trusted shops in major markets like Computer Village, Ikeja, to bring you quality products at competitive prices, with Alaba International Market joining soon.',
              style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
            ),
            const SizedBox(height: 16),
            Text('Our Mission', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text(
              'To digitize African marketplaces and make them accessible to everyone, while preserving the trust and personal touch that make market shopping unique.',
              style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
            ),
            const SizedBox(height: 16),
            Text('Why Choose Us', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            _bullet('Verified vendors with physical shop locations'),
            _bullet('Escrow payment protection on all transactions'),
            _bullet('Direct delivery from market to your doorstep'),
            _bullet('24/7 customer support'),
            _bullet('Real-time order tracking'),
            _bullet('Hassle-free returns within 7 days'),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 16, color: AppColors.success),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary))),
        ],
      ),
    );
  }
}

class _TermsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terms of Service', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            _section('Acceptance of Terms', 'By using Market Mirror, you agree to these terms. If you do not agree, please do not use our platform. We reserve the right to update these terms at any time.'),
            _section('User Accounts', 'You are responsible for maintaining the confidentiality of your account credentials. All activities under your account are your responsibility.'),
            _section('Transactions', 'All transactions are final upon delivery confirmation. Market Mirror acts as an intermediary and escrow agent for transactions between buyers and vendors.'),
            _section('Prohibited Conduct', 'Users may not engage in fraudulent activities, misuse the platform, violate any laws, or harass other users. Violations may result in account suspension.'),
            _section('Limitation of Liability', 'Market Mirror is not liable for any indirect, incidental, or consequential damages arising from the use of our platform. Our maximum liability is limited to the transaction amount.'),
            _section('Dispute Resolution', 'Disputes are resolved through our internal mediation process. If a resolution cannot be reached, the matter will be referred to arbitration in accordance with Nigerian law.'),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(body, style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }
}

class _PrivacyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Privacy Policy', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            _section('Information We Collect', 'We collect personal information you provide (name, email, phone, address), transaction data, and device information to improve our service.'),
            _section('How We Use Your Information', 'Your information is used to process transactions, provide customer support, improve our platform, and send relevant notifications about your orders.'),
            _section('Data Protection', 'We implement industry-standard security measures including encryption, secure servers, and access controls to protect your personal data.'),
            _section('Information Sharing', 'We do not sell your personal information. Data is shared only with vendors necessary to fulfill your order, or as required by law.'),
            _section('Your Rights', 'You have the right to access, correct, or delete your personal data. You can manage notification preferences in your account settings.'),
            _section('Contact', 'For privacy-related inquiries, contact us at privacy@marketmirror.com or through our Help Center.'),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(body, style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }
}
