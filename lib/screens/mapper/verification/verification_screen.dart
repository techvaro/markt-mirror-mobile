import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _vendors = <Vendor>[
    Vendor(id: 'V-001', businessName: 'Tech Emporium', ownerName: 'John Kamau', category: 'Electronics', phone: '+254 723 456 789', email: 'john@techemporium.co.ke', market: 'Central Market', shopNumber: 'C-12', registrationNumber: 'REG-2024-001', taxId: 'TIN-123456', operatingHours: '8:00 AM - 8:00 PM', employeeCount: 5, status: VendorStatus.pending, submissionDate: DateTime.now().subtract(const Duration(days: 2))),
    Vendor(id: 'V-002', businessName: 'Mama Mboga Greens', ownerName: 'Grace Wanjiku', category: 'Fresh Produce', phone: '+254 734 567 890', email: 'grace@greens.co.ke', market: 'Downtown Market', shopNumber: 'D-05', registrationNumber: 'REG-2024-002', taxId: 'TIN-234567', operatingHours: '6:00 AM - 6:00 PM', employeeCount: 2, status: VendorStatus.pending, submissionDate: DateTime.now().subtract(const Duration(days: 1))),
    Vendor(id: 'V-003', businessName: 'Spice Corner', ownerName: 'Ali Hassan', category: 'Spices & Herbs', phone: '+254 745 678 901', email: 'ali@spicecorner.co.ke', market: 'Westside Market', shopNumber: 'W-08', registrationNumber: 'REG-2024-003', taxId: 'TIN-345678', operatingHours: '7:00 AM - 9:00 PM', employeeCount: 3, status: VendorStatus.approved, submissionDate: DateTime.now().subtract(const Duration(days: 5))),
    Vendor(id: 'V-004', businessName: 'Fashion Hub', ownerName: 'Susan Nyambura', category: 'Clothing & Fashion', phone: '+254 756 789 012', email: 'susan@fashionhub.co.ke', market: 'Eastside Market', shopNumber: 'E-03', registrationNumber: 'REG-2024-004', taxId: 'TIN-456789', operatingHours: '9:00 AM - 8:00 PM', employeeCount: 4, status: VendorStatus.rejected, submissionDate: DateTime.now().subtract(const Duration(days: 3)), rejectionNote: 'Blurry photos and incorrect business registration number.'),
    Vendor(id: 'V-005', businessName: 'Hardware Tools Ltd', ownerName: 'Peter Kimani', category: 'Hardware', phone: '+254 767 890 123', email: 'peter@hardwaretools.co.ke', market: 'Central Market', shopNumber: 'C-07', registrationNumber: 'REG-2024-005', taxId: 'TIN-567890', operatingHours: '7:00 AM - 7:00 PM', employeeCount: 6, status: VendorStatus.pending, submissionDate: DateTime.now().subtract(const Duration(days: 1))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Vendor> _filtered(VendorStatus status) => _vendors.where((v) => v.status == status).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Verification', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(VendorStatus.pending, 'pending'),
          _buildList(VendorStatus.approved, 'approved'),
          _buildList(VendorStatus.rejected, 'rejected'),
        ],
      ),
    );
  }

  Widget _buildList(VendorStatus status, String label) {
    final items = _filtered(status);
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: AppColors.textHint),
            const SizedBox(height: 12),
            Text('No $label vendors', style: GoogleFonts.inter(fontSize: 16, color: AppColors.textSecondary)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, i) => _VendorCard(
        vendor: items[i],
        onReview: () => _showReviewDialog(context, items[i]),
      ),
    );
  }

  void _showReviewDialog(BuildContext context, Vendor vendor) {
    final notesCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: Text('Review Vendor', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600))),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const SizedBox(height: 16),
                _detailRow('Business Name', vendor.businessName),
                _detailRow('Owner', vendor.ownerName),
                _detailRow('Phone', vendor.phone),
                _detailRow('Email', vendor.email),
                _detailRow('Category', vendor.category),
                _detailRow('Market', vendor.market),
                _detailRow('Shop Number', vendor.shopNumber),
                _detailRow('Registration No.', vendor.registrationNumber),
                _detailRow('Tax ID', vendor.taxId),
                _detailRow('Operating Hours', vendor.operatingHours),
                _detailRow('Description', vendor.accessibilityNotes.isEmpty ? 'N/A' : vendor.accessibilityNotes),
                _detailRow('Submitted', formatDate(vendor.submissionDate)),
                const SizedBox(height: 16),
                if (vendor.status == VendorStatus.rejected || vendor.status == VendorStatus.pending) ...[
                  TextField(
                    controller: notesCtrl,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Review Notes',
                      hintText: vendor.status == VendorStatus.rejected ? 'Provide reason for rejection...' : 'Add notes...',
                      labelStyle: GoogleFonts.inter(fontSize: 14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (vendor.status == VendorStatus.pending)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Correction requested'), backgroundColor: AppColors.accent));
                            },
                            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                            child: Text('Request Correction', style: GoogleFonts.inter(fontSize: 12)),
                          ),
                        ),
                      if (vendor.status == VendorStatus.pending) const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vendor rejected'), backgroundColor: AppColors.error));
                          },
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error)),
                          child: Text('Reject', style: GoogleFonts.inter(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vendor approved successfully!'), backgroundColor: AppColors.success));
                          },
                          style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), backgroundColor: AppColors.success),
                          child: Text('Approve', style: GoogleFonts.inter(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class _VendorCard extends StatelessWidget {
  final Vendor vendor;
  final VoidCallback onReview;
  const _VendorCard({required this.vendor, required this.onReview});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vendor.businessName, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('${vendor.category} \u2022 ${vendor.ownerName}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text('${vendor.market} \u2022 ${vendor.shopNumber}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: vendorStatusColor(vendor.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(vendorStatusLabel(vendor.status), style: GoogleFonts.inter(fontSize: 11, color: vendorStatusColor(vendor.status), fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text('Submitted: ${formatDate(vendor.submissionDate)}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onReview,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
              child: Text('Review', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
