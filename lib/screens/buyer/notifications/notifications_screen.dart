import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

final List<AppNotification> _notifications = [
  AppNotification(id: 'n1', type: 'order', title: 'Order Delivered', message: 'Your PS5 from TechCity has been delivered.', time: DateTime(2026, 7, 28, 14, 30), read: true),
  AppNotification(id: 'n2', type: 'shipping', title: 'Out for Delivery', message: 'Your Swiss Lace order is out for delivery today.', time: DateTime(2026, 7, 28, 8, 15), read: false),
  AppNotification(id: 'n3', type: 'promo', title: 'Flash Sale Alert', message: 'TechCity has a 24-hour flash sale! Up to 20% off.', time: DateTime(2026, 7, 27, 18, 0), read: false),
  AppNotification(id: 'n4', type: 'order', title: 'Order Confirmed', message: 'Your order #MM-2026-004 has been confirmed.', time: DateTime(2026, 7, 26, 17, 0), read: true),
  AppNotification(id: 'n5', type: 'system', title: 'Welcome to Market Mirror', message: 'Thank you for joining. Start exploring shops near you!', time: DateTime(2026, 7, 15, 9, 0), read: true),
  AppNotification(id: 'n6', type: 'review', title: 'Review Request', message: 'How was your shopping experience? Leave a review for TechCity.', time: DateTime(2026, 7, 28, 16, 0), read: false),
];

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<AppNotification> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(_notifications);
  }

  void _markAllRead() {
    setState(() {
      for (final n in _items) {
        _items[_items.indexOf(n)] = AppNotification(id: n.id, type: n.type, title: n.title, message: n.message, time: n.time, read: true, link: n.link);
      }
    });
  }

  void _clearAll() {
    setState(() => _items.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Notifications', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
        actions: [
          if (_items.any((n) => !n.read))
            TextButton(onPressed: _markAllRead, child: Text('Mark All Read', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600))),
          if (_items.isNotEmpty)
            TextButton(onPressed: _clearAll, child: Text('Clear All', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.error, fontWeight: FontWeight.w600))),
        ],
      ),
      body: _items.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_none, size: 80, color: AppColors.textHint.withOpacity(0.4)),
                const SizedBox(height: 16),
                Text('No notifications', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text('You\'re all caught up!', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textSecondary)),
              ],
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final n = _items[i];
              final icon = _typeIcon(n.type);
              final iconColor = _typeColor(n.type);

              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: n.read ? AppColors.border : AppColors.primary.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: iconColor.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(n.title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: n.read ? FontWeight.w500 : FontWeight.w600, color: AppColors.textPrimary)),
                              ),
                              if (!n.read)
                                Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.unreadDot)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(n.message, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Text(_relativeTime(n.time), style: GoogleFonts.sourceSans3(fontSize: 10, color: AppColors.textHint)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'chat': return Icons.chat;
      case 'order': return Icons.receipt_long;
      case 'shipping': return Icons.local_shipping;
      case 'review': return Icons.star;
      case 'promo': return Icons.discount;
      default: return Icons.notifications;
    }
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'chat': return AppColors.blue;
      case 'order': return AppColors.primary;
      case 'shipping': return AppColors.orange;
      case 'review': return AppColors.yellow;
      case 'promo': return AppColors.green;
      default: return AppColors.textPrimary;
    }
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
