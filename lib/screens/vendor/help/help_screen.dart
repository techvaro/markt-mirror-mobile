import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _ticketCategory = 'Technical';

  final List<FAQ> _allFaqs = [
    FAQ(question: 'How do I add a new product?', answer: 'Go to Products tab and tap the "Add" button. Fill in the product details including name, description, price, and images. Once saved, the product can be published.', category: 'Products'),
    FAQ(question: 'How do I process a refund?', answer: 'Navigate to Orders, find the order, and use the Refund button in the order details. Refunds are processed to the original payment method within 3-5 business days.', category: 'Orders'),
    FAQ(question: 'How do I set up my shop profile?', answer: 'Go to Settings > Shop Profile to update your shop name, description, logo, banner, contact information, business address, and opening hours.', category: 'Account'),
    FAQ(question: 'When do I receive payouts?', answer: 'Payouts are processed every Monday for the previous week\'s completed orders. Funds are sent to your connected bank account within 1-3 business days.', category: 'Payments'),
    FAQ(question: 'How do I create a discount code?', answer: 'Go to Marketing > Discount Codes and tap "Create". You can set the discount type (percentage or fixed amount), usage limits, and validity period.', category: 'Marketing'),
    FAQ(question: 'How do I restock a product?', answer: 'Go to Inventory, find the product, and tap the Restock button (shopping cart icon). Enter the quantity to add and confirm.', category: 'Inventory'),
    FAQ(question: 'How do I contact a customer?', answer: 'You can message customers from the Messages tab or directly from the customer details screen in the Customers tab.', category: 'Orders'),
    FAQ(question: 'How do I cancel an order?', answer: 'Open the order details from the Orders tab and use the "Cancel Order" button. Only orders in "Confirmed" status can be cancelled.', category: 'Orders'),
    FAQ(question: 'How do I change my password?', answer: 'Go to Settings > Security and tap "Change Password". You will need your current password to set a new one.', category: 'Account'),
    FAQ(question: 'How do I manage notifications?', answer: 'Go to Settings > Notifications to toggle email notifications for orders, stock alerts, reviews, and marketing updates.', category: 'Account'),
  ];

  final List<SupportTicket> _tickets = [
    SupportTicket(id: 'st1', subject: 'Payment not received', category: 'Payments', description: 'Payout for last week has not been received.', status: 'open', date: DateTime.now().subtract(const Duration(days: 2))),
    SupportTicket(id: 'st2', subject: 'Product listing issue', category: 'Technical', description: 'Images not loading on product page.', status: 'resolved', date: DateTime.now().subtract(const Duration(days: 7))),
    SupportTicket(id: 'st3', subject: 'Account verification', category: 'Account', description: 'Submitted verification documents 2 weeks ago.', status: 'in_progress', date: DateTime.now().subtract(const Duration(days: 14))),
  ];

  List<FAQ> get _filteredFaqs {
    if (_searchCtrl.text.isEmpty) return _allFaqs;
    final q = _searchCtrl.text.toLowerCase();
    return _allFaqs.where((faq) =>
      faq.question.toLowerCase().contains(q) ||
      faq.answer.toLowerCase().contains(q) ||
      faq.category.toLowerCase().contains(q)
    ).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _subjectCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final faqs = _filteredFaqs;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Help & Support', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
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
                        hintText: 'Search FAQs...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _helpCard('Seller Guide', Icons.menu_book, 'Learn how to sell', AppColors.primary, () {})),
                const SizedBox(width: 10),
                Expanded(child: _helpCard('Platform Policies', Icons.gavel, 'Terms & guidelines', AppColors.purple, () {})),
                const SizedBox(width: 10),
                Expanded(child: _helpCard('Contact Support', Icons.headset_mic, 'Get help', AppColors.teal, () => _showSubmitTicketDialog())),
              ],
            ),
            const SizedBox(height: 20),
            Text('Frequently Asked Questions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            if (faqs.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                child: Center(
                  child: Text('No FAQs match your search', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                ),
              )
            else
              ...faqs.map((faq) => _buildFaqAccordion(faq)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Support Tickets', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                TextButton.icon(
                  onPressed: () => _showSubmitTicketDialog(),
                  icon: const Icon(Icons.add, size: 16),
                  label: Text('New Ticket', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_tickets.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                child: Center(child: Text('No support tickets', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary))),
              )
            else
              ..._tickets.map((t) => _buildTicketCard(t)),
          ],
        ),
      ),
    );
  }

  Widget _helpCard(String title, IconData icon, String subtitle, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 8),
            Text(title, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            Text(subtitle, style: GoogleFonts.inter(fontSize: 9, color: AppColors.textHint), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqAccordion(FAQ faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: ExpansionTile(
        title: Text(faq.question, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        collapsedShape: const RoundedRectangleBorder(),
        shape: const RoundedRectangleBorder(),
        children: [
          Text(faq.answer, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildTicketCard(SupportTicket ticket) {
    String statusLabel;
    Color statusColor;
    switch (ticket.status) {
      case 'open': statusLabel = 'Open'; statusColor = AppColors.warning; break;
      case 'in_progress': statusLabel = 'In Progress'; statusColor = AppColors.info; break;
      case 'resolved': statusLabel = 'Resolved'; statusColor = AppColors.green; break;
      default: statusLabel = ticket.status; statusColor = AppColors.textHint; break;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.support_agent, size: 18, color: statusColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(ticket.subject, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(statusLabel, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w600, color: statusColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(ticket.category, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                    const SizedBox(width: 12),
                    Text('${ticket.date.day}/${ticket.date.month}/${ticket.date.year}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSubmitTicketDialog() {
    _subjectCtrl.clear();
    _descCtrl.clear();
    _ticketCategory = 'Technical';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Submit Ticket', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _subjectCtrl,
                style: GoogleFonts.inter(fontSize: 13),
                decoration: InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _ticketCategory,
                items: ['Technical', 'Payments', 'Account', 'Orders', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontSize: 13)))).toList(),
                onChanged: (v) => _ticketCategory = v!,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descCtrl,
                maxLines: 4,
                style: GoogleFonts.inter(fontSize: 13),
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {});
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
