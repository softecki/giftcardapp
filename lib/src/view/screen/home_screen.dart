import 'package:malipo_agent/src/view/screen/paymentProfile.dart';
import 'package:malipo_agent/src/view/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_data.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:malipo_agent/src/view/animation/page_transition_switcher_wrapper.dart';

import 'merchant_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<Widget> screens = [
    DashBoardScreen(),
    MerchantListScreen(),
    ProfileScreen(),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(-4, -4),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(4, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: StylishBottomBar(
              backgroundColor: Colors.grey.shade300,
              elevation: 0,
              currentIndex: newIndex,
              onTap: (index) {
                setState(() {
                  newIndex = index;
                });
              },
              items: AppData.bottomNavBarItems.map(
                    (item) {
                  return BottomBarItem(
                    backgroundColor: item.activeColor.withOpacity(0.2),
                    icon: item.icon,
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: item.activeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ).toList(),
              option: BubbleBarOptions(
                opacity: 0.15,
                inkColor: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
                barStyle: BubbleBarStyle.horizontal,

              ),
            ),
          ),
          body: PageTransitionSwitcherWrapper(
            child: HomeScreen.screens[newIndex],
          ),
        ),
      ),
    );
  }
}
