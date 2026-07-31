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
                    onPressed: () {},
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
