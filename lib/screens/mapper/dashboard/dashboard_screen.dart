import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';
import 'package:market_mirror_mobile/screens/mapper/tasks/tasks_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/task_detail/task_detail_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/register_vendor/register_vendor_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/map_shop/map_shop_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/nearby_vendors/nearby_vendors_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();
    final now = DateTime.now();
    final greeting = now.hour < 12 ? 'Good Morning' : now.hour < 17 ? 'Good Afternoon' : 'Good Evening';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Dashboard', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const _NotificationsScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const _ProfileScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WelcomeCard(greeting: greeting, profile: provider.profile, activeCount: provider.activeTaskCount),
            const SizedBox(height: 16),
            _StatsGrid(stats: provider.stats),
            const SizedBox(height: 16),
            _PerformanceGauge(performance: provider.stats.performance),
            const SizedBox(height: 16),
            _QuickActions(provider: provider),
            const SizedBox(height: 16),
            _SectionHeader(title: "Today's Priority Assignments", count: provider.todayPriorityTasks.length),
            const SizedBox(height: 8),
            ...provider.todayPriorityTasks.map((t) => _PriorityTaskCard(task: t)),
            const SizedBox(height: 16),
            _SectionHeader(title: 'Action Required', count: provider.requiresFixTasks.length),
            const SizedBox(height: 8),
            if (provider.requiresFixTasks.isEmpty)
              _EmptyPlaceholder(
                icon: Icons.check_circle_outline,
                message: 'No items requiring action',
                subtitle: 'All tasks are on track',
              )
            else
              ...provider.requiresFixTasks.map((t) => _ActionRequiredCard(task: t)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  final String greeting;
  final UserProfile profile;
  final int activeCount;
  const _WelcomeCard({required this.greeting, required this.profile, required this.activeCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(greeting, style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
                const SizedBox(height: 4),
                Text(profile.name, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                  child: Text('$activeCount Active Tasks', style: GoogleFonts.inter(fontSize: 12, color: Colors.white)),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: Text(profile.name.split(' ').map((e) => e[0]).join(), style: GoogleFonts.inter(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final MapperStats stats;
  const _StatsGrid({required this.stats});

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem(label: 'Tasks Completed', value: '${stats.tasksCompleted}', icon: Icons.task_alt, color: AppColors.success),
      _StatItem(label: 'In Progress', value: '${stats.inProgress}', icon: Icons.pending_actions, color: AppColors.info),
      _StatItem(label: 'Pending Review', value: '${stats.pendingReview}', icon: Icons.rate_review_outlined, color: AppColors.warning),
      _StatItem(label: 'Performance', value: '${stats.performance.toInt()}%', icon: Icons.trending_up, color: AppColors.accent),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.6, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: 4,
      itemBuilder: (_, i) => items[i],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _StatItem({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceGauge extends StatelessWidget {
  final double performance;
  const _PerformanceGauge({required this.performance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))]),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: _GaugePainter(performance: performance / 100),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${performance.toInt()}%', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    Text('Score', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Performance Score', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('You are performing exceptionally well. Keep up the great work!', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: performance / 100,
                  backgroundColor: AppColors.gaugeTrack,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double performance;
  _GaugePainter({required this.performance});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final trackPaint = Paint()
      ..color = AppColors.gaugeTrack
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    final fillPaint = Paint()
      ..color = performance > 0.8 ? AppColors.gaugeSuccess : AppColors.gaugeFill
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -0.5 * 3.14159, 2 * 3.14159 * performance, false, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) => old.performance != performance;
}

class _QuickActions extends StatelessWidget {
  final MapperProvider provider;
  const _QuickActions({required this.provider});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(icon: Icons.store, label: 'Register Vendor', color: AppColors.primary, onTap: () => provider.tabIndex = 2),
      _QuickAction(icon: Icons.map, label: 'Map Shop', color: AppColors.info, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapShopScreen()))),
      _QuickAction(icon: Icons.near_me, label: 'Nearby Vendors', color: AppColors.accent, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NearbyVendorsScreen()))),
      _QuickAction(icon: Icons.list_alt, label: 'View All Tasks', color: AppColors.primary, onTap: () => provider.tabIndex = 1),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          children: actions
              .map((a) => Expanded(
                    child: GestureDetector(
                      onTap: a.onTap,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))]),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: a.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                              child: Icon(a.icon, color: a.color, size: 24),
                            ),
                            const SizedBox(height: 8),
                            Text(a.label, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  _QuickAction({required this.icon, required this.label, required this.color, required this.onTap});
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(10)),
          child: Text('$count', style: GoogleFonts.inter(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _PriorityTaskCard extends StatelessWidget {
  final Task task;
  const _PriorityTaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: taskPriorityColor(task.priority), width: 4)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('${task.vendorName} \u2022 ${task.market}', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Text('Due: ${formatDate(task.dueDate)}', style: GoogleFonts.inter(fontSize: 11, color: AppColors.priorityHigh)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: taskPriorityColor(task.priority).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
              child: Text(taskPriorityLabel(task.priority), style: GoogleFonts.inter(fontSize: 10, color: taskPriorityColor(task.priority), fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionRequiredCard extends StatelessWidget {
  final Task task;
  const _ActionRequiredCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(task.rejectionReason ?? 'Requires corrections', style: GoogleFonts.inter(fontSize: 11, color: AppColors.error)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  final IconData icon;
  final String message, subtitle;
  const _EmptyPlaceholder({required this.icon, required this.message, this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, size: 40, color: AppColors.success),
          const SizedBox(height: 8),
          Text(message, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
          if (subtitle.isNotEmpty) const SizedBox(height: 4),
          if (subtitle.isNotEmpty) Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textHint)),
        ],
      ),
    );
  }
}

class _NotificationsScreen extends StatelessWidget {
  const _NotificationsScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(child: Text('Notifications Screen')),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}
