import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Connectivity & Sync'),
          _buildSwitchTile(
            icon: Icons.wifi_off,
            title: 'Offline Mode',
            subtitle: 'Work without internet connection',
            value: !provider.isOnline,
            onChanged: (_) => provider.toggleOfflineMode(),
          ),
          _buildSwitchTile(
            icon: Icons.wifi,
            title: 'Auto-Sync on WiFi',
            subtitle: 'Sync data automatically when connected to WiFi',
            value: provider.autoSyncWifi,
            onChanged: (_) => provider.toggleAutoSyncWifi(),
          ),
          const SizedBox(height: 16),
          _buildSectionHeader('Location & GPS'),
          _buildDropdownTile(
            icon: Icons.gps_fixed,
            title: 'Required GPS Accuracy',
            value: provider.gpsAccuracy,
            items: const ['High', 'Medium', 'Low'],
            onChanged: (v) => provider.setGpsAccuracy(v),
          ),
          const SizedBox(height: 16),
          _buildSectionHeader('Media & Uploads'),
          _buildDropdownTile(
            icon: Icons.compress,
            title: 'Photo Compression',
            value: provider.photoCompression,
            items: const ['High', 'Standard', 'Low'],
            onChanged: (v) => provider.setPhotoCompression(v),
          ),
          _buildSwitchTile(
            icon: Icons.photo_library,
            title: 'Save Original Photos',
            subtitle: 'Keep original quality photos alongside compressed versions',
            value: provider.saveOriginalPhotos,
            onChanged: (_) => provider.toggleSaveOriginalPhotos(),
          ),
          const SizedBox(height: 16),
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(
            icon: Icons.notifications_active,
            title: 'Push Notifications',
            subtitle: 'Receive push notifications for updates',
            value: provider.pushNotifications,
            onChanged: (_) => provider.togglePushNotifications(),
          ),
          _buildSwitchTile(
            icon: Icons.approval,
            title: 'Approval Alerts',
            subtitle: 'Get notified when vendors are approved or rejected',
            value: provider.approvalAlerts,
            onChanged: (_) => provider.toggleApprovalAlerts(),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showSignOutDialog(context),
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: Text('Sign Out', style: GoogleFonts.inter(color: AppColors.error, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: AppColors.error),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        secondary: Icon(icon, color: AppColors.primary),
        title: Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isDense: true,
                    items: items.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: GoogleFonts.inter(fontSize: 13)),
                    )).toList(),
                    onChanged: (v) { if (v != null) onChanged(v); },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Sign Out', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        content: Text('Are you sure you want to sign out?', style: GoogleFonts.inter(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.inter()),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out successfully')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('Sign Out', style: GoogleFonts.inter()),
          ),
        ],
      ),
    );
  }
}
