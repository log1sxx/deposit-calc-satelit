enum CapitalizationPeriod {
  none('Без капитализации', 0),
  monthly('Ежемесячно', 1),
  quarterly('Ежеквартально', 3),
  yearly('Ежегодно', 12);

  const CapitalizationPeriod(this.label, this.months);
  final String label;
  final int months;
}

enum RefillPeriod {
  once('Однократно', 0),
  monthly('Ежемесячно', 1),
  quarterly('Ежеквартально', 3),
  yearly('Ежегодно', 12);

  const RefillPeriod(this.label, this.months);
  final String label;
  final int months;
}

class DepositOperation {
  const DepositOperation({
    required this.date,
    required this.amount,
    this.period = RefillPeriod.once,
  });

  final DateTime date;
  final double amount;
  final RefillPeriod period;
}

class DepositCalculationInput {
  const DepositCalculationInput({
    required this.initialAmount,
    required this.annualRate,
    required this.startDate,
    required this.endDate,
    required this.capitalization,
    required this.moveWeekendPayments,
    this.refills = const [],
    this.withdrawals = const [],
    this.earlyClosingRate,
  });

  final double initialAmount;
  final double annualRate;
  final DateTime startDate;
  final DateTime endDate;
  final CapitalizationPeriod capitalization;
  final bool moveWeekendPayments;
  final List<DepositOperation> refills;
  final List<DepositOperation> withdrawals;
  final double? earlyClosingRate;
}

class DepositScheduleRow {
  const DepositScheduleRow({
    required this.date,
    required this.interest,
    required this.balance,
    required this.cashFlow,
  });

  final DateTime date;
  final double interest;
  final double balance;
  final double cashFlow;
}

class DepositCalculationResult {
  const DepositCalculationResult({
    required this.income,
    required this.finalAmount,
    required this.totalRefills,
    required this.totalWithdrawals,
    required this.schedule,
  });

  final double income;
  final double finalAmount;
  final double totalRefills;
  final double totalWithdrawals;
  final List<DepositScheduleRow> schedule;
}

class DepositCalculator {
  const DepositCalculator();

  DepositCalculationResult calculate(DepositCalculationInput input) {
    final start = _dateOnly(input.startDate);
    final end = _dateOnly(input.endDate);
    if (input.initialAmount <= 0) {
      throw const FormatException('Сумма вклада должна быть больше нуля');
    }
    if (input.annualRate < 0 || input.annualRate > 100) {
      throw const FormatException('Ставка должна быть от 0 до 100%');
    }
    if (!end.isAfter(start)) {
      throw const FormatException(
        'Дата окончания должна быть позже даты открытия',
      );
    }

    final events = <DateTime, double>{};
    double totalRefills = 0;
    double totalWithdrawals = 0;

    void addOperations(List<DepositOperation> operations, bool withdrawal) {
      for (final operation in operations) {
        var date = _dateOnly(operation.date);
        while (!date.isBefore(start) && !date.isAfter(end)) {
          final effectiveDate = input.moveWeekendPayments
              ? _nextBusinessDay(date)
              : date;
          if (!effectiveDate.isAfter(end)) {
            final signedAmount = withdrawal
                ? -operation.amount.abs()
                : operation.amount.abs();
            events.update(
              effectiveDate,
              (value) => value + signedAmount,
              ifAbsent: () => signedAmount,
            );
            if (withdrawal) {
              totalWithdrawals += operation.amount.abs();
            } else {
              totalRefills += operation.amount.abs();
            }
          }
          if (operation.period == RefillPeriod.once) break;
          date = addMonthsClamped(date, operation.period.months);
        }
      }
    }

    addOperations(input.refills, false);
    addOperations(input.withdrawals, true);

    final capitalizationDates = <DateTime>{};
    if (input.capitalization != CapitalizationPeriod.none) {
      var date = addMonthsClamped(start, input.capitalization.months);
      while (!date.isAfter(end)) {
        capitalizationDates.add(date);
        date = addMonthsClamped(date, input.capitalization.months);
      }
    }

    final rate = input.earlyClosingRate ?? input.annualRate;
    var balance = input.initialAmount;
    var pendingInterest = 0.0;
    var totalInterest = 0.0;
    var monthInterest = 0.0;
    var monthCashFlow = 0.0;
    final schedule = <DepositScheduleRow>[];

    for (
      var date = start;
      date.isBefore(end);
      date = date.add(const Duration(days: 1))
    ) {
      final cashFlow = events[date] ?? 0;
      if (balance + cashFlow < 0) {
        throw FormatException(
          'Сумма снятия ${date.day}.${date.month}.${date.year} превышает остаток вклада',
        );
      }
      balance += cashFlow;
      monthCashFlow += cashFlow;

      final daysInYear = DateTime(date.year + 1)
          .difference(DateTime(date.year))
          .inDays;
      final dailyInterest = balance * rate / 100 / daysInYear;
      pendingInterest += dailyInterest;
      totalInterest += dailyInterest;
      monthInterest += dailyInterest;

      final nextDate = date.add(const Duration(days: 1));
      if (capitalizationDates.contains(nextDate)) {
        balance += pendingInterest;
        pendingInterest = 0;
      }

      if (nextDate.month != date.month || !nextDate.isBefore(end)) {
        schedule.add(
          DepositScheduleRow(
            date: nextDate,
            interest: monthInterest,
            balance: balance + pendingInterest,
            cashFlow: monthCashFlow,
          ),
        );
        monthInterest = 0;
        monthCashFlow = 0;
      }
    }

    return DepositCalculationResult(
      income: totalInterest,
      finalAmount: balance + pendingInterest,
      totalRefills: totalRefills,
      totalWithdrawals: totalWithdrawals,
      schedule: schedule,
    );
  }
}

DateTime addMonthsClamped(DateTime date, int months) {
  final targetMonth = date.month - 1 + months;
  final year = date.year + targetMonth ~/ 12;
  final month = targetMonth % 12 + 1;
  final lastDay = DateTime(year, month + 1, 0).day;
  return DateTime(year, month, date.day > lastDay ? lastDay : date.day);
}

DateTime _nextBusinessDay(DateTime date) {
  if (date.weekday == DateTime.saturday) {
    return date.add(const Duration(days: 2));
  }
  if (date.weekday == DateTime.sunday) {
    return date.add(const Duration(days: 1));
  }
  return date;
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
