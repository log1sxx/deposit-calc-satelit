import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/app_root_screen.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/screens/deposit_screen.dart';
import 'package:deposit_calc_satelit/features/home/presentation/pages/home_screen.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/pages/capitalization_article_screen.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/pages/deposit_or_savings_article_screen.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/pages/deposit_term_article_screen.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/pages/early_closure_article_screen.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/pages/key_rate_article_screen.dart';
import 'package:deposit_calc_satelit/features/home/presentation/pages/my_calculations_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(GlobalKey<NavigatorState>? navigatorKey)
    : super(navigatorKey: navigatorKey);

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(initial: true, path: '/', page: HomeRoute.page),
      AutoRoute(path: '/calculator', page: DepositRoute.page),
      AutoRoute(path: '/calculations', page: MyCalculationsRoute.page),
      AutoRoute(
        path: '/articles/capitalization',
        page: CapitalizationArticleRoute.page,
      ),
      AutoRoute(
        path: '/articles/deposit-or-savings',
        page: DepositOrSavingsArticleRoute.page,
      ),
      AutoRoute(
        path: '/articles/deposit-term',
        page: DepositTermArticleRoute.page,
      ),
      AutoRoute(path: '/articles/key-rate', page: KeyRateArticleRoute.page),
      AutoRoute(
        path: '/articles/early-closure',
        page: EarlyClosureArticleRoute.page,
      ),
    ];
  }
}
