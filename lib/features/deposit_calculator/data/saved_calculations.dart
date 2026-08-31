import 'dart:convert';

import 'package:deposit_calc_satelit/features/deposit_calculator/domain/deposit_calculation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedCalculation {
  const SavedCalculation({
    required this.savedAt,
    required this.input,
    required this.result,
  });

  final DateTime savedAt;
  final DepositCalculationInput input;
  final DepositCalculationResult result;

  Map<String, Object?> toJson() => {
    'savedAt': savedAt.toIso8601String(),
    'input': {
      'initialAmount': input.initialAmount,
      'annualRate': input.annualRate,
      'startDate': input.startDate.toIso8601String(),
      'endDate': input.endDate.toIso8601String(),
      'capitalization': input.capitalization.name,
      'moveWeekendPayments': input.moveWeekendPayments,
      'earlyClosingRate': input.earlyClosingRate,
      'refills': input.refills
          .map(
            (item) => {
              'date': item.date.toIso8601String(),
              'amount': item.amount,
              'period': item.period.name,
            },
          )
          .toList(),
      'withdrawals': input.withdrawals
          .map(
            (item) => {
              'date': item.date.toIso8601String(),
              'amount': item.amount,
              'period': item.period.name,
            },
          )
          .toList(),
    },
    'result': {
      'income': result.income,
      'finalAmount': result.finalAmount,
      'totalRefills': result.totalRefills,
      'totalWithdrawals': result.totalWithdrawals,
      'schedule': result.schedule
          .map(
            (row) => {
              'date': row.date.toIso8601String(),
              'interest': row.interest,
              'balance': row.balance,
              'cashFlow': row.cashFlow,
            },
          )
          .toList(),
    },
  };

  factory SavedCalculation.fromJson(Map<String, dynamic> json) {
    final inputJson = json['input'] as Map<String, dynamic>;
    final resultJson = json['result'] as Map<String, dynamic>;
    return SavedCalculation(
      savedAt: DateTime.parse(json['savedAt'] as String),
      input: DepositCalculationInput(
        initialAmount: (inputJson['initialAmount'] as num).toDouble(),
        annualRate: (inputJson['annualRate'] as num).toDouble(),
        startDate: DateTime.parse(inputJson['startDate'] as String),
        endDate: DateTime.parse(inputJson['endDate'] as String),
        capitalization: CapitalizationPeriod.values.byName(
          inputJson['capitalization'] as String,
        ),
        moveWeekendPayments: inputJson['moveWeekendPayments'] as bool,
        earlyClosingRate: (inputJson['earlyClosingRate'] as num?)?.toDouble(),
        refills: _operations(inputJson['refills']),
        withdrawals: _operations(inputJson['withdrawals']),
      ),
      result: DepositCalculationResult(
        income: (resultJson['income'] as num).toDouble(),
        finalAmount: (resultJson['finalAmount'] as num).toDouble(),
        totalRefills: (resultJson['totalRefills'] as num).toDouble(),
        totalWithdrawals: (resultJson['totalWithdrawals'] as num).toDouble(),
        schedule: (resultJson['schedule'] as List<dynamic>).map((item) {
          final row = item as Map<String, dynamic>;
          return DepositScheduleRow(
            date: DateTime.parse(row['date'] as String),
            interest: (row['interest'] as num).toDouble(),
            balance: (row['balance'] as num).toDouble(),
            cashFlow: (row['cashFlow'] as num).toDouble(),
          );
        }).toList(),
      ),
    );
  }

  static List<DepositOperation> _operations(Object? value) =>
      (value as List<dynamic>? ?? const []).map((item) {
        final operation = item as Map<String, dynamic>;
        return DepositOperation(
          date: DateTime.parse(operation['date'] as String),
          amount: (operation['amount'] as num).toDouble(),
          period: RefillPeriod.values.byName(operation['period'] as String),
        );
      }).toList();
}

class SavedCalculationsStorage {
  SavedCalculationsStorage(this.preferences);
  static const _key = 'saved_deposit_calculations_v1';
  static const maxItems = 50;
  final SharedPreferences preferences;

  List<SavedCalculation> load() {
    final raw = preferences.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      return (jsonDecode(raw) as List<dynamic>)
          .map(
            (item) => SavedCalculation.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on Object {
      return [];
    }
  }

  Future<void> save(SavedCalculation calculation) async {
    final calculations = load();
    calculations.insert(0, calculation);
    if (calculations.length > maxItems) {
      calculations.removeRange(maxItems, calculations.length);
    }
    await preferences.setString(
      _key,
      jsonEncode(calculations.map((item) => item.toJson()).toList()),
    );
  }

  Future<void> delete(SavedCalculation calculation) async {
    final calculations = load()
      ..removeWhere((item) => item.savedAt == calculation.savedAt);
    await preferences.setString(
      _key,
      jsonEncode(calculations.map((item) => item.toJson()).toList()),
    );
  }
}
