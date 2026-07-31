import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatCard(title: 'Active Vendors', value: '128', color: AppColors.kpiBlue, icon: Icons.storefront),
      _StatCard(title: 'Pending Approvals', value: '24', color: AppColors.warning, icon: Icons.pending_actions),
      _StatCard(title: 'Orders', value: '842', color: AppColors.kpiGreen, icon: Icons.receipt_long),
      _StatCard(title: 'Disputes', value: '9', color: AppColors.error, icon: Icons.gavel),
    ];

    final modules = [
      _ModuleItem(title: 'Marketplace', subtitle: 'Browse and manage all listings', icon: Icons.grid_view, color: AppColors.primary),
      _ModuleItem(title: 'Vendors', subtitle: 'Approve or review vendor onboarding', icon: Icons.storefront, color: AppColors.kpiOrange),
      _ModuleItem(title: 'Products', subtitle: 'Monitor product quality and availability', icon: Icons.inventory_2, color: AppColors.kpiPurple),
      _ModuleItem(title: 'Orders', subtitle: 'Review fulfilment and payments', icon: Icons.local_shipping, color: AppColors.kpiTeal),
      _ModuleItem(title: 'Approvals', subtitle: 'Track mapper and vendor submissions', icon: Icons.fact_check, color: AppColors.warning),
      _ModuleItem(title: 'Disputes', subtitle: 'Resolve buyer and seller escalations', icon: Icons.support_agent, color: AppColors.error),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Admin Console', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Operations overview', style: GoogleFonts.sourceSans3(fontSize: 12, color: Colors.white70)),
                  const SizedBox(height: 4),
                  Text('Keep buyers, vendors, mappers, and marketplace health aligned.', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 10),
                  Text('This admin view mirrors the key web dashboard modules for a prototype demo.', style: GoogleFonts.sourceSans3(fontSize: 13, color: Colors.white.withOpacity(0.9), height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: stats.map((item) => item).toList(),
            ),
            const SizedBox(height: 16),
            Text('Key modules', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            ...modules.map((item) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(color: item.color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                    child: Icon(item.icon, color: item.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        const SizedBox(height: 2),
                        Text(item.subtitle, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textHint),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  const _StatCard({required this.title, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 20)),
          const SizedBox(height: 10),
          Text(value, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(title, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _ModuleItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  const _ModuleItem({required this.title, required this.subtitle, required this.icon, required this.color});
}
