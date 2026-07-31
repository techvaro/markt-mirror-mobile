import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();
    final notifications = provider.notifications;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          TextButton(
            onPressed: provider.markAllNotificationsRead,
            child: Text('Mark All Read', style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_off_outlined, size: 72, color: AppColors.textHint),
                  const SizedBox(height: 16),
                  Text('No notifications', style: GoogleFonts.inter(fontSize: 16, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Text('You\'re all caught up!', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textHint)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (_, i) => _NotificationCard(
                notification: notifications[i],
                onMarkRead: () => provider.markNotificationRead(notifications[i].id),
              ),
            ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onMarkRead;
  const _NotificationCard({required this.notification, required this.onMarkRead});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: notification.isRead ? AppColors.surface : AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: notification.isRead ? AppColors.divider : AppColors.primaryLight.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _iconColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(_iconData(), color: _iconColor(), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(notification.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(notification.body, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(relativeTime(notification.timestamp), style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
                    if (!notification.isRead) ...[
                      const Spacer(),
                      GestureDetector(
                        onTap: onMarkRead,
                        child: Text('Mark as read', style: GoogleFonts.inter(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconData() {
    switch (notification.type) {
      case NotificationType.assignment: return Icons.assignment;
      case NotificationType.approval: return Icons.check_circle;
      case NotificationType.rejection: return Icons.error;
      case NotificationType.system: return Icons.info_outline;
    }
  }

  Color _iconColor() {
    switch (notification.type) {
      case NotificationType.assignment: return AppColors.notificationAssignment;
      case NotificationType.approval: return AppColors.notificationApproval;
      case NotificationType.rejection: return AppColors.notificationRejection;
      case NotificationType.system: return AppColors.notificationSystem;
    }
  }
}
