import 'package:deposit_calc_satelit/features/deposit_calculator/data/utils/text_editing_extension.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_input_label.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_numeric_filed.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFieldWithSlider extends StatefulWidget {
  final TextEditingController controller;
  final double initial;
  final double min;
  final double max;
  final String title;
  final int fractionDigits;
  final double sliderStep;

  const AppFieldWithSlider({
    super.key,
    required this.controller,
    required this.initial,
    required this.min,
    required this.title,
    required this.max,
    this.fractionDigits = 0,
    required this.sliderStep,
  });

  @override
  State<AppFieldWithSlider> createState() => _AppFieldWithSliderState();
}

class _AppFieldWithSliderState extends State<AppFieldWithSlider> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _updateValue(widget.initial);
  }

  void _updateValue(double value) {
    widget.controller.setNumericValue(
      value,
      fractionDigits: widget.fractionDigits,
    );
    setState(() => _sliderValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: AppInputLabel("Сумма вложений, ₽.:")),
            SizedBox(width: 60.w),
            Flexible(
              child: AppNumericField(
                controller: widget.controller,
                initial: widget.initial,
                min: widget.min,
                max: widget.max,
                textAlign: TextAlign.right,
                onUpdate: (double value) {
                  setState(() => _sliderValue = value);
                },
              ),
            ),
          ],
        ),
        AppSlider(
          min: widget.min,
          max: widget.max,
          step: widget.sliderStep,
          onChanged: _updateValue,
          value: _sliderValue,
        ),
      ],
    );
  }
}
