import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/providers/vendor_provider.dart';
import 'package:market_mirror_mobile/screens/vendor/shop_profile/shop_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final List<String> _tabs = ['Business Profile', 'Security', 'Notifications', 'Preferences'];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Settings', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    user?.name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').join().toUpperCase() ?? 'V',
                    style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user?.name ?? 'Vendor', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text('Shop Name', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18, color: AppColors.primary),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopProfileScreen())),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabCtrl,
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textHint,
              indicatorColor: AppColors.primary,
              labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                _buildBusinessProfileTab(),
                _buildSecurityTab(),
                _buildNotificationsTab(),
                _buildPreferencesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _settingsCard('Contact Information', [
            _infoField('Shop Name', 'Chidi\'s Crafts'),
            _infoField('Business Email', 'chidi@craftmarket.com'),
            _infoField('Phone Number', '+234 812 345 6789'),
          ]),
          const SizedBox(height: 12),
          _settingsCard('Business Address', [
            _infoField('Address', '12B Market Road'),
            _infoField('City', 'Ikeja, Lagos'),
            _infoField('State', 'Lagos'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSecurityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _settingsCard('Security', [
            ListTile(
              leading: const Icon(Icons.lock_outline, color: AppColors.primary),
              title: Text('Change Password', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
              onTap: () {},
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(height: 1),
            SwitchListTile(
              secondary: const Icon(Icons.fingerprint, color: AppColors.primary),
              title: Text('Two-Factor Authentication', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
              value: true,
              activeColor: AppColors.primary,
              onChanged: (v) {},
              contentPadding: EdgeInsets.zero,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _settingsCard('Notification Preferences', [
            _notifToggle('New Orders', 'Get notified when you receive a new order', true),
            const Divider(height: 1),
            _notifToggle('Low Stock Alerts', 'Get notified when products are low in stock', true),
            const Divider(height: 1),
            _notifToggle('New Reviews', 'Get notified when customers leave reviews', false),
            const Divider(height: 1),
            _notifToggle('Marketing Updates', 'Get notified about platform promotions', false),
          ]),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _settingsCard('Preferences', [
            _prefRow('Theme', 'Light'),
            const Divider(height: 1),
            _prefRow('Language', 'English'),
            const Divider(height: 1),
            _prefRow('Timezone', 'WAT (UTC+1)'),
          ]),
        ],
      ),
    );
  }

  Widget _settingsCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
          Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _notifToggle(String title, String subtitle, bool value) {
    return SwitchListTile(
      title: Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
      value: value,
      activeColor: AppColors.primary,
      onChanged: (v) {},
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _prefRow(String label, String value) {
    return ListTile(
      title: Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, size: 16, color: AppColors.textHint),
        ],
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
