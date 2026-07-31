import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/models/models.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int? _ratingFilter;
  final TextEditingController _replyCtrl = TextEditingController();
  String? _replyingTo;

  final List<Review> _reviews = [
    Review(id: 'r1', customerName: 'Amara Eze', date: DateTime.now().subtract(const Duration(days: 1)), rating: 5, comment: 'Absolutely beautiful craftsmanship! The basket exceeded my expectations. The colors are vibrant and the weave is tight and even.', productId: 'p1', productName: 'Handwoven Basket', reply: 'Thank you so much, Amara! We are glad you love the basket.'),
    Review(id: 'r2', customerName: 'Tunde Balogun', date: DateTime.now().subtract(const Duration(days: 3)), rating: 4, comment: 'Nice necklace, but the chain could be a bit longer. Otherwise great quality.', productId: 'p2', productName: 'Beaded Necklace'),
    Review(id: 'r3', customerName: 'Ngozi Okafor', date: DateTime.now().subtract(const Duration(days: 5)), rating: 5, comment: 'The painting is absolutely stunning! It looks even better in person.', productId: 'p3', productName: 'Canvas Painting'),
    Review(id: 'r4', customerName: 'Kelechi Nwosu', date: DateTime.now().subtract(const Duration(days: 7)), rating: 3, comment: 'The pouch is nice but smaller than I expected. Good quality though.', productId: 'p4', productName: 'Leather Pouch'),
    Review(id: 'r5', customerName: 'Chioma Obi', date: DateTime.now().subtract(const Duration(days: 10)), rating: 5, comment: 'Beautiful dress! Perfect for weddings and parties.', productId: 'p5', productName: 'Ankara Dress', reply: 'Thank you Chioma! We have more colors available too.'),
    Review(id: 'r6', customerName: 'Femi Adekunle', date: DateTime.now().subtract(const Duration(days: 14)), rating: 2, comment: 'The sculpture arrived with a small chip. Disappointed.', productId: 'p6', productName: 'Wooden Sculpture'),
    Review(id: 'r7', customerName: 'Zainab Abdullah', date: DateTime.now().subtract(const Duration(days: 20)), rating: 4, comment: 'Lovely sandals, very comfortable. True to size.', productId: 'p8', productName: 'Leather Sandals'),
  ];

  final _ratings = [5, 4, 3, 2, 1];

  List<Review> get _filteredReviews {
    var list = _reviews;
    if (_ratingFilter != null) {
      list = list.where((r) => r.rating == _ratingFilter).toList();
    }
    return list;
  }

  Map<int, int> get _ratingDistribution {
    final dist = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final r in _reviews) {
      final key = r.rating.round();
      dist[key] = (dist[key] ?? 0) + 1;
    }
    return dist;
  }

  double get _averageRating {
    if (_reviews.isEmpty) return 0;
    return _reviews.fold(0.0, (sum, r) => sum + r.rating) / _reviews.length;
  }

  @override
  void dispose() {
    _replyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = _filteredReviews;
    final dist = _ratingDistribution;
    final total = _reviews.length;
    final maxCount = dist.values.fold(0, (a, b) => a > b ? a : b);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Reviews', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(_averageRating.toStringAsFixed(1), style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      Row(
                        children: List.generate(5, (i) => Icon(
                          i < _averageRating.round() ? Icons.star : Icons.star_border,
                          size: 16, color: AppColors.starActive,
                        )),
                      ),
                      Text('$total reviews', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: _ratings.map((r) {
                        final count = dist[r] ?? 0;
                        final pct = maxCount > 0 ? (count / maxCount) : 0.0;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Text('$r', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
                              const SizedBox(width: 4),
                              const Icon(Icons.star, size: 10, color: AppColors.starActive),
                              const SizedBox(width: 4),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: LinearProgressIndicator(value: pct, minHeight: 5, backgroundColor: AppColors.ratingBarInactive, valueColor: const AlwaysStoppedAnimation<Color>(AppColors.ratingBarActive)),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text('$count', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterChip('All', _ratingFilter == null),
                  ..._ratings.map((r) => _filterChip('$r Star', _ratingFilter == r)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...reviews.map((r) => _buildReviewCard(r)),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: () => setState(() => _ratingFilter = selected ? null : int.tryParse(label.split(' ').first)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? AppColors.primary : AppColors.border),
          ),
          child: Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: selected ? Colors.white : AppColors.textSecondary)),
        ),
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 14, backgroundColor: AppColors.primaryContainer,
                child: Text(review.customerName.isNotEmpty ? review.customerName[0] : '?', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary))),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.customerName.isNotEmpty ? review.customerName : review.userName, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
                    Text(_timeAgo(review.date), style: GoogleFonts.inter(fontSize: 10, color: AppColors.textHint)),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (i) => Icon(
                  i < review.rating.round() ? Icons.star : Icons.star_border,
                  size: 14, color: AppColors.starActive,
                )),
              ),
            ],
          ),
          if (review.productName.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('Purchased: ${review.productName}', style: GoogleFonts.inter(fontSize: 10, color: AppColors.accent, fontWeight: FontWeight.w500)),
          ],
          const SizedBox(height: 6),
          Text(review.comment, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textPrimary, height: 1.4)),
          if (review.reply != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Reply:', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  const SizedBox(height: 2),
                  Text(review.reply!, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textPrimary)),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(height: 8),
            if (_replyingTo == review.id)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _replyCtrl,
                      decoration: InputDecoration(
                        hintText: 'Write your reply...',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      style: GoogleFonts.inter(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      if (_replyCtrl.text.trim().isEmpty) return;
                      setState(() {
                        final idx = _reviews.indexWhere((r) => r.id == review.id);
                        if (idx != -1) {
                          final r = _reviews[idx];
                          _reviews[idx] = Review(id: r.id, customerName: r.customerName, date: r.date, rating: r.rating, comment: r.comment, productId: r.productId, productName: r.productName, reply: _replyCtrl.text.trim());
                        }
                        _replyCtrl.clear();
                        _replyingTo = null;
                      });
                    },
                    child: Container(padding: const EdgeInsets.all(8),
                      decoration: const ShapeDecoration(color: AppColors.accent, shape: CircleBorder()),
                      child: const Icon(Icons.send, color: Colors.white, size: 14)),
                  ),
                ],
              )
            else
              TextButton(
                onPressed: () => setState(() { _replyingTo = review.id; _replyCtrl.clear(); }),
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: Text('Reply', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
              ),
          ],
        ],
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
