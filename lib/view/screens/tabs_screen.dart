// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/view/screens/all_articles_screen.dart';
import 'package:binrushd_medical_center/view/screens/appointments/my_appointments_screen.dart';
import 'package:binrushd_medical_center/view/screens/home_screen.dart';
import 'package:binrushd_medical_center/view/screens/profile/profile_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            // Expanded section for the main content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: const [
                  HomePage(),
                  ProfileScreens(),
                  MyAppointmentsScreen(),
                  AllArticlesScreen(),
                ],
              ),
            ),
            // Bottom Navigation Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 70, // Increased height to accommodate labels
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bottomNavBarIcon(
                      iconOn: Icons.person,
                      iconOff: Icons.person_outline,
                      index: 1,
                      label: 'حسابي',
                    ),
                    _bottomNavBarIcon(
                      iconOn: Icons.article,
                      iconOff: Icons.article_outlined,
                      index: 3,
                      label: 'المقالات',
                    ),
                    _bottomNavBarIcon(
                      iconOn: Icons.calendar_today,
                      iconOff: Icons.calendar_today_outlined,
                      index: 2,
                      label: 'الحجوزات',
                    ),
                    _bottomNavBarIcon(
                      iconOn: Icons.home,
                      iconOff: Icons.home_outlined,
                      index: 0,
                      label: 'الرئيسية',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavBarIcon({
    required IconData iconOff,
    required int index,
    IconData? iconOn,
    String? label,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? backgroundColor : Colors.black;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? iconOn ?? iconOff : iconOff,
            color: color,
          ),
          if (label != null)
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}
