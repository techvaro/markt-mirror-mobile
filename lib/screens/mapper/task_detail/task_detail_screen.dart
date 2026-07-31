import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/screens/mapper/register_vendor/register_vendor_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/map_shop/map_shop_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Task Details', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderSection(task: task),
                  const SizedBox(height: 12),
                  if (task.status == TaskStatus.requiresFix) ...[
                    _RejectionBanner(reason: task.rejectionReason ?? 'Corrections required'),
                    const SizedBox(height: 12),
                  ],
                  _InfoCard(task: task),
                  const SizedBox(height: 12),
                  _RequiredActionsSection(task: task),
                  const SizedBox(height: 12),
                  _QuickLinksSection(task: task),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _BottomActionBar(task: task),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final Task task;
  const _HeaderSection({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: taskPriorityColor(task.priority), width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(task.title, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: taskStatusBgColor(task.status),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      task.status == TaskStatus.completed ? Icons.check_circle : task.status == TaskStatus.inProgress ? Icons.sync : task.status == TaskStatus.requiresFix ? Icons.error : Icons.schedule,
                      size: 14,
                      color: taskPriorityColor(task.priority),
                    ),
                    const SizedBox(width: 4),
                    Text(taskStatusLabel(task.status), style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: taskPriorityColor(task.priority))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _InfoRow(icon: Icons.store, label: 'Vendor', value: task.vendorName),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.location_on, label: 'Market', value: task.market),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.calendar_today, label: 'Due Date', value: formatDate(task.dueDate)),
          if (task.description != null && task.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.description, label: 'Description', value: task.description!),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
        ),
        Expanded(child: Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500))),
      ],
    );
  }
}

class _RejectionBanner extends StatelessWidget {
  final String reason;
  const _RejectionBanner({required this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error, color: AppColors.error, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Submission Rejected', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.error)),
                const SizedBox(height: 4),
                Text(reason, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Task task;
  const _InfoCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Task Information', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _DetailRow(label: 'Task ID', value: task.id),
          const SizedBox(height: 8),
          _DetailRow(label: 'Priority', value: taskPriorityLabel(task.priority)),
          const SizedBox(height: 8),
          _DetailRow(label: 'Status', value: taskStatusLabel(task.status)),
          const SizedBox(height: 8),
          _DetailRow(label: 'Created', value: formatDate(task.createdAt)),
          if (task.completedAt != null) ...[
            const SizedBox(height: 8),
            _DetailRow(label: 'Completed', value: formatDate(task.completedAt!)),
          ],
          if (task.approvedAt != null) ...[
            const SizedBox(height: 8),
            _DetailRow(label: 'Approved', value: formatDate(task.approvedAt!)),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
        Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _RequiredActionsSection extends StatelessWidget {
  final Task task;
  const _RequiredActionsSection({required this.task});

  @override
  Widget build(BuildContext context) {
    if (task.requiredActions.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.checklist, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('Required Actions', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          ...task.requiredActions.map((action) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(action, style: GoogleFonts.inter(fontSize: 13)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _QuickLinksSection extends StatelessWidget {
  final Task task;
  const _QuickLinksSection({required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterVendorScreen())),
            icon: const Icon(Icons.store, size: 18),
            label: Text('Register Vendor', style: GoogleFonts.inter(fontSize: 12)),
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapShopScreen())),
            icon: const Icon(Icons.map, size: 18),
            label: Text('Map Shop', style: GoogleFonts.inter(fontSize: 12)),
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
          ),
        ),
      ],
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final Task task;
  const _BottomActionBar({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (task.status == TaskStatus.requiresFix)
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _showSnackBar(context, 'Opening task for corrections...'),
                  icon: const Icon(Icons.edit, size: 18),
                  label: Text('Edit & Resubmit', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColors.error,
                  ),
                ),
              )
            else if (task.status == TaskStatus.pending)
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _showSnackBar(context, 'Starting task workflow...'),
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: Text('Start Task', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              )
            else if (task.status == TaskStatus.inProgress)
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _showSnackBar(context, 'Continuing workflow...'),
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  label: Text('Continue Workflow', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              )
            else
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _showSnackBar(context, 'Task marked as done!'),
                  icon: const Icon(Icons.check_circle, size: 18),
                  label: Text('Mark as Done', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColors.success,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
