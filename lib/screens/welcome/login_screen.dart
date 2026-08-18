import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/widgets/app_logo.dart';
import 'package:market_mirror_mobile/providers/auth_provider.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/screens/buyer/buyer_nav_shell.dart';
import 'package:market_mirror_mobile/screens/vendor/vendor_nav_shell.dart';
import 'package:market_mirror_mobile/screens/mapper/mapper_nav_shell.dart';
import 'package:market_mirror_mobile/screens/admin/admin_shell.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  UserRole _selectedRole = UserRole.buyer;
  bool _isSignup = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _navigateToRole(AppUser user) {
    Widget screen;
    switch (user.role) {
      case UserRole.vendor:
        screen = const VendorNavShell();
      case UserRole.mapper:
        screen = const MapperNavShell();
      case UserRole.admin:
        screen = const AdminShell();
      default:
        screen = const BuyerNavShell();
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
  }

  Future<void> _submit() async {
    final auth = context.read<AuthProvider>();
    bool success;
    if (_isSignup) {
      success = await auth.signup(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _phoneController.text.trim(),
        _passwordController.text,
        _selectedRole,
      );
    } else {
      success = await auth.login(_emailController.text.trim(), _passwordController.text);
    }
    if (success && mounted && auth.currentUser != null) {
      _navigateToRole(auth.currentUser!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Consumer<AuthProvider>(
            builder: (context, auth, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: AppLogo(size: 72, showText: false),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _isSignup ? 'Create Account' : 'Welcome Back',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isSignup ? 'Create your account to get started' : 'Sign in to continue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSans3(fontSize: 16, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 32),
                  if (_isSignup) ...[
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outline)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone_outlined)),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<UserRole>(
                      value: _selectedRole,
                      decoration: const InputDecoration(labelText: 'I want to', prefixIcon: Icon(Icons.person_outline)),
                      items: const [
                        DropdownMenuItem(value: UserRole.buyer, child: Text('Shop as a Buyer')),
                        DropdownMenuItem(value: UserRole.vendor, child: Text('Sell as a Vendor')),
                        DropdownMenuItem(value: UserRole.mapper, child: Text('Map as a Mapper')),
                      ],
                      onChanged: (v) => setState(() => _selectedRole = v ?? UserRole.buyer),
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  if (!_isSignup) ...[
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          auth.forgotPassword(_emailController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ResetPasswordScreen(email: _emailController.text.trim())),
                          );
                        },
                        child: const Text('Forgot Password?', style: TextStyle(color: AppColors.accent)),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  if (auth.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(auth.error!, style: const TextStyle(color: AppColors.error)),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: auth.isLoading ? null : _submit,
                      child: auth.isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : Text(_isSignup ? 'Create Account' : 'Sign In'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => setState(() => _isSignup = !_isSignup),
                      child: Text(
                        _isSignup ? 'Already have an account? Sign In' : "Don't have an account? Sign Up",
                        style: GoogleFonts.sourceSans3(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
