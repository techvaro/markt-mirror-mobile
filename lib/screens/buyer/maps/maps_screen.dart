import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';
import 'package:market_mirror_mobile/providers/market_provider.dart';
import 'package:market_mirror_mobile/widgets/chat_icon_button.dart';
import 'package:market_mirror_mobile/widgets/city_market_selector.dart';
import 'package:provider/provider.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  String _selectedZone = 'All';
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();

  final List<_MarketZone> _zones = [
    _MarketZone(name: 'Zone A', category: 'Electronics', color: const Color(0xFF173B7B), rect: const Rect.fromLTWH(10, 10, 35, 40)),
    _MarketZone(name: 'Zone B', category: 'Phones & Gadgets', color: const Color(0xFF7C3AED), rect: const Rect.fromLTWH(55, 10, 35, 40)),
    _MarketZone(name: 'Zone C', category: 'Fabrics', color: const Color(0xFFEF4444), rect: const Rect.fromLTWH(10, 55, 35, 35)),
    _MarketZone(name: 'Zone D', category: 'Home Appliances', color: const Color(0xFF22C55E), rect: const Rect.fromLTWH(55, 55, 35, 35)),
    _MarketZone(name: 'Zone E', category: 'Auto Parts', color: const Color(0xFFF59E0B), rect: const Rect.fromLTWH(10, 95, 80, 20)),
  ];

  final List<_MapShop> _mapShops = [
    _MapShop(id: 's1', name: 'TechCity', zone: 'Zone A', stall: 'A12', category: 'Electronics', pos: const Offset(22, 22)),
    _MapShop(id: 's2', name: 'PhoneHub', zone: 'Zone B', stall: 'B5', category: 'Phones', pos: const Offset(67, 22)),
    _MapShop(id: 's3', name: 'GlobalFabrics', zone: 'Zone C', stall: 'C8', category: 'Fabrics', pos: const Offset(22, 67)),
    _MapShop(id: 's4', name: "Kemi's Appliances", zone: 'Zone D', stall: 'D15', category: 'Appliances', pos: const Offset(67, 67)),
    _MapShop(id: 's5', name: 'AutoParts Pro', zone: 'Zone E', stall: 'E7', category: 'Auto', pos: const Offset(35, 102)),
    _MapShop(id: 's6', name: 'BeautyGlow', zone: 'Zone A', stall: 'A5', category: 'Beauty', pos: const Offset(28, 30)),
    _MapShop(id: 's7', name: 'FashionHub', zone: 'Zone C', stall: 'C3', category: 'Fashion', pos: const Offset(18, 62)),
    _MapShop(id: 's8', name: 'FoodMarket', zone: 'Zone D', stall: 'D8', category: 'Groceries', pos: const Offset(62, 72)),
  ];

  List<_MapShop> get _filteredShops {
    var list = _mapShops;
    if (_selectedZone != 'All') {
      list = list.where((s) => s.zone == _selectedZone).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((s) => s.name.toLowerCase().contains(q) || s.category.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  List<_MarketZone> get _filteredZones {
    if (_selectedZone == 'All') return _zones;
    return _zones.where((z) => z.name == _selectedZone).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMarket = context.watch<MarketProvider>().selectedMarket;
    final shops = _filteredShops;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Market Map', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
        actions: const [ChatIconButton()],
      ),
      body: Column(
        children: [
          const CityMarketSelector(),
          if (selectedMarket.isNotEmpty)
            Container(
              width: double.infinity,
              color: AppColors.primaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
                'You are viewing $selectedMarket',
                style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary),
              ),
            ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search shops or categories...',
                    prefixIcon: const Icon(Icons.search, size: 18),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(icon: const Icon(Icons.clear, size: 16), onPressed: () { _searchCtrl.clear(); setState(() => _searchQuery = ''); })
                        : null,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
                  ),
                  style: GoogleFonts.inter(fontSize: 13),
                  onChanged: (v) => setState(() => _searchQuery = v),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['All', ..._zones.map((z) => z.name)].map((z) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedZone = z),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: _selectedZone == z ? AppColors.primary : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _selectedZone == z ? AppColors.primary : AppColors.border),
                          ),
                          child: Text(z, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500,
                            color: _selectedZone == z ? Colors.white : AppColors.textSecondary)),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final mapW = constraints.maxWidth - 32;
                final mapH = mapW * 1.1;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: mapW,
                        height: mapH,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size(mapW, mapH),
                                painter: _MapPainter(zones: _filteredZones, allZones: _zones, shops: shops),
                              ),
                              ...shops.map((s) => Positioned(
                                left: (s.pos.dx / 100) * mapW - 14,
                                top: (s.pos.dy / 100) * mapH - 14,
                                child: GestureDetector(
                                  onTap: () => _showShopDialog(s),
                                  child: Container(
                                    width: 28, height: 28,
                                    decoration: BoxDecoration(
                                      color: _zoneColor(s.zone),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4)],
                                    ),
                                    child: const Icon(Icons.store, color: Colors.white, size: 14),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _zones.map((z) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(width: 10, height: 10, decoration: BoxDecoration(color: z.color, borderRadius: BorderRadius.circular(2))),
                              const SizedBox(width: 4),
                              Text(z.name, style: GoogleFonts.inter(fontSize: 9, color: AppColors.textSecondary)),
                            ],
                          ),
                        )).toList(),
                      ),
                      const SizedBox(height: 12),
                      if (shops.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text('No shops found', style: GoogleFonts.inter(color: AppColors.textSecondary)),
                        )
                      else
                        ...shops.map((s) => _buildShopTile(s)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _zoneColor(String zone) {
    final idx = _zones.indexWhere((z) => z.name == zone);
    return idx >= 0 ? _zones[idx].color : AppColors.primary;
  }

  Widget _buildShopTile(_MapShop s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Container(width: 40, height: 40,
            decoration: BoxDecoration(color: _zoneColor(s.zone).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.store, color: _zoneColor(s.zone), size: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                Text('${s.zone} • Stall ${s.stall} • ${s.category}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 16, color: AppColors.textHint),
        ],
      ),
    );
  }

  void _showShopDialog(_MapShop s) {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(width: 36, height: 36,
            decoration: BoxDecoration(color: _zoneColor(s.zone), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.store, color: Colors.white, size: 18)),
          const SizedBox(width: 10),
          Expanded(child: Text(s.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16))),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow('Zone', s.zone),
          _infoRow('Stall', s.stall),
          _infoRow('Category', s.category),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ElevatedButton(onPressed: () { Navigator.pop(context); }, child: const Text('View Shop')),
      ],
    ));
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          Text(value, style: GoogleFonts.inter(fontSize: 12)),
        ],
      ),
    );
  }
}

