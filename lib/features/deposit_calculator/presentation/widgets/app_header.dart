import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/styles/my_finances_colors.dart';
import 'package:flutter/material.dart';
import 'package:deposit_calc_satelit/gen/assets.gen.dart';

class AppHeader extends StatelessWidget {
  final bool canPop;
  final String? title;

  const AppHeader({super.key, this.canPop = false, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyles.appBarBackgroundColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(canPop ? 6 : 20, 16, 20, 16),
        child: Row(
          children: [
            if (canPop)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: IconButton(
                  icon: RotatedBox(
                    quarterTurns: 2,
                    child: Assets.icons.arrowRight.svg(
                      width: 24,
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
                ),
              ),
            Expanded(
              child: title != null
                  ? Text(
                      title!,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.h2.copyWith(color: Colors.black),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
