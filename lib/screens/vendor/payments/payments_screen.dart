import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

class _Transaction {
  final String id;
  final DateTime date;
  final String description;
  final String type;
  final double amount;
  final String status;

  _Transaction({
    required this.id,
    required this.date,
    required this.description,
    required this.type,
    required this.amount,
    required this.status,
  });
}

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final List<_Transaction> _transactions = [
    _Transaction(id: 't1', date: DateTime.now().subtract(const Duration(days: 1)), description: 'Order ORD-001', type: 'sale', amount: 12500.0, status: 'completed'),
    _Transaction(id: 't2', date: DateTime.now().subtract(const Duration(days: 1)), description: 'Order ORD-002', type: 'sale', amount: 8500.0, status: 'completed'),
    _Transaction(id: 't3', date: DateTime.now().subtract(const Duration(days: 2)), description: 'Refund ORD-006', type: 'refund', amount: -7500.0, status: 'completed'),
    _Transaction(id: 't4', date: DateTime.now().subtract(const Duration(days: 2)), description: 'Platform Fee', type: 'fee', amount: -1250.0, status: 'completed'),
    _Transaction(id: 't5', date: DateTime.now().subtract(const Duration(days: 3)), description: 'Order ORD-003', type: 'sale', amount: 32000.0, status: 'pending'),
    _Transaction(id: 't6', date: DateTime.now().subtract(const Duration(days: 3)), description: 'Order ORD-004', type: 'sale', amount: 5600.0, status: 'completed'),
    _Transaction(id: 't7', date: DateTime.now().subtract(const Duration(days: 4)), description: 'Order ORD-005', type: 'sale', amount: 18000.0, status: 'completed'),
    _Transaction(id: 't8', date: DateTime.now().subtract(const Duration(days: 5)), description: 'Withdrawal Fee', type: 'fee', amount: -500.0, status: 'completed'),
    _Transaction(id: 't9', date: DateTime.now().subtract(const Duration(days: 7)), description: 'Order ORD-007', type: 'sale', amount: 24250.0, status: 'completed'),
  ];

  double get _netRevenue => _transactions.where((t) => t.type == 'sale' && t.status == 'completed').fold(0.0, (sum, t) => sum + t.amount) -
      _transactions.where((t) => t.type == 'refund' && t.status == 'completed').fold(0.0, (sum, t) => sum + t.amount.abs()) -
      _transactions.where((t) => t.type == 'fee' && t.status == 'completed').fold(0.0, (sum, t) => sum + t.amount.abs());

  double get _grossSales => _transactions.where((t) => t.type == 'sale' && t.status == 'completed').fold(0.0, (sum, t) => sum + t.amount);

  double get _refundsAndFees => _transactions.where((t) => (t.type == 'refund' || t.type == 'fee') && t.status == 'completed').fold(0.0, (sum, t) => sum + t.amount.abs());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Payments', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _summaryCard('Net Revenue', '₦${_formatAmount(_netRevenue)}', Icons.account_balance_wallet, AppColors.green),
                const SizedBox(width: 10),
                _summaryCard('Gross Sales', '₦${_formatAmount(_grossSales)}', Icons.trending_up, AppColors.blue),
                const SizedBox(width: 10),
                _summaryCard('Refunds & Fees', '₦${_formatAmount(_refundsAndFees)}', Icons.money_off, AppColors.red),
              ],
            ),
            const SizedBox(height: 20),
            Text('Transaction History', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ..._transactions.map((t) => _buildTransactionRow(t)),
            const SizedBox(height: 24),
            Text('Payment Methods', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _paymentMethodRow('Bank Transfer', 'GTBank •••• 0123', Icons.account_balance, true),
                  const Divider(height: 16),
                  _paymentMethodRow('Card Payments', 'Visa/Mastercard', Icons.credit_card, true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 6),
            Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)),
            Text(label, style: GoogleFonts.inter(fontSize: 9, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionRow(_Transaction t) {
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
                Text(t.description, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('${t.date.day}/${t.date.month}/${t.date.year}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: t.type == 'sale' ? AppColors.successLight : AppColors.errorLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(t.type.toUpperCase(), style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.w600, color: t.type == 'sale' ? AppColors.success : AppColors.error)),
          ),
          const SizedBox(width: 8),
          Text('₦${_formatAmount(t.amount)}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: t.amount >= 0 ? AppColors.textPrimary : AppColors.error)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: t.status == 'completed' ? AppColors.successLight : AppColors.warningLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(t.status, style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.w600, color: t.status == 'completed' ? AppColors.success : AppColors.warning)),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodRow(String name, String detail, IconData icon, bool active) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
              Text(detail, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
            ],
          ),
        ),
        if (active)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(4)),
            child: Text('Active', style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.success)),
          ),
      ],
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(0)}K';
    return amount.toStringAsFixed(2);
  }
}
