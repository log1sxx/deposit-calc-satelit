// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AppRootScreen]
class AppRootRoute extends PageRouteInfo<void> {
  const AppRootRoute({List<PageRouteInfo>? children})
    : super(AppRootRoute.name, initialChildren: children);

  static const String name = 'AppRootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppRootScreen();
    },
  );
}

/// generated route for
/// [HomeRouterPage]
class HomeRouter extends PageRouteInfo<void> {
  const HomeRouter({List<PageRouteInfo>? children})
    : super(HomeRouter.name, initialChildren: children);

  static const String name = 'HomeRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeRouterPage();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}
