import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:storyapp/ui/views/dashboard/dashboard_screen.dart';
import 'package:storyapp/ui/views/profile/profile_view.dart';
import 'package:storyapp/ui/views/register/register_screen.dart';
import 'package:storyapp/ui/views/search/search_screen.dart';

import '../../ui/views/add_story/add_story_screen.dart';
import '../../ui/views/auth/auth_screen.dart';
import '../../ui/views/main_nav/main_nav_screen.dart';
import '../../ui/views/splash/splash_screen.dart';

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
          children: [
            AutoRoute(
              initial: true,
              page: DashboardRoute.page,
              path: Routes.dashboard,
            ),
            AutoRoute(
              page: SearchRoute.page,
              path: Routes.search,
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: Routes.profile,
            ),
          ],
        ),
        AutoRoute(
          page: AddStoryRoute.page,
          path: Routes.addStory,
        ),
        AutoRoute(
          page: AuthRoute.page,
          path: Routes.auth,
        ),
        AutoRoute(
          page: RegisterRoute.page,
          path: Routes.register,
        ),
      ];
}

class Routes {
  static const String root = "/";
  static const String mainNav = "/home";
  static const String addStory = "/addStory";
  static const String auth = "/auth";
  static const String register = "/register";
  static const String dashboard = "dashboard";
  static const String search = "search";
  static const String profile = "profile";
}
