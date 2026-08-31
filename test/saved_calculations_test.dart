import 'package:deposit_calc_satelit/features/deposit_calculator/data/saved_calculations.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/domain/deposit_calculation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('saved calculation survives serialization', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = SavedCalculationsStorage(
      await SharedPreferences.getInstance(),
    );
    final input = DepositCalculationInput(
      initialAmount: 500000,
      annualRate: 14,
      startDate: DateTime(2026),
      endDate: DateTime(2027),
      capitalization: CapitalizationPeriod.monthly,
      moveWeekendPayments: false,
    );
    final result = const DepositCalculator().calculate(input);

    await storage.save(
      SavedCalculation(
        savedAt: DateTime(2026, 8, 31),
        input: input,
        result: result,
      ),
    );

    final restored = storage.load().single;
    expect(restored.input.initialAmount, 500000);
    expect(restored.input.capitalization, CapitalizationPeriod.monthly);
    expect(restored.result.income, closeTo(result.income, .001));
    expect(restored.result.schedule.length, result.schedule.length);
  });
}
