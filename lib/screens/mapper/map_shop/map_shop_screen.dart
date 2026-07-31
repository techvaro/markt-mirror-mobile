import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';

class MapShopScreen extends StatefulWidget {
  const MapShopScreen({super.key});

  @override
  State<MapShopScreen> createState() => _MapShopScreenState();
}

class _MapShopScreenState extends State<MapShopScreen> {
  bool _gpsAcquired = false;
  bool _isLocating = false;
  double _latitude = 0;
  double _longitude = 0;
  double _accuracy = 0;
  String _selectedBlock = 'Block A';
  String _selectedSection = 'Section 1';
  final _landmarkCtrl = TextEditingController();

  final _blocks = ['Block A', 'Block B', 'Block C', 'Block D'];
  final _sections = ['Section 1', 'Section 2', 'Section 3'];

  @override
  void dispose() {
    _landmarkCtrl.dispose();
    super.dispose();
  }

  void _locateMe() {
    setState(() => _isLocating = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final rng = Random();
      setState(() {
        _latitude = -1.2833 + rng.nextDouble() * 0.008;
        _longitude = 36.8167 + rng.nextDouble() * 0.008;
        _accuracy = 1.2 + rng.nextDouble() * 3;
        _gpsAcquired = true;
        _isLocating = false;
      });
    });
  }

  void _confirmLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location confirmed: ${_latitude.toStringAsFixed(4)}, ${_longitude.toStringAsFixed(4)}'),
        backgroundColor: AppColors.success,
      ),
    );
    Navigator.pop(context, {'latitude': _latitude, 'longitude': _longitude});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Map Shop', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0FE),
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter: _MapGridPainter(gpsAcquired: _gpsAcquired),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.my_location, size: 48, color: _gpsAcquired ? AppColors.primary : AppColors.textHint),
                      const SizedBox(height: 4),
                      if (_gpsAcquired)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            '${_latitude.toStringAsFixed(4)}, ${_longitude.toStringAsFixed(4)}',
                            style: GoogleFonts.inter(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 48,
                        child: FilledButton.icon(
                          onPressed: _isLocating ? null : _locateMe,
                          icon: _isLocating
                              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.gps_fixed, size: 20),
                          label: Text('Locate Me', style: GoogleFonts.inter(fontSize: 13)),
                          style: FilledButton.styleFrom(
                            backgroundColor: _gpsAcquired ? AppColors.accent : AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_gpsAcquired)
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.success),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.gps_off, size: 14, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text('${_accuracy.toStringAsFixed(1)}m accuracy', style: GoogleFonts.inter(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location Details', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown('Market Block', _selectedBlock, _blocks, (v) => setState(() => _selectedBlock = v)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDropdown('Section', _selectedSection, _sections, (v) => setState(() => _selectedSection = v)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _landmarkCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nearby Landmark',
                        labelStyle: GoogleFonts.inter(fontSize: 14),
                        hintText: 'e.g. Near main entrance',
                        hintStyle: GoogleFonts.inter(color: AppColors.textHint),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _gpsAcquired ? _confirmLocation : null,
                        icon: const Icon(Icons.location_on, size: 18),
                        label: Text('Confirm Location', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: _gpsAcquired ? AppColors.success : AppColors.textHint,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        isDense: true,
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontSize: 13)))).toList(),
      onChanged: (v) { if (v != null) onChanged(v); },
      style: GoogleFonts.inter(fontSize: 14),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  final bool gpsAcquired;
  _MapGridPainter({required this.gpsAcquired});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()..color = AppColors.mapGrid..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 25) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 25) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    final roadPaint = Paint()..color = AppColors.mapRoad..strokeWidth = 3;
    canvas.drawLine(Offset(size.width * 0.2, 0), Offset(size.width * 0.2, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.5, 0), Offset(size.width * 0.5, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.8, 0), Offset(size.width * 0.8, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.6), Offset(size.width, size.height * 0.6), roadPaint);

    if (gpsAcquired) {
      final center = Offset(size.width / 2, size.height / 2);
      canvas.drawCircle(center, 20, Paint()..color = AppColors.mapPinMapper.withValues(alpha: 0.2));
      canvas.drawCircle(center, 8, Paint()..color = AppColors.mapPinMapper..style = PaintingStyle.fill);
      canvas.drawCircle(center, 8, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 2);
      canvas.drawCircle(center, 3, Paint()..color = AppColors.mapPinMapper..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant _MapGridPainter old) => old.gpsAcquired != gpsAcquired;
}
