import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

class _ChatMsg {
  final String text;
  final DateTime timestamp;
  final bool isVendor;
  _ChatMsg({required this.text, required this.timestamp, this.isVendor = false});
}

class _Convo {
  final String id;
  final String customerName;
  final String? product;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool unread;
  final bool online;
  final List<_ChatMsg> messages;

  _Convo({
    required this.id,
    required this.customerName,
    this.product,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unread = false,
    this.online = false,
    required this.messages,
  });
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _msgCtrl = TextEditingController();
  String? _selectedConversationId;
  bool _inCall = false;
  int _callSeconds = 0;

  final List<_Convo> _conversations = [
    _Convo(
      id: 'm1', customerName: 'Amara Eze', product: 'Handwoven Basket',
      lastMessage: 'Thank you! The basket arrived safely.', lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
      unread: true, online: true,
      messages: [
        _ChatMsg(text: 'Hi, is this still available?', timestamp: DateTime.now().subtract(const Duration(hours: 2)), isVendor: false),
        _ChatMsg(text: 'Yes, it is! We have 5 in stock.', timestamp: DateTime.now().subtract(const Duration(hours: 2)).add(const Duration(minutes: 3)), isVendor: true),
        _ChatMsg(text: 'Great! I\'d like to order one.', timestamp: DateTime.now().subtract(const Duration(hours: 2)).add(const Duration(minutes: 5)), isVendor: false),
        _ChatMsg(text: 'Sure, please proceed with checkout.', timestamp: DateTime.now().subtract(const Duration(hours: 2)).add(const Duration(minutes: 8)), isVendor: true),
        _ChatMsg(text: 'Thank you! The basket arrived safely.', timestamp: DateTime.now().subtract(const Duration(minutes: 15)), isVendor: false),
      ],
    ),
    _Convo(
      id: 'm2', customerName: 'Tunde Balogun', product: 'Beaded Necklace',
      lastMessage: 'Can I get a discount for bulk?', lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      unread: false, online: false,
      messages: [
        _ChatMsg(text: 'Hi, I love the necklace design.', timestamp: DateTime.now().subtract(const Duration(hours: 3)), isVendor: false),
        _ChatMsg(text: 'Can I get a discount for bulk?', timestamp: DateTime.now().subtract(const Duration(hours: 2)), isVendor: false),
      ],
    ),
    _Convo(
      id: 'm3', customerName: 'Ngozi Okafor', product: 'Canvas Painting',
      lastMessage: 'The painting is beautiful!', lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unread: false, online: true,
      messages: [
        _ChatMsg(text: 'The painting is beautiful!', timestamp: DateTime.now().subtract(const Duration(days: 1)), isVendor: false),
      ],
    ),
    _Convo(
      id: 'm4', customerName: 'Kelechi Nwosu', product: 'Leather Pouch',
      lastMessage: 'When will it be restocked?', lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unread: true, online: false,
      messages: [
        _ChatMsg(text: 'When will it be restocked?', timestamp: DateTime.now().subtract(const Duration(days: 2)), isVendor: false),
      ],
    ),
    _Convo(
      id: 'm5', customerName: 'Chioma Obi', product: null,
      lastMessage: 'Do you do custom orders?', lastMessageTime: DateTime.now().subtract(const Duration(days: 3)),
      unread: false, online: true,
      messages: [
        _ChatMsg(text: 'Do you do custom orders?', timestamp: DateTime.now().subtract(const Duration(days: 3)), isVendor: false),
        _ChatMsg(text: 'Yes we do! What do you have in mind?', timestamp: DateTime.now().subtract(const Duration(days: 3)).add(const Duration(minutes: 10)), isVendor: true),
      ],
    ),
  ];

  _Convo? get _selectedConversation {
    try {
      return _conversations.firstWhere((c) => c.id == _selectedConversationId);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Messages', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: isWide
          ? Row(
              children: [
                SizedBox(width: 300, child: _buildConversationList()),
                const VerticalDivider(width: 1),
                Expanded(child: _selectedConversation != null ? _buildChatArea() : _buildNoChatSelected()),
              ],
            )
          : _selectedConversation != null
              ? _buildChatArea()
              : _buildConversationList(),
    );
  }

