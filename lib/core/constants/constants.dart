import 'package:flutter/material.dart';
import 'package:storyapp/core/constants/app_assets.dart';
import 'package:storyapp/core/constants/bottom_item.dart';

class Constants {
  static const String defaultFont = "Ubuntu";
  static const double defaultBorderRadius = 15;
  static const defaultAnimationDuration = Duration(milliseconds: 500);

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static List<BottomNavItem> navItems = [
    BottomNavItem(
      name: "Home",
      icon: AppAssets.navHome,
      index: 0,
    ),
    BottomNavItem(
      name: "Search",
      icon: AppAssets.navSearch,
      index: 1,
    ),
    BottomNavItem(
      name: "Profile",
      icon: AppAssets.navProfile,
      index: 2,
    ),
  ];
}
