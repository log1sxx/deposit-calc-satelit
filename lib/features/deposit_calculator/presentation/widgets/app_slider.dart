import 'package:deposit_calc_satelit/gen/assets.gen.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/styles/my_finances_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AppSlider extends StatelessWidget {
  final double min;
  final double max;
  final double step;
  final void Function(double) onChanged;
  final double value;

  const AppSlider({
    super.key,
    required this.min,
    required this.max,
    required this.step,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        activeTrackHeight: 6,
        inactiveTrackHeight: 6,
        overlayRadius: 0,
      ),
      child: SfSlider(
        activeColor: AppStyles.secondary,
        stepSize: (max - min) / step,
        thumbIcon: Assets.icons.activeCircle.svg(),
        inactiveColor: Colors.white,
        onChanged: (d) => onChanged(d as double),
        min: min,
        max: max,
        trackShape: SfTrackShape(),
        value: value,
      ),
    );
  }
}
