import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();
    final tasks = provider.completedTasks;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Completed Tasks', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Downloading report...')),
            ),
            tooltip: 'Download Report',
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline, size: 72, color: AppColors.textHint),
                  const SizedBox(height: 16),
                  Text('No completed tasks yet', style: GoogleFonts.inter(fontSize: 16, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Text('Completed tasks will appear here', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (_, i) => _CompletedTaskCard(task: tasks[i]),
            ),
    );
  }
}

class _CompletedTaskCard extends StatelessWidget {
  final Task task;
  const _CompletedTaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: AppColors.success, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.check_circle, color: AppColors.success, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text('${task.vendorName} \u2022 ${task.market}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(6)),
                child: Text('Approved', style: GoogleFonts.inter(fontSize: 10, color: AppColors.success, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.event, size: 14, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text('Completed: ${task.completedAt != null ? formatDate(task.completedAt!) : formatDate(task.createdAt)}',
                  style: GoogleFonts.inter(fontSize: 12, color: AppColors.textHint)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showSubmissionDialog(context, task),
                  icon: const Icon(Icons.visibility, size: 16),
                  label: Text('View Submission', style: GoogleFonts.inter(fontSize: 12)),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading ${task.id} report...'),
                      backgroundColor: AppColors.primary,
                    ),
                  ),
                  icon: const Icon(Icons.file_download, size: 16),
                  label: Text('Download Report', style: GoogleFonts.inter(fontSize: 12)),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSubmissionDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Submission Summary', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row('Task', task.title),
            _row('Vendor', task.vendorName),
            _row('Market', task.market),
            _row('Status', taskStatusLabel(task.status)),
            _row('Completed', task.completedAt != null ? formatDate(task.completedAt!) : 'N/A'),
            _row('Priority', taskPriorityLabel(task.priority)),
            if (task.description != null && task.description!.isNotEmpty) _row('Description', task.description!),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: GoogleFonts.inter()),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            child: Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
