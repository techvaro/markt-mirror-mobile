import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/data/mock_data.dart';
import 'chat_screen.dart';
import '../shop_detail/shop_detail_screen.dart';

final List<BuyerConversation> buyerConversations = [
  BuyerConversation(id: 'conv_1', shopId: 'shop_1', shopName: 'TechCity', category: 'Electronics', lastMessage: 'Yes, we have the PS5 in stock!', time: '2m ago', unread: 2, online: true),
  BuyerConversation(id: 'conv_2', shopId: 'shop_2', shopName: 'PhoneHub', category: 'Phones', lastMessage: 'The iPhone 15 Pro Max comes with 1-year warranty.', time: '1h ago', unread: 0, online: true),
  BuyerConversation(id: 'conv_3', shopId: 'shop_3', shopName: 'GlobalFabrics', category: 'Fabrics', lastMessage: 'Swiss lace available in white, ivory, and champagne.', time: '3h ago', unread: 1, online: false),
  BuyerConversation(id: 'conv_4', shopId: 'shop_4', shopName: 'Kemis Home Appliances', category: 'Appliances', lastMessage: 'Delivery takes 2-3 business days.', time: '1d ago', unread: 0, online: false),
];

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  List<BuyerConversation> get _filtered {
    if (_searchCtrl.text.isEmpty) return buyerConversations;
    return buyerConversations.where((c) => c.shopName.toLowerCase().contains(_searchCtrl.text.toLowerCase())).toList();
  }

  int get _totalUnread => buyerConversations.fold(0, (sum, c) => sum + c.unread);

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message, style: GoogleFonts.sourceSans3(fontSize: 13)), backgroundColor: AppColors.primary));
  }

  Future<void> _handleMenu(BuyerConversation conv, String value) async {
    switch (value) {
      case 'open':
        Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(shopName: conv.shopName)));
        break;
      case 'view_shop':
        try {
          final shop = MockData.shops.firstWhere((s) => s.id == conv.shopId);
          Navigator.push(context, MaterialPageRoute(builder: (_) => ShopDetailScreen(shop: shop)));
        } catch (_) {
          _showSnack('Shop profile unavailable');
        }
        break;
      case 'mark_read':
        setState(() {
          final idx = buyerConversations.indexWhere((c) => c.id == conv.id);
          if (idx >= 0) buyerConversations[idx] = BuyerConversation(id: conv.id, shopId: conv.shopId, shopName: conv.shopName, category: conv.category, lastMessage: conv.lastMessage, time: conv.time, unread: 0, online: conv.online);
        });
        _showSnack('Marked as read');
        break;
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('Delete conversation?', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            content: Text('Chat with ${conv.shopName} will be removed.', style: GoogleFonts.sourceSans3(fontSize: 13)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
              TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Delete', style: GoogleFonts.sourceSans3(fontWeight: FontWeight.w700, color: AppColors.error))),
            ],
          ),
        );
        if (confirmed == true) {
          setState(() => buyerConversations.removeWhere((c) => c.id == conv.id));
          _showSnack('Conversation deleted');
        }
        break;
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Messages', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.sourceSans3(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search conversations...',
                      hintStyle: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textHint),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: AppColors.textHint, size: 20),
                      suffixIcon: _searchCtrl.text.isNotEmpty ? IconButton(
                        icon: const Icon(Icons.clear, size: 18, color: AppColors.textHint),
                        onPressed: () { _searchCtrl.clear(); setState(() {}); },
                      ) : null,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (_totalUnread > 0) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('$_totalUnread unread', style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Expanded(
            child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 60, color: AppColors.textHint.withOpacity(0.5)),
                      const SizedBox(height: 12),
                      Text('No conversations', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final conv = filtered[i];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(shopName: conv.shopName))),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 50, height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(child: Text(conv.shopName[0], style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white))),
                                ),
                                if (conv.online)
                                  Positioned(
                                    bottom: 0, right: 0,
                                    child: Container(
                                      width: 14, height: 14,
                                      decoration: BoxDecoration(color: AppColors.onlineDot, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(conv.shopName, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                      Text(conv.time, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textHint)),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(conv.lastMessage, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                      if (conv.unread > 0) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(color: AppColors.unreadDot, borderRadius: BorderRadius.circular(12)),
                                          child: Text('${conv.unread}', style: GoogleFonts.sourceSans3(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, size: 20, color: AppColors.textHint),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              onSelected: (value) => _handleMenu(conv, value),
                              itemBuilder: (_) => const [
                                PopupMenuItem(value: 'open', child: _MenuRow(icon: Icons.chat_bubble_outline, label: 'Open Chat')),
                                PopupMenuItem(value: 'view_shop', child: _MenuRow(icon: Icons.storefront_outlined, label: 'View Shop')),
                                PopupMenuItem(value: 'mark_read', child: _MenuRow(icon: Icons.mark_email_read_outlined, label: 'Mark as Read')),
                                PopupMenuItem(value: 'delete', child: _MenuRow(icon: Icons.delete_outline, label: 'Delete')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textPrimary),
        const SizedBox(width: 10),
        Text(label, style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textPrimary)),
      ],
    );
  }
}