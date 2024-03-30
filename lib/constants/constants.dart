import 'package:storyapp/constants/app_assets.dart';
import 'package:storyapp/constants/bottom_item.dart';

class Constants {
  static const String defaultFont = "Ubuntu";
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
