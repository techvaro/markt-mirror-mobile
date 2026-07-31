import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

class _PayoutItem {
  final String id;
  final DateTime date;
  final String reference;
  final String bank;
  final double amount;
  final String status;

  _PayoutItem({
    required this.id,
    required this.date,
    required this.reference,
    required this.bank,
    required this.amount,
    required this.status,
  });
}

class PayoutsScreen extends StatefulWidget {
  const PayoutsScreen({super.key});

  @override
  State<PayoutsScreen> createState() => _PayoutsScreenState();
}

class _PayoutsScreenState extends State<PayoutsScreen> {
  final List<_PayoutItem> _payouts = [
    _PayoutItem(id: 'po1', date: DateTime.now().subtract(const Duration(days: 3)), reference: 'PO-2024-001', bank: 'GTBank •••• 0123', amount: 150000.0, status: 'completed'),
    _PayoutItem(id: 'po2', date: DateTime.now().subtract(const Duration(days: 10)), reference: 'PO-2024-002', bank: 'GTBank •••• 0123', amount: 85000.0, status: 'completed'),
    _PayoutItem(id: 'po3', date: DateTime.now().subtract(const Duration(days: 17)), reference: 'PO-2024-003', bank: 'GTBank •••• 0123', amount: 210000.0, status: 'completed'),
    _PayoutItem(id: 'po4', date: DateTime.now().subtract(const Duration(days: 24)), reference: 'PO-2024-004', bank: 'GTBank •••• 0123', amount: 95000.0, status: 'pending'),
    _PayoutItem(id: 'po5', date: DateTime.now().subtract(const Duration(days: 31)), reference: 'PO-2024-005', bank: 'GTBank •••• 0123', amount: 180000.0, status: 'completed'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Payouts', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _balanceCard(
                    'Available to Withdraw',
                    '₦245,000.00',
                    Icons.account_balance_wallet,
                    AppColors.green,
                    () => _showRequestPayoutDialog(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _balanceCard(
                    'Pending Clearance',
                    '₦58,450.00',
                    Icons.hourglass_empty,
                    AppColors.warning,
                    null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildConnectedBank(),
            const SizedBox(height: 20),
            _buildPayoutSchedule(),
            const SizedBox(height: 20),
            Text('Payout History', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._payouts.map((p) => _buildPayoutRow(p)),
          ],
        ),
      ),
    );
  }

  Widget _balanceCard(String label, String amount, IconData icon, Color color, VoidCallback? onTap) {
    return Container(
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
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          Text(amount, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          if (onTap != null) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Request Withdrawal', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConnectedBank() {
    return Container(
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
              const Icon(Icons.account_balance, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('Connected Bank Account', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('Chase Checking', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(4)),
                child: Text('Verified', style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.success)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('•••• •••• •••• 4567', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textHint)),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: Text('Edit', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutSchedule() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 20, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payout Schedule', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                Text('Weekly - Every Thursday', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Change', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutRow(_PayoutItem p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.reference, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.account_balance, size: 10, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(p.bank, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                  ],
                ),
                const SizedBox(height: 2),
                Text('${p.date.day}/${p.date.month}/${p.date.year}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
              ],
            ),
          ),
          Text('₦${_formatAmount(p.amount)}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: p.status == 'completed' ? AppColors.successLight : AppColors.warningLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(p.status, style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.w600, color: p.status == 'completed' ? AppColors.success : AppColors.warning)),
          ),
        ],
      ),
    );
  }

  void _showRequestPayoutDialog() {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text('Request Payout', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
      content: Text('Available balance: ₦245,000.00\n\nEnter amount to withdraw:', style: GoogleFonts.inter(fontSize: 13)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: () { Navigator.pop(context); }, child: const Text('Confirm')),
      ],
    ));
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(0)}K';
    return amount.toStringAsFixed(2);
  }
}
