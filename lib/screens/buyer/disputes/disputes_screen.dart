import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

final List<Dispute> _disputes = [
  Dispute(id: 'disp_1', orderId: 'MM-2026-005', reason: 'Cancellation not processed', description: 'I cancelled my order but the refund hasn\'t been processed yet.', status: 'open', createdAt: DateTime(2026, 7, 22)),
  Dispute(id: 'disp_2', orderId: 'MM-2026-001', reason: 'Damaged item', description: 'The PS5 box was slightly damaged upon delivery but the console works fine.', status: 'resolved', createdAt: DateTime(2026, 7, 28)),
];

final List<String> _orderNumbers = ['MM-2026-001', 'MM-2026-002', 'MM-2026-003', 'MM-2026-004', 'MM-2026-005'];
final List<String> _disputeReasons = ['Damaged Item', 'Wrong Item Received', 'Item Not Received', 'Seller Unresponsive', 'Cancellation not processed', 'Refund not issued', 'Quality not as described', 'Other'];

class DisputesScreen extends StatefulWidget {
  const DisputesScreen({super.key});

  @override
  State<DisputesScreen> createState() => _DisputesScreenState();
}

class _DisputesScreenState extends State<DisputesScreen> {
  void _showOpenDisputeDialog() {
    String selectedOrder = _orderNumbers.first;
    String selectedReason = _disputeReasons.first;
    final descriptionCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Open Dispute', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order', style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: selectedOrder,
                isDense: true,
                style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textPrimary),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                items: _orderNumbers.map((o) => DropdownMenuItem(value: o, child: Text(o, style: GoogleFonts.sourceSans3(fontSize: 13)))).toList(),
                onChanged: (v) => selectedOrder = v!,
              ),
              const SizedBox(height: 12),
              Text('Reason', style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: selectedReason,
                isDense: true,
                style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textPrimary),
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                items: _disputeReasons.map((r) => DropdownMenuItem(value: r, child: Text(r, style: GoogleFonts.sourceSans3(fontSize: 13)))).toList(),
                onChanged: (v) => selectedReason = v!,
              ),
              const SizedBox(height: 12),
              Text('Description', style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              TextField(
                controller: descriptionCtrl,
                maxLines: 4,
                style: GoogleFonts.sourceSans3(fontSize: 13),
                decoration: InputDecoration(hintText: 'Describe your issue...', hintStyle: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textHint), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)), contentPadding: const EdgeInsets.all(12)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: GoogleFonts.sourceSans3(color: AppColors.textSecondary))),
          ElevatedButton(
            onPressed: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dispute opened successfully', style: GoogleFonts.sourceSans3(fontSize: 13)), backgroundColor: AppColors.success)); },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0),
            child: Text('Submit', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Disputes', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
        actions: [
          TextButton.icon(
            onPressed: _showOpenDisputeDialog,
            icon: const Icon(Icons.add, size: 18),
            label: Text('Open Dispute', style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600)),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ],
      ),
      body: _disputes.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified_user_outlined, size: 80, color: AppColors.textHint.withOpacity(0.4)),
                const SizedBox(height: 16),
                Text('No disputes', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text('All your disputes will appear here', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary)),
              ],
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _disputes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final d = _disputes[i];
              Color statusColor;
              String statusLabel;
              switch (d.status) {
                case 'open':
                  statusColor = AppColors.warning;
                  statusLabel = 'Under Review';
                  break;
                case 'resolved':
                  statusColor = AppColors.green;
                  statusLabel = 'Resolved';
                  break;
                default:
                  statusColor = AppColors.textHint;
                  statusLabel = 'Closed';
              }
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order ${d.orderId}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: statusColor.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                          child: Text(statusLabel, style: GoogleFonts.sourceSans3(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(d.reason, style: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(d.description, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Text('${d.createdAt.day}/${d.createdAt.month}/${d.createdAt.year}', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textHint)),
                  ],
                ),
              );
            },
          ),
    );
  }
}
