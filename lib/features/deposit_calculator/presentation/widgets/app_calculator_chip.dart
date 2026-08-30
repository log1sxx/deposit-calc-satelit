import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/styles/my_finances_colors.dart';
import 'package:flutter/material.dart';

class AppCalculatorChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const AppCalculatorChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    return Material(
      borderRadius: borderRadius,
      color: isSelected ? AppStyles.primary : Colors.white,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Center(
            child: Text(
              title,
              style: AppStyles.body.copyWith(
                color: isSelected
                    ? Colors.white
                    : Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
