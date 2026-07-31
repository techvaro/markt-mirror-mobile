import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Orders', 'Alerts', 'System'];

  List<NotificationItem> _notifications = [
    NotificationItem(id: 'n1', type: NotificationType.system, title: 'New Order Received', body: 'You have received a new order (ORD-008) from Amara Eze.', timestamp: DateTime.now().subtract(const Duration(minutes: 30)), isRead: false),
    NotificationItem(id: 'n2', type: NotificationType.system, title: 'Order Delivered', body: 'Order ORD-004 has been marked as delivered.', timestamp: DateTime.now().subtract(const Duration(hours: 2)), isRead: false),
    NotificationItem(id: 'n3', type: NotificationType.system, title: 'Low Stock Alert', body: '"Handwoven Basket" is running low. Only 2 left in stock.', timestamp: DateTime.now().subtract(const Duration(hours: 5)), isRead: false),
    NotificationItem(id: 'n4', type: NotificationType.system, title: 'Out of Stock', body: '"Beaded Earrings" is now out of stock.', timestamp: DateTime.now().subtract(const Duration(hours: 8)), isRead: true),
    NotificationItem(id: 'n5', type: NotificationType.system, title: 'Payment Received', body: 'Payment of ₦12,500 for ORD-001 has been confirmed.', timestamp: DateTime.now().subtract(const Duration(days: 1)), isRead: true),
    NotificationItem(id: 'n6', type: NotificationType.system, title: 'Account Verified', body: 'Your vendor account has been verified successfully.', timestamp: DateTime.now().subtract(const Duration(days: 2)), isRead: true),
    NotificationItem(id: 'n7', type: NotificationType.system, title: 'Withdrawal Processed', body: 'Your payout of ₦150,000 has been sent to your bank account.', timestamp: DateTime.now().subtract(const Duration(days: 3)), isRead: true),
    NotificationItem(id: 'n8', type: NotificationType.system, title: 'Order Cancelled', body: 'Order ORD-006 has been cancelled by the customer.', timestamp: DateTime.now().subtract(const Duration(days: 4)), isRead: true),
    NotificationItem(id: 'n9', type: NotificationType.system, title: 'New Review', body: 'Tunde Balogun left a 4-star review on "Beaded Necklace".', timestamp: DateTime.now().subtract(const Duration(days: 5)), isRead: true),
    NotificationItem(id: 'n10', type: NotificationType.system, title: 'Weekly Report Ready', body: 'Your weekly sales report for last week is now available.', timestamp: DateTime.now().subtract(const Duration(days: 7)), isRead: true),
  ];

  List<NotificationItem> get _filteredNotifications {
    var list = _notifications;
    if (_selectedFilter != 'All') {
      list = list.where((n) => _typeLabel(n.type) == _selectedFilter).toList();
    }
    return list;
  }

  String _typeLabel(NotificationType type) {
    switch (type) {
      case NotificationType.assignment: return 'Orders';
      case NotificationType.approval: return 'Orders';
      case NotificationType.rejection: return 'Alerts';
      case NotificationType.system: return 'System';
    }
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    final notifications = _filteredNotifications;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Notifications', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: () {
                setState(() {
                  _notifications = _notifications.map((n) => NotificationItem(id: n.id, type: n.type, title: n.title, body: n.body, timestamp: n.timestamp, isRead: true)).toList();
                });
              },
              child: Text('Mark All Read', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            color: Colors.white,
            child: Row(
              children: _filters.map((f) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedFilter = f),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: _selectedFilter == f ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _selectedFilter == f ? AppColors.primary : AppColors.border),
                    ),
                    child: Text(f, style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.w500,
                      color: _selectedFilter == f ? Colors.white : AppColors.textSecondary,
                    )),
                  ),
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: notifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notifications.length,
                    itemBuilder: (_, i) => _buildNotificationCard(notifications[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.isRead ? Colors.white : AppColors.primary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: item.isRead ? AppColors.border : AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _typeColor(item.type).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(_typeIcon(item.type), size: 18, color: _typeColor(item.type)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(item.title, style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: item.isRead ? FontWeight.w500 : FontWeight.w700,
                      )),
                    ),
                    if (!item.isRead)
                      Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(color: AppColors.unreadDot, shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.body, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_timeAgo(item.timestamp), style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                    SizedBox(
                      height: 28,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                        child: Text('View Details', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_off_outlined, size: 48, color: AppColors.textHint.withValues(alpha: 0.4)),
          const SizedBox(height: 8),
          Text('No notifications', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  IconData _typeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
      case NotificationType.approval:
      case NotificationType.rejection:
        return Icons.shopping_bag;
      case NotificationType.system:
        return Icons.settings;
    }
  }

  Color _typeColor(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
      case NotificationType.approval:
      case NotificationType.rejection:
        return AppColors.primary;
      case NotificationType.system:
        return AppColors.info;
    }
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
