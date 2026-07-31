import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapperProvider>();
    final stats = provider.stats;
    final coverage = provider.marketCoverage;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Analytics', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tasks Over Time', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: _AreaChartPainter(),
              ),
            ),
            const SizedBox(height: 20),
            Text('Market Coverage', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: CustomPaint(
                      size: const Size(140, 140),
                      painter: _DonutChartPainter(coverage: coverage),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: coverage.map((m) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: m.color, shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            Expanded(child: Text(m.name, style: GoogleFonts.inter(fontSize: 13))),
                            Text('${m.percentage.toInt()}%', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Summary', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                _SummaryCard(label: 'Total Tasks', value: '${stats.tasksCompleted + stats.inProgress + stats.pendingReview}', icon: Icons.list_alt, color: AppColors.primary),
                const SizedBox(width: 8),
                _SummaryCard(label: 'Completed', value: '${stats.tasksCompleted}', icon: Icons.task_alt, color: AppColors.success),
                const SizedBox(width: 8),
                _SummaryCard(label: 'Approval Rate', value: '${stats.performance.toInt()}%', icon: Icons.trending_up, color: AppColors.accent),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _AreaChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final completedData = [20, 35, 28, 42, 38, 47, 45];
    final rejectedData = [2, 3, 1, 4, 2, 3, 1];
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final gridPaint = Paint()..color = AppColors.chartGrid..strokeWidth = 0.5;
    for (double y = 0; y < size.height; y += size.height / 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final chartLeft = 30.0;
    final chartBottom = size.height - 20.0;
    final chartWidth = size.width - chartLeft - 10;
    final chartHeight = size.height - 40;
    final maxVal = 50.0;

    if (completedData.length < 2) return;
    final stepX = chartWidth / (completedData.length - 1);

    for (int pass = 0; pass < 2; pass++) {
      final data = pass == 0 ? completedData : rejectedData;
      final color = pass == 0 ? AppColors.chartFill : AppColors.chartFillAlt;
      final lineColor = pass == 0 ? AppColors.chartLine : AppColors.chartLineAlt;

      final path = Path();
      final points = <Offset>[];
      for (int i = 0; i < data.length; i++) {
        final x = chartLeft + i * stepX;
        final y = chartBottom - (data[i] / maxVal) * chartHeight;
        points.add(Offset(x, y));
      }
      if (points.isEmpty) return;

      path.moveTo(points[0].dx, chartBottom);
      for (int i = 0; i < points.length; i++) {
        if (i == 0) {
          path.lineTo(points[i].dx, points[i].dy);
        } else {
          final prev = points[i - 1];
          final ctrl1 = Offset((prev.dx + points[i].dx) / 2, prev.dy);
          final ctrl2 = Offset((prev.dx + points[i].dx) / 2, points[i].dy);
          path.cubicTo(ctrl1.dx, ctrl1.dy, ctrl2.dx, ctrl2.dy, points[i].dx, points[i].dy);
        }
      }
      path.lineTo(points.last.dx, chartBottom);
      path.close();
      canvas.drawPath(path, Paint()..color = color);

      final linePath = Path();
      linePath.moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        final prev = points[i - 1];
        final ctrl1 = Offset((prev.dx + points[i].dx) / 2, prev.dy);
        final ctrl2 = Offset((prev.dx + points[i].dx) / 2, points[i].dy);
        linePath.cubicTo(ctrl1.dx, ctrl1.dy, ctrl2.dx, ctrl2.dy, points[i].dx, points[i].dy);
      }
      canvas.drawPath(linePath, Paint()..color = lineColor..style = PaintingStyle.stroke..strokeWidth = 2);

      for (final point in points) {
        canvas.drawCircle(point, 3, Paint()..color = lineColor);
      }
    }

    for (int i = 0; i < labels.length; i++) {
      final x = chartLeft + i * stepX;
      final tp = TextPainter(text: TextSpan(text: labels[i], style: TextStyle(color: AppColors.textHint, fontSize: 9)), textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(x - tp.width / 2, chartBottom + 5));
    }

    final legendPaint = Paint()..color = AppColors.chartLine;
    canvas.drawRect(Rect.fromLTWH(chartLeft, 5, 12, 8), legendPaint);
    final t1 = TextPainter(text: TextSpan(text: ' Completed', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)), textDirection: TextDirection.ltr);
    t1.layout();
    t1.paint(canvas, Offset(chartLeft + 16, 3));

    canvas.drawRect(Rect.fromLTWH(chartLeft + 80, 5, 12, 8), Paint()..color = AppColors.chartLineAlt);
    final t2 = TextPainter(text: TextSpan(text: ' Rejected', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)), textDirection: TextDirection.ltr);
    t2.layout();
    t2.paint(canvas, Offset(chartLeft + 96, 3));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _DonutChartPainter extends CustomPainter {
  final List<dynamic> coverage;
  _DonutChartPainter({required this.coverage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final innerRadius = radius * 0.6;

    double startAngle = -1.5708;
    for (final m in coverage as List) {
      final sweepAngle = 6.2832 * (m.percentage / 100);
      final paint = Paint()
        ..color = m.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius - innerRadius
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(Rect.fromCircle(center: center, radius: (radius + innerRadius) / 2), startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _SummaryCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _SummaryCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
