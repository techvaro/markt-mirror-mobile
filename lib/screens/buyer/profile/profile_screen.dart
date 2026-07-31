import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import '../static_pages/static_pages_screen.dart';
import '../vendor_pages/vendor_pages_screen.dart';
import '../disputes/disputes_screen.dart';
import '../chat/chat_list_screen.dart';
import '../orders/orders_screen.dart';
import '../notifications/notifications_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final _nameCtrl = TextEditingController(text: 'Chidi Okeke');
  final _emailCtrl = TextEditingController(text: 'chidi.okeke@email.com');
  final _phoneCtrl = TextEditingController(text: '+234 802 222 3333');
  final _locationCtrl = TextEditingController(text: 'Lagos, Nigeria');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('My Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
        actions: [
          TextButton(
            onPressed: () => setState(() => _isEditing = !_isEditing),
            child: Text(_isEditing ? 'Cancel' : 'Edit', style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text('CO', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white))),
                      ),
                      Positioned(
                        bottom: 0, right: -2,
                        child: Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                          child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('Chidi Okeke', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text('chidi.okeke@email.com', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.info.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                    child: Text('Buyer', style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.info)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (_isEditing) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Edit Profile', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                    _editField('Full Name', _nameCtrl),
                    const SizedBox(height: 10),
                    _editField('Email Address', _emailCtrl),
                    const SizedBox(height: 10),
                    _editField('Phone Number', _phoneCtrl),
                    const SizedBox(height: 10),
                    _editField('Location', _locationCtrl),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity, height: 46,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _isEditing = false),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
                        child: Text('Save Changes', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            _LinkSection(
              title: 'Quick Links',
              items: [
                {'icon': Icons.receipt_long, 'label': 'Order History', 'route': 'orders'},
                {'icon': Icons.location_on, 'label': 'Saved Addresses', 'route': 'addresses'},
                {'icon': Icons.payment, 'label': 'Payment Methods', 'route': 'payments'},
              ],
            ),
            const SizedBox(height: 12),
            _LinkSection(
              title: 'App Settings',
              items: [
                {'icon': Icons.notifications_outlined, 'label': 'Notifications', 'route': 'notifications'},
                {'icon': Icons.chat_bubble_outline, 'label': 'Messages', 'route': 'messages'},
                {'icon': Icons.phone_outlined, 'label': 'Calls & Video', 'route': 'calls'},
                {'icon': Icons.help_outline, 'label': 'Help Center', 'route': 'help'},
                {'icon': Icons.description_outlined, 'label': 'Terms & Privacy', 'route': 'terms'},
                {'icon': Icons.report_problem_outlined, 'label': 'Disputes', 'route': 'disputes'},
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity, height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout, size: 20),
                  label: Text('Sign Out', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.error)),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _editField(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      style: GoogleFonts.sourceSans3(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.primary)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: AppColors.background,
      ),
    );
  }
}

class _LinkSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  const _LinkSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          ),
          ...items.map((item) {
            final route = item['route'] as String?;
            return ListTile(
              leading: Icon(item['icon'] as IconData, color: AppColors.primary, size: 22),
              title: Text(item['label'] as String, style: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textPrimary)),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              dense: true,
              onTap: () {
                switch (route) {
                  case 'orders':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersScreen()));
                    break;
                  case 'messages':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatListScreen()));
                    break;
                  case 'disputes':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DisputesScreen()));
                    break;
                  case 'help':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const StaticPagesScreen()));
                    break;
                  case 'terms':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const StaticPagesScreen()));
                    break;
                  case 'notifications':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                    break;
                  case 'calls':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatListScreen()));
                    break;
                  case 'vendor':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const VendorPagesScreen()));
                    break;
                  default:
                    break;
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
