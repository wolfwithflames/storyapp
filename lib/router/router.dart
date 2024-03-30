import 'package:auto_route/auto_route.dart';

import '../screens/add_story/add_story_screen.dart';
import '../screens/main_nav/main_nav_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainNavRoute.page,
          path: Routes.root,
        ),
        AutoRoute(
          page: AddStoryRoute.page,
          path: Routes.addStory,
        ),
      ];
}

class Routes {
  static const String root = "/";
  static const String addStory = "/addStory";
}
