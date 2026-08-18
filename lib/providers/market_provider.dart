import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';

/// Keeps the buyer's active city + market consistent across discovery
/// screens. An empty market means the buyer is browsing every market.
/// Selecting a new city resets the market (Lagos is currently the only city).
class MarketProvider extends ChangeNotifier {
  String _selectedCity = MockData.cities.first;
  String _selectedMarket = '';

  String get selectedCity => _selectedCity;
  String get selectedMarket => _selectedMarket;
  bool get isShowingAllMarkets => _selectedMarket.isEmpty;

  void selectCity(String? city) {
    final nextCity = city ?? MockData.cities.first;
    if (_selectedCity == nextCity && _selectedMarket.isEmpty) return;
    _selectedCity = nextCity;
    _selectedMarket = '';
    notifyListeners();
  }

  void selectMarket(String? market) {
    final nextMarket = market ?? '';
    if (_selectedMarket == nextMarket) return;
    _selectedMarket = nextMarket;
    notifyListeners();
  }

  void clear() {
    if (_selectedMarket.isEmpty && _selectedCity == MockData.cities.first) return;
    _selectedCity = MockData.cities.first;
    _selectedMarket = '';
    notifyListeners();
  }
}
