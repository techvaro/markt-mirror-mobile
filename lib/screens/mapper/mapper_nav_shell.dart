import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:market_mirror_mobile/theme/app_theme.dart';
import 'package:market_mirror_mobile/providers/mapper_provider.dart';
import 'package:market_mirror_mobile/screens/mapper/dashboard/dashboard_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/tasks/tasks_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/register_vendor/register_vendor_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/messages/messages_screen.dart';
import 'package:market_mirror_mobile/screens/mapper/settings/settings_screen.dart';

class MapperNavShell extends StatelessWidget {
  const MapperNavShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapperProvider>(
      builder: (context, provider, _) {
        final screens = const [
          DashboardScreen(),
          TasksScreen(),
          RegisterVendorScreen(),
          MessagesScreen(),
          SettingsScreen(),
        ];

        return Scaffold(
          body: IndexedStack(
            index: provider.tabIndex,
            children: screens,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: provider.tabIndex,
            onDestinationSelected: (i) => provider.tabIndex = i,
            indicatorColor: AppColors.primaryContainer,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard, color: AppColors.primary),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.assignment_outlined),
                selectedIcon: Icon(Icons.assignment, color: AppColors.primary),
                label: 'Tasks',
              ),
              NavigationDestination(
                icon: Icon(Icons.app_registration_outlined),
                selectedIcon: Icon(Icons.app_registration, color: AppColors.primary),
                label: 'Register',
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outlined),
                selectedIcon: Icon(Icons.chat_bubble, color: AppColors.primary),
                label: 'Messages',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings, color: AppColors.primary),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
