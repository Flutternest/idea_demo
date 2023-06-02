import 'package:flutter/material.dart';
import 'package:idea_app/views/categories_page.dart';
import 'package:idea_app/views/free_trial_page.dart';
import 'package:idea_app/views/subscription_page.dart';

import '../core/utilities/theme/app_colors.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          CategoriesPage(),
          FreeTrialPage(),
          SubscriptionPage(),
          Center(
            child: Text('Settings'),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFF1D1D1F)),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF1D1D1F),
          selectedItemColor: AppColors.primaryGreenAccent,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 14.0,
          unselectedFontSize: 14.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions),
              label: 'Free Trial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: 'Subscribe',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          selectedIconTheme: const IconThemeData(
            size: 24.0,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 24.0,
          ),
          selectedLabelStyle: const TextStyle(
            fontSize: 12.0,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
