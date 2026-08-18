import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

/// Brand logo mark + wordmark, mirroring the website's [Logo] component.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 32,
    this.showText = true,
    this.textColor,
    this.light = false,
  });

  /// Diameter of the logo mark in logical pixels.
  final double size;

  /// Whether to render the "Market Mirror" wordmark next to the mark.
  final bool showText;

  /// Overrides the wordmark color. Defaults to brand primary (or white when [light]).
  final Color? textColor;

  /// Renders the wordmark in white for use on dark/colored backgrounds.
  final bool light;

  @override
  Widget build(BuildContext context) {
    final mark = Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(size * 0.3),
        ),
        child: Icon(Icons.store_rounded, size: size * 0.6, color: Colors.white),
      ),
    );

    if (!showText) return mark;

    final color = textColor ?? (light ? Colors.white : AppColors.primary);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(width: 8),
        Text(
          'Market Mirror',
          style: GoogleFonts.poppins(
            fontSize: size * 0.55,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
