import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'services/service_locator.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/vendor_provider.dart';
import 'providers/mapper_provider.dart';
import 'providers/market_provider.dart';
import 'screens/welcome/welcome_screen.dart';

void main() {
  ServiceLocator.instance;
  runApp(const MarketMirrorApp());
}

class MarketMirrorApp extends StatelessWidget {
  const MarketMirrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => VendorProvider()),
        ChangeNotifierProvider(create: (_) => MapperProvider()),
        ChangeNotifierProvider(create: (_) => MarketProvider()),
      ],
      child: MaterialApp(
        title: 'Market Mirror',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const WelcomeScreen(),
      ),
    );
  }
}
