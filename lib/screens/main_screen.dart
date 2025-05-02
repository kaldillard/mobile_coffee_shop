import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/screens/navigation_screens/notifications_screen.dart';
import 'package:mobile_coffee_shop/screens/navigation_screens/favorites_screen.dart';
import 'package:mobile_coffee_shop/screens/navigation_screens/home_screen.dart';
import 'package:mobile_coffee_shop/screens/navigation_screens/recent_orders_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const RecentOrdersScreen(),
    const NotificationsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color04,
      resizeToAvoidBottomInset: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedIconTheme: const IconThemeData(color: color01),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              IconlyLight.home,
            ),
            activeIcon: Icon(
              IconlyBold.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.heart,
            ),
            activeIcon: Icon(
              IconlyBold.heart,
            ),
            label: "Heart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.bag,
            ),
            activeIcon: Icon(
              IconlyBold.bag,
            ),
            label: "Bag",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconlyLight.notification,
            ),
            activeIcon: Icon(
              IconlyBold.notification,
            ),
            label: "Notification",
          ),
        ],
      ),
    );
  }
}
