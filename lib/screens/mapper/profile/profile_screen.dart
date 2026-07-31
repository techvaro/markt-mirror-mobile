import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  bool _isEditing = false;
  bool _showPasswordSection = false;

  final _profile = const UserProfile();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: _profile.name);
    _emailCtrl = TextEditingController(text: _profile.email);
    _phoneCtrl = TextEditingController(text: _profile.phone);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _saveProfile() {
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully'), backgroundColor: AppColors.success),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('My Profile', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit_outlined),
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        child: Text(
                          _profile.name.split(' ').map((e) => e[0]).join(),
                          style: GoogleFonts.inter(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Camera opened for photo upload')),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(_profile.name, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                    child: Text(_profile.role, style: GoogleFonts.inter(fontSize: 12, color: Colors.white)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _infoChip(Icons.badge, _profile.employeeId),
                      const SizedBox(width: 12),
                      _infoChip(Icons.location_on, _profile.region),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Personal Information', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  _profileField('Full Name', _nameCtrl, enabled: _isEditing),
                  const SizedBox(height: 12),
                  _profileField('Employee ID', TextEditingController(text: _profile.employeeId), enabled: false),
                  const SizedBox(height: 12),
                  _profileField('Email', _emailCtrl, enabled: _isEditing),
                  const SizedBox(height: 12),
                  _profileField('Phone', _phoneCtrl, enabled: _isEditing, keyboardType: TextInputType.phone),
                  const SizedBox(height: 12),
                  _profileField('Region', TextEditingController(text: _profile.region), enabled: false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Security', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.lock_outline, color: AppColors.primary),
                    title: Text('Change Password', style: GoogleFonts.inter(fontSize: 14)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      setState(() => _showPasswordSection = !_showPasswordSection);
                    },
                  ),
                  if (_showPasswordSection) ...[
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        labelStyle: GoogleFonts.inter(fontSize: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle: GoogleFonts.inter(fontSize: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password changed successfully'), backgroundColor: AppColors.success),
                        ),
                        child: Text('Update Password', style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.security, color: AppColors.primary),
                    title: Text('Two-Factor Authentication', style: GoogleFonts.inter(fontSize: 14)),
                    subtitle: Text('Add extra security', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('2FA setup page opened')),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white70),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _profileField(String label, TextEditingController ctrl, {bool enabled = true, TextInputType? keyboardType}) {
    return TextField(
      controller: ctrl,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(fontSize: 14, color: enabled ? AppColors.textSecondary : AppColors.textHint),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: !enabled,
        fillColor: enabled ? null : AppColors.background,
      ),
      style: GoogleFonts.inter(fontSize: 14, color: enabled ? AppColors.textPrimary : AppColors.textSecondary),
    );
  }
}
