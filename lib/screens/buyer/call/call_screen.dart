import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

class CallScreen extends StatefulWidget {
  final String contactName;
  final bool isVideoCall;

  const CallScreen({super.key, required this.contactName, this.isVideoCall = false});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _isMuted = false;
  bool _isCameraOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              const Spacer(flex: 2),
              Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.contactName.isNotEmpty ? widget.contactName[0].toUpperCase() : 'C',
                    style: GoogleFonts.poppins(fontSize: 42, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.contactName,
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isVideoCall ? 'Video call • connected' : 'Voice call • connected',
                style: GoogleFonts.sourceSans3(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Prototype demo call',
                  style: GoogleFonts.sourceSans3(fontSize: 12, color: Colors.white70),
                ),
              ),
              const Spacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    label: _isMuted ? 'Unmute' : 'Mute',
                    onTap: () => setState(() => _isMuted = !_isMuted),
                  ),
                  if (widget.isVideoCall)
                    _ActionButton(
                      icon: _isCameraOff ? Icons.videocam_off : Icons.videocam,
                      label: _isCameraOff ? 'Camera on' : 'Camera off',
                      onTap: () => setState(() => _isCameraOff = !_isCameraOff),
                    ),
                  _ActionButton(
                    icon: Icons.call_end,
                    label: 'End',
                    color: AppColors.error,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _ActionButton({super.key, required this.icon, required this.label, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color ?? Colors.white.withOpacity(0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.sourceSans3(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}
