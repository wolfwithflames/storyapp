import 'package:flutter/material.dart';
import 'package:storyapp/core/router/router.dart';
import 'package:storyapp/getIt.dart';

class HomeNavVM extends ChangeNotifier {
  int selectedIndex = 0;

  changeSelectedIndex(int index) {
    if (selectedIndex == index) {
      return;
    }
    selectedIndex = index;
    switch (selectedIndex) {
      case 0:
        getIt<AppRouter>().pushNamed(Routes.dashboard);
        break;
      case 1:
        getIt<AppRouter>().pushNamed(Routes.search);
        break;
      case 2:
        getIt<AppRouter>().pushNamed(Routes.profile);
        break;

      default:
    }
    notifyListeners();
  }
}
