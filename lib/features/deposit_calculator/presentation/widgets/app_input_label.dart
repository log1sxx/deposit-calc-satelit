import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/styles/my_finances_colors.dart';
import 'package:flutter/material.dart';

class AppInputLabel extends StatelessWidget {
  final String label;

  const AppInputLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppStyles.body.copyWith(fontSize: 14));
  }
}
