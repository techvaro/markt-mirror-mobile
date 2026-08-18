import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class OrderTrackingScreen extends StatelessWidget {
  final BuyerOrder order;
  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Track Order', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.orderNumber, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('Placed on ${order.placedAt.day}/${order.placedAt.month}/${order.placedAt.year} at ${order.placedAt.hour}:${order.placedAt.minute.toString().padLeft(2, '0')}', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary)),
                ],
              ),
            ),
            _TrackingTimeline(order: order),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items in Order', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 10),
                  ...order.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.shopping_bag, size: 20, color: AppColors.primary)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                              Row(
                                children: [
                                  if (item.variant.isNotEmpty) Text(item.variant, style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                                  if (item.variant.isNotEmpty) const Text(' | ', style: TextStyle(color: AppColors.textHint)),
                                  Text('x${item.quantity}', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textSecondary)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text('₦${item.total.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 10),
                  _sumRow('Subtotal', order.subtotal),
                  _sumRow('Delivery Fee', order.deliveryFee),
                  const Divider(height: 10),
                  _sumRow('Total', order.total, isBold: true),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Address', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(order.address.fullName, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textPrimary)),
                  Text(order.address.phone, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                  Text(order.address.fullAddress, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (order.status != OrderStatus.delivered && order.status != OrderStatus.cancelled) ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity, height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RiderTrackingScreen(order: order))),
                    icon: const Icon(Icons.map, size: 20),
                    label: Text('Track Rider Live', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sumRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.sourceSans3(fontSize: isBold ? 15 : 13, fontWeight: isBold ? FontWeight.w600 : FontWeight.normal, color: AppColors.textSecondary)),
          Text('₦${amount.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: isBold ? 16 : 13, fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _TrackingTimeline extends StatelessWidget {
  final BuyerOrder order;
  const _TrackingTimeline({required this.order});

  @override
  Widget build(BuildContext context) {
    final isCancelled = order.status == OrderStatus.cancelled;

    final stages = [
      {'label': 'Order Confirmed', 'status': OrderStatus.confirmed},
      {'label': 'Vendor Packing', 'status': OrderStatus.packing},
      {'label': 'Out for Delivery', 'status': OrderStatus.outForDelivery},
      {'label': 'Delivered', 'status': OrderStatus.delivered},
    ];

    int currentIndex = stages.indexWhere((s) => s['status'] == order.status);
    if (currentIndex == -1) currentIndex = isCancelled ? 0 : 0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: isCancelled
        ? Column(
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: AppColors.error.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.cancel, color: AppColors.error, size: 32),
              ),
              const SizedBox(height: 10),
              Text('Order Cancelled', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.error)),
              const SizedBox(height: 4),
              Text(order.cancellationReason ?? 'No reason provided', style: GoogleFonts.sourceSans3(fontSize: 13, color: AppColors.textSecondary)),
            ],
          )
        : Column(
            children: List.generate(stages.length, (i) {
              final stage = stages[i]['label'] as String;
              final stageStatus = stages[i]['status'] as OrderStatus;
              final isCompleted = order.status.index > stageStatus.index;
              final isCurrent = order.status == stageStatus;
              final isLast = i == stages.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted || isCurrent ? AppColors.primary : AppColors.border,
                        ),
                        child: Center(
                          child: isCompleted
                            ? const Icon(Icons.check, size: 16, color: Colors.white)
                            : isCurrent
                              ? Container(width: 12, height: 12, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white))
                              : Icon(Icons.circle, size: 10, color: AppColors.textHint),
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2, height: 36,
                          color: isCompleted ? AppColors.primary : AppColors.border,
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(stage, style: GoogleFonts.poppins(fontSize: 14, fontWeight: isCurrent || isCompleted ? FontWeight.w600 : FontWeight.normal, color: isCurrent ? AppColors.primary : (isCompleted ? AppColors.textPrimary : AppColors.textHint))),
                          if (isCurrent) ...[
                            const SizedBox(height: 2),
                            Text('In progress', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.primary)),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
    );
  }
}

class RiderTrackingScreen extends StatefulWidget {
  final BuyerOrder order;
  const RiderTrackingScreen({super.key, required this.order});

  @override
  State<RiderTrackingScreen> createState() => _RiderTrackingScreenState();
}

class _RiderTrackingScreenState extends State<RiderTrackingScreen> {
  late double _progress = 0.12;
  Timer? _timer;
  int _ticks = 0;

  static const _riderNames = ['Emeka Okafor', 'Tunde Bakare', 'Chinedu Nwosu', 'Bello Adewale'];

  String get _riderName {
    final seed = widget.order.orderNumber.codeUnits.fold<int>(0, (sum, c) => sum + c);
    return _riderNames[seed % _riderNames.length];
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      setState(() {
        _ticks++;
        _progress = (0.12 + _ticks * 0.075).clamp(0.08, 0.94);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double get _minutesAway => 14 - (_progress * 12);

  void _callRider() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Call $_riderName', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
        content: Text(widget.order.riderPhone, style: GoogleFonts.sourceSans3(fontSize: 14)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Calling $_riderName...', style: GoogleFonts.sourceSans3(fontSize: 13)), backgroundColor: AppColors.success));
            },
            child: Text('Call Now', style: GoogleFonts.sourceSans3(fontWeight: FontWeight.w700, color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Track Rider Live', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              height: 280,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  const Positioned.fill(child: CustomPaint(painter: _MapGridPainter())),
                  Positioned.fill(child: CustomPaint(painter: _RoutePainter(progress: _progress))),
                  Positioned(left: 24, top: 30, child: _MapMarker(icon: Icons.storefront, label: 'Shop', color: AppColors.primary)),
                  Positioned(right: 24, bottom: 30, child: _MapMarker(icon: Icons.home, label: 'You', color: AppColors.success)),
                  Positioned(
                    top: 60,
                    left: 30 + (240 * _progress),
                    child: Transform.rotate(
                      angle: 0.9,
                      child: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6)]),
                        child: const Icon(Icons.two_wheeler, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16, top: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)]),
                      child: Text('Rider is ${_minutesAway.round()} min away', style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52, height: 52,
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                        child: Icon(Icons.two_wheeler, color: AppColors.primary, size: 26),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_riderName, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 13, color: AppColors.starActive),
                                const SizedBox(width: 3),
                                Text('4.9', style: GoogleFonts.sourceSans3(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                                const Text('  |  ', style: TextStyle(color: AppColors.textHint)),
                                Text(widget.order.riderPhone, style: GoogleFonts.sourceSans3(fontSize: 12, color: AppColors.textSecondary)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone, color: AppColors.success),
                        onPressed: _callRider,
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Picked up', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textHint)),
                            const SizedBox(height: 2),
                            Text('Computer Village', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward, size: 18, color: AppColors.textHint),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Delivering to', style: GoogleFonts.sourceSans3(fontSize: 11, color: AppColors.textHint)),
                            const SizedBox(height: 2),
                            Text(widget.order.address.fullAddress, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(value: _progress, minHeight: 6, backgroundColor: AppColors.border, color: AppColors.primary),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pickup', style: GoogleFonts.sourceSans3(fontSize: 10, color: AppColors.textHint)),
                      Text('${(_progress * 100).round()}% complete', style: GoogleFonts.sourceSans3(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      Text('Delivery', style: GoogleFonts.sourceSans3(fontSize: 10, color: AppColors.textHint)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _callRider,
                      icon: const Icon(Icons.phone_in_talk, size: 18),
                      label: Text('Call Rider', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
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
}

class _MapMarker extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _MapMarker({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34, height: 34,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6)]),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6)]),
          child: Text(label, style: GoogleFonts.sourceSans3(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
        ),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  const _MapGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withOpacity(0.4)
      ..strokeWidth = 1;
    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    final block = Paint()..color = AppColors.primary.withOpacity(0.06);
    for (double x = 0; x < size.width; x += spacing * 4) {
      for (double y = 0; y < size.height; y += spacing * 4) {
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x + 6, y + 6, spacing * 4 - 12, spacing * 4 - 12), const Radius.circular(8)), block);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MapGridPainter oldDelegate) => false;
}

class _RoutePainter extends CustomPainter {
  final double progress;
  const _RoutePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(44, 236)
      ..cubicTo(80, 120, 150, 100, 200, 76);
    final trace = Paint()
      ..color = AppColors.primary.withOpacity(0.25)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final live = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, trace);
    final pathMetric = path.computeMetrics().first;
    final cutPath = pathMetric.extractPath(0, pathMetric.length * progress);
    canvas.drawPath(cutPath, live);
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) => oldDelegate.progress != progress;
}
