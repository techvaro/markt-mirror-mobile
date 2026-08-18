import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/data/mock_data.dart';
import '../call/call_screen.dart';
import '../shop_detail/shop_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  final String shopName;
  const ChatScreen({super.key, this.shopName = 'TechCity'});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  final List<_Message> _messages = [
    _Message(text: 'Hello! I\'m interested in the PS5.', isMe: true, time: '10:00 AM'),
    _Message(text: 'Hi! Yes, we have the Standard and Digital editions available.', isMe: false, time: '10:05 AM'),
    _Message(text: 'Great! What\'s the best price you can give me?', isMe: true, time: '10:07 AM'),
    _Message(text: 'The standard edition is ₦380,000. We can offer a 5% discount for first-time buyers.', isMe: false, time: '10:10 AM'),
    _Message(text: 'That sounds good. I\'ll take the standard edition.', isMe: true, time: '10:12 AM'),
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_msgCtrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add(_Message(text: _msgCtrl.text.trim(), isMe: true, time: 'Now'));
      _msgCtrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_scrollCtrl.hasClients) _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  Shop? get _shop {
    try {
      return MockData.shops.firstWhere((s) => s.name == widget.shopName);
    } catch (_) {
      return null;
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message, style: GoogleFonts.sourceSans3(fontSize: 13)), backgroundColor: AppColors.primary));
  }

  Future<void> _handleMenuAction(String value) async {
    switch (value) {
      case 'view_shop':
        final shop = _shop;
        if (shop != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ShopDetailScreen(shop: shop)));
        } else {
          _showSnack('Shop profile unavailable');
        }
        break;
      case 'call':
        Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(contactName: widget.shopName)));
        break;
      case 'favorite':
        _showSnack('${widget.shopName} added to favorites');
        break;
      case 'clear':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('Clear chat?', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            content: Text('This will delete all messages with ${widget.shopName}.', style: GoogleFonts.sourceSans3(fontSize: 13)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
              TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Clear', style: GoogleFonts.sourceSans3(fontWeight: FontWeight.w700, color: AppColors.error))),
            ],
          ),
        );
        if (confirmed == true) {
          _showSnack('Chat cleared');
        }
        break;
      case 'block':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('Block seller?', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            content: Text('You will no longer receive messages from ${widget.shopName}.', style: GoogleFonts.sourceSans3(fontSize: 13)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
              TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Block', style: GoogleFonts.sourceSans3(fontWeight: FontWeight.w700, color: AppColors.error))),
            ],
          ),
        );
        if (confirmed == true) {
          _showSnack('${widget.shopName} blocked');
        }
        break;
      case 'report':
        final reason = await showDialog<String>(
          context: context,
          builder: (ctx) => SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('Report seller', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            children: ['Fraud / Scam', 'Harassment', 'Misleading products', 'Offensive content'].map((r) => SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, r),
              child: Text(r, style: GoogleFonts.sourceSans3(fontSize: 14)),
            )).toList(),
          ),
        );
        if (reason != null) {
          _showSnack('Report submitted: $reason');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(widget.shopName[0], style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary))),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.shopName, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                Text('Online', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.success)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: AppColors.success),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(contactName: widget.shopName))),
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: AppColors.primary),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(contactName: widget.shopName, isVideoCall: true))),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'view_shop', child: _MenuRow(icon: Icons.storefront_outlined, label: 'View Shop')),
              PopupMenuItem(value: 'call', child: _MenuRow(icon: Icons.phone_outlined, label: 'Call Shop')),
              PopupMenuItem(value: 'favorite', child: _MenuRow(icon: Icons.favorite_border, label: 'Add to Favorites')),
              PopupMenuItem(value: 'clear', child: _MenuRow(icon: Icons.delete_outline, label: 'Clear Chat')),
              PopupMenuItem(value: 'block', child: _MenuRow(icon: Icons.block, label: 'Block Seller')),
              PopupMenuItem(value: 'report', child: _MenuRow(icon: Icons.flag_outlined, label: 'Report Seller')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 60, color: AppColors.textHint.withOpacity(0.5)),
                      const SizedBox(height: 12),
                      Text('Start a conversation', style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textSecondary)),
                      Text('Send a message to $widget.shopName', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textHint)),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (_, i) {
                    final msg = _messages[i];
                    return _MessageBubble(message: msg);
                  },
                ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))]),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(24)),
                    child: TextField(
                      controller: _msgCtrl,
                      style: GoogleFonts.sourceSans3(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textHint),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isMe;
  final String time;
  _Message({required this.text, required this.isMe, required this.time});
}

class _MessageBubble extends StatelessWidget {
  final _Message message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isMe ? 16 : 4),
            bottomRight: Radius.circular(message.isMe ? 4 : 16),
          ),
          border: message.isMe ? null : Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(message.text, style: GoogleFonts.sourceSans3(fontSize: 14, color: message.isMe ? Colors.white : AppColors.textPrimary)),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message.time, style: TextStyle(fontSize: 10, color: message.isMe ? Colors.white70 : AppColors.textHint)),
                if (message.isMe) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.done_all, size: 12, color: Colors.white70),
                ],
              ],
            ),
          ],
        ),
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
