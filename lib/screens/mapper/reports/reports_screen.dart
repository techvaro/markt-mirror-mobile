import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();
    final reports = provider.reports;
    final summary = provider.dailySummary;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Reports', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: AppColors.error),
            onPressed: () => _showSnackBar(context, 'Exporting PDF...'),
            tooltip: 'Export PDF',
          ),
          IconButton(
            icon: const Icon(Icons.table_chart_outlined),
            onPressed: () => _showSnackBar(context, 'Exporting Excel...'),
            tooltip: 'Export Excel',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: FilledButton.icon(
                      onPressed: () => _showSnackBar(context, 'Exporting PDF...'),
                      icon: const Icon(Icons.picture_as_pdf, size: 18),
                      label: Text('Export PDF', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 13)),
                      style: FilledButton.styleFrom(backgroundColor: AppColors.error),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton.icon(
                      onPressed: () => _showSnackBar(context, 'Exporting Excel...'),
                      icon: const Icon(Icons.table_chart_outlined, size: 18),
                      label: Text('Export Excel', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 13)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Metric Summaries', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _MetricCard(
              icon: Icons.today,
              title: 'Daily Summary',
              value: '${summary.tasksCompleted} tasks completed',
              subtitle: 'Today\'s progress',
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            _MetricCard(
              icon: Icons.date_range,
              title: 'Weekly Report',
              value: '${summary.shopsMapped} shops mapped',
              subtitle: 'This week',
              color: AppColors.accent,
            ),
            const SizedBox(height: 8),
            _MetricCard(
              icon: Icons.calendar_month,
              title: 'Monthly Overview',
              value: '${summary.approvalRate.toInt()}% approval rate',
              subtitle: 'This month',
              color: AppColors.accent,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Reports', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                Text('${reports.length} files', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 12),
            ...reports.map((r) => _ReportCard(report: r)),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String title, value, subtitle;
  final Color color;
  const _MetricCard({required this.icon, required this.title, required this.value, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final Report report;
  const _ReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.errorLight, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.description, color: AppColors.error, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(report.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(formatDate(report.date), style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
                    const SizedBox(width: 12),
                    Icon(Icons.storage, size: 12, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(report.size, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.file_download, color: AppColors.primary),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Downloading ${report.name}...')),
            ),
          ),
        ],
      ),
    );
  }
}
