import 'package:flutter/foundation.dart';

/// Keeps the buyer's active market consistent across discovery screens.
/// An empty value means that the buyer is browsing every market.
class MarketProvider extends ChangeNotifier {
  String _selectedMarket = '';

  String get selectedMarket => _selectedMarket;
  bool get isShowingAllMarkets => _selectedMarket.isEmpty;

  void selectMarket(String? market) {
    final nextMarket = market ?? '';
    if (_selectedMarket == nextMarket) return;
    _selectedMarket = nextMarket;
    notifyListeners();
  }
}
