import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _searchCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  String _ticketCategory = 'Technical Issue';

  final _categories = ['Technical Issue', 'Account Issue', 'Billing', 'Feature Request', 'Other'];

  final _guides = [
    _GuideItem(icon: Icons.store, title: 'How to Register a Vendor', category: 'Getting Started'),
    _GuideItem(icon: Icons.map, title: 'Mapping Shop Locations', category: 'Mapping'),
    _GuideItem(icon: Icons.camera_alt, title: 'Capturing Vendor Photos', category: 'Media'),
    _GuideItem(icon: Icons.sync, title: 'Using Offline Mode', category: 'Connectivity'),
    _GuideItem(icon: Icons.description, title: 'Understanding Reports', category: 'Reports'),
    _GuideItem(icon: Icons.rate_review, title: 'Verification Process', category: 'Verification'),
  ];

  final _faqs = [
    _FaqItem(question: 'How do I register a new vendor?', answer: 'Go to the Register tab and fill in the multi-step form. You need to provide business info, location, photos, and additional details.'),
    _FaqItem(question: 'What happens when I\'m offline?', answer: 'Your data is saved locally and will sync automatically when you reconnect to the internet.'),
    _FaqItem(question: 'How is my performance measured?', answer: 'Your performance score is based on the number of completed tasks, approval rate, and timeliness of submissions.'),
    _FaqItem(question: 'How do I correct a rejected submission?', answer: 'Go to the task details, review the rejection reason, make the required corrections, and resubmit for review.'),
    _FaqItem(question: 'Can I edit vendor info after submission?', answer: 'Yes, you can edit vendor information before it is approved. Once approved, changes require admin intervention.'),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    _subjectCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredGuides = _searchCtrl.text.isEmpty
        ? _guides
        : _guides.where((g) =>
            g.title.toLowerCase().contains(_searchCtrl.text.toLowerCase()) ||
            g.category.toLowerCase().contains(_searchCtrl.text.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Help Center', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('How can we help you?', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Search guides...',
                      hintStyle: GoogleFonts.inter(color: Colors.white60),
                      prefixIcon: const Icon(Icons.search, color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Guides & Resources', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...filteredGuides.map((g) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(8)),
                        child: Icon(g.icon, color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(g.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
                            Text(g.category, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.textHint),
                    ],
                  ),
                )),
            if (filteredGuides.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: AppColors.textHint),
                    const SizedBox(height: 8),
                    Text('No guides found', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Text('Frequently Asked Questions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ..._faqs.map((faq) => _FaqCard(faq: faq)),
            const SizedBox(height: 20),
            Text('Contact Support', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  _contactRow(Icons.phone, 'Call Dispatch', '+254 712 345 678', '+254 712 345 678', AppColors.success),
                  const Divider(height: 20),
                  _contactRow(Icons.chat, 'Live Chat', 'Available 8 AM - 6 PM Mon-Sat', null, AppColors.primary),
                  const Divider(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.confirmation_number, color: AppColors.accent),
                    ),
                    title: Text('Submit a Ticket', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
                    subtitle: Text('Get help from our support team', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showTicketDialog(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _contactRow(IconData icon, String title, String value, String? phone, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
              Text(value, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
        if (phone != null)
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Calling $phone...')),
            ),
            child: Text('Call', style: GoogleFonts.inter(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }

  void _showTicketDialog(BuildContext context) {
    _subjectCtrl.clear();
    _descriptionCtrl.clear();
    _ticketCategory = 'Technical Issue';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Submit a Ticket', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _subjectCtrl,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  style: GoogleFonts.inter(fontSize: 14),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _ticketCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontSize: 14)))).toList(),
                  onChanged: (v) { if (v != null) _ticketCategory = v; },
                  style: GoogleFonts.inter(fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descriptionCtrl,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  style: GoogleFonts.inter(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.inter()),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ticket submitted successfully!'), backgroundColor: AppColors.success),
              );
            },
            child: Text('Submit', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _GuideItem {
  final IconData icon;
  final String title, category;
  _GuideItem({required this.icon, required this.title, required this.category});
}

class _FaqItem {
  final String question, answer;
  _FaqItem({required this.question, required this.answer});
}

class _FaqCard extends StatefulWidget {
  final _FaqItem faq;
  const _FaqCard({required this.faq});

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.faq.question, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
            trailing: AnimatedRotation(
              turns: _expanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.expand_more, color: AppColors.textSecondary),
            ),
            onTap: () => setState(() => _expanded = !_expanded),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(widget.faq.answer, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
            ),
            crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
