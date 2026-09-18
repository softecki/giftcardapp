import 'package:flutter/material.dart';
import 'package:malipo_agent/src/model/bottom_nav_bar_item.dart';

class AppData {
  const AppData._();

  static String url = "https://m-malipo.ubx.co.tz/api";
  static const String appName = "GiftCard";
  static String School_name = appName;



  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];

  static const Color lightOrangeColor = Color(0xFFff0000);

  static List<BottomNavBarItem> bottomNavBarItems = [
    const BottomNavBarItem(
      "Home",
      Icon(Icons.home),
    ),
    const BottomNavBarItem(
      "Merchant",
      Icon(Icons.bar_chart),
    ),
    const BottomNavBarItem(
      "Profile",
      Icon(Icons.person),
    ),
  ];


}
