import 'package:flutter_test/flutter_test.dart';
import 'package:market_mirror_mobile/main.dart';

void main() {
  testWidgets('App launches with welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MarketMirrorApp());
    expect(find.text('Market Mirror'), findsOneWidget);
    expect(find.text('I am a...'), findsOneWidget);
  });
}
