import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deposit_calc_satelit/gen/assets.gen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Home Screen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
        ),
        Assets.icons.navBarIcons.homeNavBarIcon.svg(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      ],
    );
  }
}
