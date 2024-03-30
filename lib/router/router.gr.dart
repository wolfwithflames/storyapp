// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddStoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddStoryScreen(),
      );
    },
    MainNavRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainNavPage(),
      );
    },
  };
}

/// generated route for
/// [AddStoryScreen]
class AddStoryRoute extends PageRouteInfo<void> {
  const AddStoryRoute({List<PageRouteInfo>? children})
      : super(
          AddStoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddStoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainNavPage]
class MainNavRoute extends PageRouteInfo<void> {
  const MainNavRoute({List<PageRouteInfo>? children})
      : super(
          MainNavRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainNavRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
