import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/app_root_screen.dart';
import 'package:deposit_calc_satelit/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(GlobalKey<NavigatorState>? navigatorKey)
      : super(navigatorKey: navigatorKey);

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        initial: true,
        path: '/',
        page: AppRootRoute.page,
        children: [
          AutoRoute(
            page: HomeRouter.page,
            path: 'home',
            children: [AutoRoute(page: HomeRoute.page, path: '')],
          ),
        ],
      ),
    ];
  }
}

@RoutePage(name: 'HomeRouter')
class HomeRouterPage extends AutoRouter {
  const HomeRouterPage({super.key});
}
