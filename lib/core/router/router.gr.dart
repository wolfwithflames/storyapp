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
      final args = routeData.argsAs<AddStoryRouteArgs>(
          orElse: () => const AddStoryRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddStoryScreen(
          key: args.key,
          media: args.media,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    MainNavRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainNavPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [AddStoryScreen]
class AddStoryRoute extends PageRouteInfo<AddStoryRouteArgs> {
  AddStoryRoute({
    Key? key,
    Media? media,
    List<PageRouteInfo>? children,
  }) : super(
          AddStoryRoute.name,
          args: AddStoryRouteArgs(
            key: key,
            media: media,
          ),
          initialChildren: children,
        );

  static const String name = 'AddStoryRoute';

  static const PageInfo<AddStoryRouteArgs> page =
      PageInfo<AddStoryRouteArgs>(name);
}

class AddStoryRouteArgs {
  const AddStoryRouteArgs({
    this.key,
    this.media,
  });

  final Key? key;

  final Media? media;

  @override
  String toString() {
    return 'AddStoryRouteArgs{key: $key, media: $media}';
  }
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

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

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