  Widget _buildConversationList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search conversations...',
              prefixIcon: const Icon(Icons.search, size: 18),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
              isDense: true,
            ),
            style: GoogleFonts.inter(fontSize: 13),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _conversations.length,
            itemBuilder: (_, i) {
              final c = _conversations[i];
              final isSelected = c.id == _selectedConversationId;
              return GestureDetector(
                onTap: () => setState(() => _selectedConversationId = c.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryContainer : Colors.white,
                    border: Border(
                      left: BorderSide(color: isSelected ? AppColors.accent : Colors.transparent, width: 3),
                      bottom: const BorderSide(color: AppColors.border, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(radius: 18, backgroundColor: AppColors.primaryContainer,
                            child: Text(c.customerName[0], style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: AppColors.primary))),
                          if (c.online)
                            Positioned(right: 0, bottom: 0,
                              child: Container(width: 10, height: 10,
                                decoration: const BoxDecoration(color: AppColors.onlineDot, shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2))),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(c.customerName, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600))),
                                Text(_timeAgo(c.lastMessageTime), style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                              ],
                            ),
                            if (c.product != null)
                              Text(c.product!, style: GoogleFonts.inter(fontSize: 10, color: AppColors.accent)),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(c.lastMessage, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
                                    maxLines: 1, overflow: TextOverflow.ellipsis),
                                ),
                                if (c.unread)
                                  Container(width: 8, height: 8,
                                    decoration: const BoxDecoration(color: AppColors.unreadDot, shape: BoxShape.circle)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatArea() {
    final convo = _selectedConversation!;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: AppColors.border))),
          child: Row(
            children: [
              CircleAvatar(radius: 16, backgroundColor: AppColors.primaryContainer,
                child: Text(convo.customerName[0], style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: AppColors.primary, fontSize: 12))),
              const SizedBox(width: 8),
              Expanded(child: Text(convo.customerName, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600))),
              IconButton(icon: const Icon(Icons.phone, size: 18), onPressed: () => setState(() { _inCall = true; _callSeconds = 0; })),
              IconButton(icon: const Icon(Icons.videocam, size: 18), onPressed: () {}),
            ],
          ),
        ),
        if (_inCall)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(Icons.phone_in_talk, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text('Voice call • ${_formatCallTime(_callSeconds)}', style: GoogleFonts.inter(color: Colors.white, fontSize: 12)),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => _inCall = false),
                  child: Container(padding: const EdgeInsets.all(4), decoration: const ShapeDecoration(color: Colors.red, shape: CircleBorder()),
                    child: const Icon(Icons.call_end, color: Colors.white, size: 14)),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: convo.messages.length,
            itemBuilder: (_, i) {
              final msg = convo.messages[i];
              return Align(
                alignment: msg.isVendor ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: msg.isVendor ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(12).copyWith(
                      bottomRight: msg.isVendor ? const Radius.circular(2) : null,
                      bottomLeft: msg.isVendor ? null : const Radius.circular(2),
                    ),
                    border: msg.isVendor ? null : Border.all(color: AppColors.border),
                  ),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Text(msg.text, style: GoogleFonts.inter(fontSize: 13, color: msg.isVendor ? Colors.white : AppColors.textPrimary)),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border))),
          child: Row(
            children: [
              const Icon(Icons.attach_file, size: 20, color: AppColors.textHint),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _msgCtrl,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  style: GoogleFonts.inter(fontSize: 13),
                  onSubmitted: (v) {
                    if (v.trim().isEmpty) return;
                    setState(() {
                      final idx = _conversations.indexWhere((c) => c.id == convo.id);
                      if (idx != -1) {
                        _conversations[idx].messages.add(_ChatMsg(text: v.trim(), timestamp: DateTime.now(), isVendor: true));
                      }
                      _msgCtrl.clear();
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (_msgCtrl.text.trim().isEmpty) return;
                  setState(() {
                    final idx = _conversations.indexWhere((c) => c.id == convo.id);
                    if (idx != -1) {
                      _conversations[idx].messages.add(_ChatMsg(text: _msgCtrl.text.trim(), timestamp: DateTime.now(), isVendor: true));
                    }
                    _msgCtrl.clear();
                  });
                },
                child: Container(padding: const EdgeInsets.all(8),
                  decoration: const ShapeDecoration(color: AppColors.accent, shape: CircleBorder()),
                  child: const Icon(Icons.send, color: Colors.white, size: 16)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoChatSelected() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.chat_bubble_outline, size: 48, color: AppColors.textHint),
          const SizedBox(height: 8),
          Text('Select a conversation', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${date.day}/${date.month}';
  }

  String _formatCallTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
