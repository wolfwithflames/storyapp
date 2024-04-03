import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../screens/add_story/add_story_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/main_nav/main_nav_screen.dart';
import '../screens/splash/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: Routes.root,
        ),
        AutoRoute(
          page: MainNavRoute.page,
          path: Routes.mainNav,
        ),
        AutoRoute(
          page: AddStoryRoute.page,
          path: Routes.addStory,
        ),
        AutoRoute(
          page: AuthRoute.page,
          path: Routes.auth,
        ),
      ];
}

class Routes {
  static const String root = "/";
  static const String mainNav = "/home";
  static const String addStory = "/addStory";
  static const String auth = "/auth";
}
