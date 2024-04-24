import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/bottom_item.dart';
import '../../../../core/constants/constants.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/text_view.dart';

class BottomNavigationPanel extends StatefulWidget {
  final Function(int) onNavItemTap;
  final int selectedIndex;
  const BottomNavigationPanel({
    super.key,
    required this.onNavItemTap,
    required this.selectedIndex,
  });

  @override
  State<BottomNavigationPanel> createState() => _BottomNavigationPanelState();
}

class _BottomNavigationPanelState extends State<BottomNavigationPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 1.0))
        .animate(controller);
  }

  double previousVisiblePercentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: updateVisibility,
      key: const Key("BottomNavigationPanel"),
      child: SlideTransition(
        position: offset,
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: Constants.navItems
                .map(
                  (e) => InkWell(
                    onTap: () => widget.onNavItemTap(e.index),
                    child: NavItemView(
                      bottomNavItem: e,
                      isSelected: e.index == widget.selectedIndex,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void updateVisibility(info) {
    if (!mounted) {
      return;
    }
    double visiblePercentage = double.parse(
        (((info.visibleFraction * 100) / 100) - 1.0)
            .toString()
            .replaceAll("-", ""));
    setState(() {
      offset =
          Tween<Offset>(begin: Offset.zero, end: Offset(0.0, visiblePercentage))
              .animate(controller);
    });

    if (previousVisiblePercentage > visiblePercentage) {
      controller.reverse();
    } else {
      controller.forward();
    }
    previousVisiblePercentage = visiblePercentage;
  }
}

class NavItemView extends StatelessWidget {
  final BottomNavItem bottomNavItem;
  final bool isSelected;
  const NavItemView({
    super.key,
    required this.bottomNavItem,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView(
            bottomNavItem.icon,
            ImageType.svg,
            color:
                isSelected ? AppColors.primaryColor : AppColors.unselectedColor,
          ),
          const SizedBox(height: 3),
          TextView(
            bottomNavItem.name,
            textColor:
                isSelected ? AppColors.primaryColor : AppColors.unselectedColor,
          )
        ],
      ),
    );
  }
}
