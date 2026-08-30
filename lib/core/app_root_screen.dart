import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deposit_calc_satelit/core/extensions/l10n_extension.dart';
import 'package:deposit_calc_satelit/core/routes/app_router.dart';
import 'package:deposit_calc_satelit/core/theme/app_colors.dart';
import 'package:deposit_calc_satelit/core/theme/app_fonts.dart';
import 'package:deposit_calc_satelit/gen/assets.gen.dart';

@RoutePage()
class AppRootScreen extends StatefulWidget {
  const AppRootScreen({super.key});

  @override
  State<AppRootScreen> createState() => _AppRootScreenState();
}

class _AppRootScreenState extends State<AppRootScreen> {
  final routes = [const HomeRoute(), const HomeRoute()];
  final _icons = [
    Assets.icons.navBarIcons.homeNavBarIcon,
    Assets.icons.navBarIcons.profileNavBarIcon,
  ];
  late final _labels = [context.l10n.app_title, context.l10n.app_title];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: AppColors.white,
      routes: routes,
      bottomNavigationBuilder: (context, tabsRouter) {
        if (tabsRouter.topMatch.meta['hideBottomNav'] == true) {
          return const SizedBox.shrink();
        }
        return Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.white)),
          ),
          child: PopScope(
            canPop: tabsRouter.activeIndex == 0,
            onPopInvokedWithResult: (canPop, result) async {
              if (!canPop) {
                ScaffoldMessenger.of(context).clearSnackBars();
                tabsRouter.setActiveIndex(tabsRouter.activeIndex - 1);
                tabsRouter.navigate(routes[tabsRouter.activeIndex]);
              }
            },
            child: BottomNavigationBar(
              backgroundColor: AppColors.black.withOpacity(0.2),
              currentIndex: tabsRouter.activeIndex,
              elevation: 0,
              iconSize: 25,
              type: BottomNavigationBarType.fixed,
              onTap: (index) async {
                ScaffoldMessenger.of(context).clearSnackBars();
                tabsRouter.setActiveIndex(index);
                tabsRouter.navigate(routes[index]);
              },
              useLegacyColorScheme: false,
              selectedLabelStyle: TextStyles.h2.copyWith(fontSize: 0),
              unselectedLabelStyle: TextStyles.h2.copyWith(fontSize: 0),
              items: List.generate(
                _labels.length,
                (index) => BottomNavigationBarItem(
                  label: '',
                  icon: _getIcon(
                    _icons[index],
                    _labels[index],
                    tabsRouter.activeIndex == index,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getIcon(SvgGenImage icon, String text, bool isActive) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 21.h),
      child: Column(
        children: [
          icon.svg(
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              isActive ? AppColors.black : AppColors.white,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 5.h),
          Text(text, style: TextStyles.h2),
        ],
      ),
    );
  }
}
