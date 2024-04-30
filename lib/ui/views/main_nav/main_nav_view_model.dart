import 'package:flutter/material.dart';
import 'package:storyapp/ui/view_model/app_base_model.dart';

class MainNavVM extends AppBaseViewModel {
  PageController controller = PageController(initialPage: 1);

  changePage(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }
}
