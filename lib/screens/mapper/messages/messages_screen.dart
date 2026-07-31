import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _messageCtrl = TextEditingController();
  bool _showMobileList = true;

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();
    final isWide = MediaQuery.of(context).size.width > 600;

    if (isWide) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('Messages', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          backgroundColor: AppColors.surface,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
        body: Row(
          children: [
            SizedBox(
              width: 320,
              child: _ConversationList(
                conversations: provider.conversations,
                activeId: provider.activeConversationId,
                onSelect: (id) => provider.setActiveConversation(id),
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: provider.activeConversationId != null
                  ? _ChatArea(
                      conversation: provider.conversations.firstWhere((c) => c.id == provider.activeConversationId),
                      messages: provider.messages(provider.activeConversationId!),
                      messageCtrl: _messageCtrl,
                      isCallActive: provider.isCallActive,
                      onSend: () => _sendMessage(provider),
                      onToggleCall: () => provider.setCallActive(!provider.isCallActive),
                    )
                  : const Center(child: Text('Select a conversation', style: TextStyle(color: AppColors.textSecondary))),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _showMobileList ? 'Messages' : provider.conversations.where((c) => c.id == provider.activeConversationId).firstOrNull?.name ?? 'Chat',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: _showMobileList ? null : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => _showMobileList = true),
        ),
      ),
      body: _showMobileList
          ? _ConversationList(
              conversations: provider.conversations,
              activeId: provider.activeConversationId,
              onSelect: (id) {
                provider.setActiveConversation(id);
                setState(() => _showMobileList = false);
              },
            )
          : (provider.activeConversationId != null
              ? _ChatArea(
                  conversation: provider.conversations.firstWhere((c) => c.id == provider.activeConversationId),
                  messages: provider.messages(provider.activeConversationId!),
                  messageCtrl: _messageCtrl,
                  isCallActive: provider.isCallActive,
                  onSend: () => _sendMessage(provider),
                  onToggleCall: () => provider.setCallActive(!provider.isCallActive),
                )
              : const SizedBox.shrink()),
    );
  }

  void _sendMessage(MapperProvider provider) {
    if (_messageCtrl.text.trim().isEmpty) return;
    if (provider.activeConversationId == null) return;
    provider.sendMessage(provider.activeConversationId!, _messageCtrl.text.trim());
    _messageCtrl.clear();
  }
}

class _ConversationList extends StatelessWidget {
  final List<Conversation> conversations;
  final String? activeId;
  final ValueChanged<String> onSelect;
  const _ConversationList({required this.conversations, required this.activeId, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: conversations.length,
      itemBuilder: (_, i) {
        final c = conversations[i];
        final isActive = c.id == activeId;
        return Container(
          color: isActive ? AppColors.primaryContainer : null,
          child: ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(c.avatar, style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                if (c.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(color: AppColors.online, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    ),
                  ),
              ],
            ),
            title: Text(c.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
            subtitle: Text(c.lastMessage, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(c.lastTime, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textHint)),
                if (c.unreadCount > 0) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: Text('${c.unreadCount}', style: GoogleFonts.inter(fontSize: 9, color: Colors.white)),
                  ),
                ],
              ],
            ),
            onTap: () => onSelect(c.id),
          ),
        );
      },
    );
  }
}

class _ChatArea extends StatelessWidget {
  final Conversation conversation;
  final List<Message> messages;
  final TextEditingController messageCtrl;
  final bool isCallActive;
  final VoidCallback onSend, onToggleCall;
  const _ChatArea({
    required this.conversation,
    required this.messages,
    required this.messageCtrl,
    required this.isCallActive,
    required this.onSend,
    required this.onToggleCall,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ChatHeader(conversation: conversation, isCallActive: isCallActive, onToggleCall: onToggleCall),
        if (isCallActive)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppColors.successLight,
            child: Row(
              children: [
                const Icon(Icons.phone_in_talk, size: 16, color: AppColors.success),
                const SizedBox(width: 8),
                Text('Call in progress with ${conversation.name}', style: GoogleFonts.inter(fontSize: 13, color: AppColors.success)),
                const Spacer(),
                GestureDetector(
                  onTap: onToggleCall,
                  child: const Icon(Icons.call_end, color: AppColors.error, size: 20),
                ),
              ],
            ),
          ),
        Expanded(
          child: messages.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat_outlined, size: 48, color: AppColors.textHint),
                      const SizedBox(height: 8),
                      Text('No messages yet', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                      Text('Send a message to start chatting', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textHint)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (_, i) {
                    final m = messages[i];
                    final isMe = m.isMe;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.primary : AppColors.background,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 16 : 4),
                            bottomRight: Radius.circular(isMe ? 4 : 16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            if (!isMe)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Text(m.senderName, style: GoogleFonts.inter(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600)),
                              ),
                            Text(m.content, style: GoogleFonts.inter(fontSize: 13, color: isMe ? Colors.white : AppColors.textPrimary)),
                            const SizedBox(height: 2),
                            Text(formatTime(m.timestamp), style: GoogleFonts.inter(fontSize: 9, color: isMe ? Colors.white70 : AppColors.textHint)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, -2))],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.emoji_emotions_outlined, color: AppColors.textSecondary), onPressed: () {}),
                IconButton(icon: const Icon(Icons.attach_file_outlined, color: AppColors.textSecondary), onPressed: () {}),
                Expanded(
                  child: TextField(
                    controller: messageCtrl,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: GoogleFonts.inter(color: AppColors.textHint),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    style: GoogleFonts.inter(fontSize: 14),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSend(),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.primary),
                  onPressed: onSend,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatHeader extends StatelessWidget {
  final Conversation conversation;
  final bool isCallActive;
  final VoidCallback onToggleCall;
  const _ChatHeader({required this.conversation, required this.isCallActive, required this.onToggleCall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text(conversation.avatar, style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              if (conversation.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(color: AppColors.online, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(conversation.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                Text(conversation.isOnline ? 'Online' : 'Offline', style: GoogleFonts.inter(fontSize: 11, color: conversation.isOnline ? AppColors.online : AppColors.textSecondary)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(isCallActive ? Icons.call_end : Icons.phone, color: isCallActive ? AppColors.error : AppColors.success),
            onPressed: onToggleCall,
          ),
        ],
      ),
    );
  }
}
