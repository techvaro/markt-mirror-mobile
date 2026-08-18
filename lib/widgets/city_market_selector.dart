import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/mock_data.dart';
import '../providers/market_provider.dart';
import '../theme/app_theme.dart';

/// Interconnected city + market selector used across the buyer discovery
/// screens. Every instance reads/writes the same [MarketProvider] so a change
/// made anywhere propagates through the whole app.
///
/// The Alaba International Market entry is shown as "Coming Soon" and is
/// disabled until it goes live.
class CityMarketSelector extends StatelessWidget {
  const CityMarketSelector({super.key});

  bool _isComingSoon(String market) =>
      market.toLowerCase().contains('coming soon');

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MarketProvider>();
    final markets = MockData.marketsForCity(provider.selectedCity);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: provider.selectedCity,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'City',
                prefixIcon: Icon(Icons.location_city_outlined, size: 20),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.border)),
              ),
              items: MockData.cities
                  .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                  .toList(),
              onChanged: provider.selectCity,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: provider.selectedMarket.isEmpty ? null : provider.selectedMarket,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Market',
                prefixIcon: Icon(Icons.storefront_outlined, size: 20),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: AppColors.border)),
              ),
              hint: const Text('All markets'),
              items: markets
                  .map((market) => DropdownMenuItem<String>(
                        value: market,
                        enabled: !_isComingSoon(market),
                        child: Text(market),
                      ))
                  .toList(),
              onChanged: provider.selectMarket,
            ),
          ),
        ],
      ),
    );
  }
}
