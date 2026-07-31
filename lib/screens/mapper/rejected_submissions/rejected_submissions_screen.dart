import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';
import 'package:market_mirror_mobile/screens/mapper/task_detail/task_detail_screen.dart';

class RejectedSubmissionsScreen extends StatelessWidget {
  const RejectedSubmissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();
    final tasks = provider.rejectedTasks;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Rejected Submissions', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: AppColors.successLight, shape: BoxShape.circle),
                    child: const Icon(Icons.celebration_outlined, size: 48, color: AppColors.success),
                  ),
                  const SizedBox(height: 16),
                  Text('No rejected submissions', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text('Great job! All submissions are on track.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (_, i) => _RejectedTaskCard(task: tasks[i]),
            ),
    );
  }
}

class _RejectedTaskCard extends StatelessWidget {
  final Task task;
  const _RejectedTaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.errorLight, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.error_outline, color: AppColors.error, size: 22),
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
                decoration: BoxDecoration(color: AppColors.errorLight, borderRadius: BorderRadius.circular(6)),
                child: Text('Rejected', style: GoogleFonts.inter(fontSize: 10, color: AppColors.error, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.errorLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rejection Reason', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.error)),
                const SizedBox(height: 4),
                Text(task.rejectionReason ?? 'No reason provided', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textPrimary)),
              ],
            ),
          ),
          if (task.requiredActions.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('Required Corrections', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            ...task.requiredActions.map((action) => Padding(
                  padding: const EdgeInsets.only(bottom: 4, left: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.circle, size: 6, color: AppColors.error),
                      const SizedBox(width: 8),
                      Expanded(child: Text(action, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textPrimary))),
                    ],
                  ),
                )),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
              ),
              icon: const Icon(Icons.edit, size: 18),
              label: Text('Edit & Resubmit', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
