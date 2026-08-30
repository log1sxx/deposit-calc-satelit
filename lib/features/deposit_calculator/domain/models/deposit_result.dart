import 'package:deposit_calc_satelit/features/deposit_calculator/domain/models/deposit_payment.dart';

class DepositResult {
  final double amount;
  final double term;
  final TermType termType;
  final double rate;
  final DateTime startDate;
  late final List<DepositPayment> payments;
  late final double profit;
  late final double total;

  DepositResult({
    required this.amount,
    required this.term,
    required this.termType,
    required this.rate,
    required this.startDate,
  }) {
    var termMonths = term;
    if (termType == TermType.year) {
      termMonths *= 12;
    }
    payments = <DepositPayment>[];
    var sum = amount;
    for (var i = 0; i < termMonths; i++) {
      sum += sum * rate / 100 / 12;
      final payment = DepositPayment(
        date: DateTime(startDate.year, startDate.month + i, startDate.day),
        sum: sum,
      );
      payments.add(payment);
    }
    total = sum;
    profit = total - amount;
  }
}

enum TermType { year, month }
