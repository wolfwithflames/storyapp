import 'package:flutter/material.dart';

class MainNavVM extends ChangeNotifier {
  PageController controller = PageController(initialPage: 1);

  changePage(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }
}
