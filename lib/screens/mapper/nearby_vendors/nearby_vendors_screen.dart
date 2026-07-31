import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class NearbyVendorsScreen extends StatefulWidget {
  const NearbyVendorsScreen({super.key});

  @override
  State<NearbyVendorsScreen> createState() => _NearbyVendorsScreenState();
}

class _NearbyVendorsScreenState extends State<NearbyVendorsScreen> {
  double _selectedRadius = 5;

  final _vendors = [
    _NearbyVendor(name: 'Tech Emporium', category: 'Electronics', distance: '0.8 km', status: VendorStatus.approved, lat: -1.2820, lng: 36.8175),
    _NearbyVendor(name: 'Mama Mboga Greens', category: 'Fresh Produce', distance: '1.2 km', status: VendorStatus.pending, lat: -1.2860, lng: 36.8200),
    _NearbyVendor(name: 'Spice Corner', category: 'Spices & Herbs', distance: '2.1 km', status: VendorStatus.approved, lat: -1.2900, lng: 36.8100),
    _NearbyVendor(name: 'Fashion Hub', category: 'Clothing', distance: '2.5 km', status: VendorStatus.rejected, lat: -1.2780, lng: 36.8250),
    _NearbyVendor(name: 'Hardware Tools Ltd', category: 'Hardware', distance: '0.5 km', status: VendorStatus.pending, lat: -1.2840, lng: 36.8170),
    _NearbyVendor(name: 'Fresh Bites Café', category: 'Food & Bev.', distance: '3.2 km', status: VendorStatus.pending, lat: -1.2920, lng: 36.8220),
    _NearbyVendor(name: 'Green Pharmacy', category: 'Pharmacy', distance: '4.1 km', status: VendorStatus.approved, lat: -1.2950, lng: 36.8080),
  ];

  List<_NearbyVendor> get _filtered =>
      _vendors.where((v) => (double.tryParse(v.distance.replaceAll(' km', '')) ?? 0) <= _selectedRadius).toList();

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Nearby Vendors', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0FE),
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter: _MapPinsPainter(vendors: filtered),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(16)),
                    child: Text('${filtered.length} vendors', style: GoogleFonts.inter(fontSize: 12, color: Colors.white)),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [1, 5, 10].map((r) {
                        final selected = _selectedRadius == r;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedRadius = r.toDouble()),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: selected ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('$r km', style: GoogleFonts.inter(fontSize: 12, color: selected ? Colors.white : AppColors.textPrimary, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text('Vendors within ${_selectedRadius.toInt()} km', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  Expanded(
                    child: filtered.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.search_off, size: 48, color: AppColors.textHint),
                                const SizedBox(height: 8),
                                Text('No vendors found', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: filtered.length,
                            itemBuilder: (_, i) => _VendorListTile(vendor: filtered[i]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NearbyVendor {
  final String name, category, distance;
  final VendorStatus status;
  final double lat, lng;
  _NearbyVendor({required this.name, required this.category, required this.distance, required this.status, required this.lat, required this.lng});
}

class _MapPinsPainter extends CustomPainter {
  final List<_NearbyVendor> vendors;
  _MapPinsPainter({required this.vendors});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()..color = AppColors.mapGrid..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 25) canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    for (double y = 0; y < size.height; y += 25) canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    final roadPaint = Paint()..color = AppColors.mapRoad..strokeWidth = 2;
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), roadPaint);

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 15, Paint()..color = AppColors.mapPinPulse);
    canvas.drawCircle(center, 8, Paint()..color = AppColors.mapPinMapper..style = PaintingStyle.fill);
    canvas.drawCircle(center, 8, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 2);
    canvas.drawCircle(center, 3, Paint()..color = AppColors.mapPinMapper..style = PaintingStyle.fill);

    final rng = Random(42);
    for (final v in vendors) {
      final px = (v.lat + 1.3) / 0.02 * 30 + size.width * 0.1;
      final py = (v.lng - 36.8) / 0.03 * 30 + size.height * 0.1;
      final offset = Offset(px % size.width, py % size.height);
      Color pinColor;
      switch (v.status) {
        case VendorStatus.approved: pinColor = AppColors.mapPinApproved;
        case VendorStatus.rejected: pinColor = AppColors.mapPinRejected;
        case VendorStatus.pending: pinColor = AppColors.mapPinPending;
      }
      canvas.drawCircle(offset, 6, Paint()..color = pinColor..style = PaintingStyle.fill);
      canvas.drawCircle(offset, 6, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 1.5);
      canvas.drawCircle(offset, 3, Paint()..color = pinColor..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant _MapPinsPainter old) => old.vendors != vendors;
}

class _VendorListTile extends StatelessWidget {
  final _NearbyVendor vendor;
  const _VendorListTile({required this.vendor});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (vendor.status) {
      case VendorStatus.approved: statusColor = AppColors.success;
      case VendorStatus.rejected: statusColor = AppColors.error;
      case VendorStatus.pending: statusColor = AppColors.warning;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(vendor.name.split(' ').map((e) => e[0]).take(2).join(), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vendor.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(4)),
                      child: Text(vendor.category, style: GoogleFonts.inter(fontSize: 9, color: AppColors.primary)),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.near_me, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 2),
                    Text(vendor.distance, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Navigating to ${vendor.name}...')),
            ),
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
            child: Text('Navigate', style: GoogleFonts.inter(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
