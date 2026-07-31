import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  List<Customer> _customers = [
    Customer(id: 'c1', name: 'Amara Eze', email: 'amara.eze@gmail.com', phone: '+234 801 234 5678', ordersCount: 12, totalSpend: 245000.0, lastOrder: DateTime.now().subtract(const Duration(days: 2)), address: '12 Awolowo Road, Ikeja, Lagos', status: 'active'),
    Customer(id: 'c2', name: 'Tunde Balogun', email: 'tunde.b@gmail.com', phone: '+234 802 345 6789', ordersCount: 8, totalSpend: 189500.0, lastOrder: DateTime.now().subtract(const Duration(days: 5)), address: '45 Marina, VI, Lagos', status: 'active'),
    Customer(id: 'c3', name: 'Ngozi Okafor', email: 'ngozi.o@yahoo.com', phone: '+234 803 456 7890', ordersCount: 3, totalSpend: 45000.0, lastOrder: DateTime.now().subtract(const Duration(days: 10)), address: '8 Bishop Oluwole, Ikeja', status: 'active'),
    Customer(id: 'c4', name: 'Kelechi Nwosu', email: 'kelechi.n@gmail.com', phone: '+234 804 567 8901', ordersCount: 1, totalSpend: 5600.0, lastOrder: DateTime.now().subtract(const Duration(days: 14)), status: 'inactive'),
    Customer(id: 'c5', name: 'Chioma Obi', email: 'chioma.obi@outlook.com', phone: '+234 805 678 9012', ordersCount: 6, totalSpend: 112000.0, lastOrder: DateTime.now().subtract(const Duration(days: 7)), status: 'active'),
    Customer(id: 'c6', name: 'Femi Adekunle', email: 'femi.a@gmail.com', phone: '+234 806 789 0123', ordersCount: 2, totalSpend: 15000.0, lastOrder: DateTime.now().subtract(const Duration(days: 21)), status: 'active'),
    Customer(id: 'c7', name: 'Zainab Abdullah', email: 'zainab.a@hotmail.com', phone: '+234 807 890 1234', ordersCount: 5, totalSpend: 78500.0, lastOrder: DateTime.now().subtract(const Duration(days: 3)), status: 'active'),
  ];

  List<Customer> get _filteredCustomers {
    var list = _customers;
    if (_searchCtrl.text.isNotEmpty) {
      final q = _searchCtrl.text.toLowerCase();
      list = list.where((c) => c.name.toLowerCase().contains(q) || c.email.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customers = _filteredCustomers;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Customers', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
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
                        hintText: 'Search customers...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: customers.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: customers.length,
                    itemBuilder: (_, i) => _buildCustomerCard(customers[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Customer customer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () => _showCustomerDetail(customer),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                customer.name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').join().toUpperCase(),
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(customer.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      ),
                      if (customer.status == 'inactive')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.textHint.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                          child: Text('Inactive', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textHint)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(customer.email, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('${customer.ordersCount} orders', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                      const SizedBox(width: 12),
                      Text('₦${customer.totalSpend.toStringAsFixed(0)}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      if (customer.lastOrder != null) ...[
                        const SizedBox(width: 12),
                        Text('Last: ${_daysAgo(customer.lastOrder!)}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 18, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }

  void _showCustomerDetail(Customer customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  customer.name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').join().toUpperCase(),
                  style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 8),
              Text(customer.name, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700)),
              Text(customer.email, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _detailStat('${customer.ordersCount}', 'Orders'),
                  _detailStat('₦${_formatAmount(customer.totalSpend)}', 'Total Spend'),
                ],
              ),
              const SizedBox(height: 16),
              _detailRow('Phone', customer.phone ?? 'N/A'),
              _detailRow('Address', customer.address ?? 'N/A'),
              _detailRow('Last Order', '${customer.lastOrder.day}/${customer.lastOrder.month}/${customer.lastOrder.year}'),
              const SizedBox(height: 16),
              const Divider(),
              Text('Recent Orders', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              ...List.generate(3, (i) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Icon(Icons.receipt, size: 18, color: AppColors.textHint)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text('ORD-00${i + 1}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500))),
                    Text('₦${(12000 + i * 5000).toStringAsFixed(0)}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              )),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.message, size: 16),
                      label: const Text('Message'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.block, size: 16),
                      label: const Text('Blacklist'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.red,
                        side: const BorderSide(color: AppColors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
          Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 48, color: AppColors.textHint.withOpacity(0.4)),
          const SizedBox(height: 8),
          Text('No customers found', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  String _daysAgo(DateTime date) {
    final diff = DateTime.now().difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '$diff days ago';
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return amount.toStringAsFixed(0);
  }
}
