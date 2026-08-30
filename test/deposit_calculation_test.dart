import 'package:deposit_calc_satelit/features/deposit_calculator/domain/deposit_calculation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const calculator = DepositCalculator();

  test('simple interest is calculated by actual days', () {
    final result = calculator.calculate(
      DepositCalculationInput(
        initialAmount: 100000,
        annualRate: 10,
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2026, 1, 1),
        capitalization: CapitalizationPeriod.none,
        moveWeekendPayments: false,
      ),
    );
    expect(result.income, closeTo(10000, 0.01));
    expect(result.finalAmount, closeTo(110000, 0.01));
  });

  test('monthly capitalization increases income', () {
    final plain = calculator.calculate(_input(CapitalizationPeriod.none));
    final capitalized = calculator.calculate(
      _input(CapitalizationPeriod.monthly),
    );
    expect(capitalized.income, greaterThan(plain.income));
    expect(capitalized.finalAmount, greaterThan(plain.finalAmount));
  });

  test('weekend refill is moved to monday', () {
    final result = calculator.calculate(
      DepositCalculationInput(
        initialAmount: 100000,
        annualRate: 10,
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2025, 2, 1),
        capitalization: CapitalizationPeriod.none,
        moveWeekendPayments: true,
        refills: [DepositOperation(date: DateTime(2025, 1, 4), amount: 10000)],
      ),
    );
    expect(result.totalRefills, 10000);
    expect(result.schedule.single.cashFlow, 10000);
  });

  test('withdrawal above balance is rejected', () {
    expect(
      () => calculator.calculate(
        DepositCalculationInput(
          initialAmount: 1000,
          annualRate: 10,
          startDate: DateTime(2025, 1, 1),
          endDate: DateTime(2025, 2, 1),
          capitalization: CapitalizationPeriod.none,
          moveWeekendPayments: false,
          withdrawals: [
            DepositOperation(date: DateTime(2025, 1, 2), amount: 2000),
          ],
        ),
      ),
      throwsFormatException,
    );
  });
}

DepositCalculationInput _input(CapitalizationPeriod period) =>
    DepositCalculationInput(
      initialAmount: 100000,
      annualRate: 12,
      startDate: DateTime(2025, 1, 1),
      endDate: DateTime(2026, 1, 1),
      capitalization: period,
      moveWeekendPayments: false,
    );
