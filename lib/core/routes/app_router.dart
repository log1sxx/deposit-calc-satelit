import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/app_root_screen.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/screens/deposit_screen.dart';
import 'package:deposit_calc_satelit/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(GlobalKey<NavigatorState>? navigatorKey)
    : super(navigatorKey: navigatorKey);

  @override
  List<AutoRoute> get routes {
    return [AutoRoute(initial: true, path: '/', page: DepositRoute.page)];
  }
}