class _MarketZone {
  final String name;
  final String category;
  final Color color;
  final Rect rect;
  _MarketZone({required this.name, required this.category, required this.color, required this.rect});
}

class _MapShop {
  final String id;
  final String name;
  final String zone;
  final String stall;
  final String category;
  final Offset pos;
  _MapShop({required this.id, required this.name, required this.zone, required this.stall, required this.category, required this.pos});
}

class _MapPainter extends CustomPainter {
  final List<_MarketZone> zones;
  final List<_MarketZone> allZones;
  final List<_MapShop> shops;

  _MapPainter({required this.zones, required this.allZones, required this.shops});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()..color = const Color(0xFFE8E8E8)..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += size.width / 10) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += size.height / 10) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (final zone in allZones) {
      final r = Rect.fromLTWH(
        zone.rect.left / 100 * size.width,
        zone.rect.top / 100 * size.height,
        zone.rect.width / 100 * size.width,
        zone.rect.height / 100 * size.height,
      );
      final isSelected = zones.contains(zone);
      canvas.drawRect(r, Paint()..color = zone.color.withValues(alpha: isSelected ? 0.2 : 0.08));
      canvas.drawRect(r, Paint()..color = zone.color.withValues(alpha: isSelected ? 0.5 : 0.2)..style = PaintingStyle.stroke..strokeWidth = isSelected ? 2 : 1);

      final tp = TextPainter(
        text: TextSpan(text: '${zone.name}\n${zone.category}', style: TextStyle(color: zone.color, fontSize: 11 * (size.width / 300), fontWeight: FontWeight.w600)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: r.width);
      tp.paint(canvas, Offset(r.center.dx - tp.width / 2, r.center.dy - tp.height / 2));
    }

    if (shops.isEmpty) {
      final tp = TextPainter(
        text: const TextSpan(text: 'No shops match your search', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _MapPainter old) => old.zones != zones || old.shops != shops;
}
