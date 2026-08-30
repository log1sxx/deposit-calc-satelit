import 'package:deposit_calc_satelit/features/deposit_calculator/domain/deposit_calculation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepositResultScreen extends StatelessWidget {
  const DepositResultScreen(this.result, {super.key});
  final DepositCalculationResult result;
  static final money = NumberFormat.currency(
    locale: 'ru',
    symbol: '₽',
    decimalDigits: 0,
  );
  static final month = DateFormat('MM.yyyy');

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F5FA),
    appBar: AppBar(
      title: const Text('Результат расчёта'),
      backgroundColor: Colors.white,
    ),
    body: ListView(
      padding: const EdgeInsets.all(12),
      children: [
        summary(),
        const SizedBox(height: 16),
        const Text(
          'График начислений',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        card(
          Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text('Период', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(
                    child: Text(
                      'Проценты',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Остаток',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const Divider(),
              for (final row in result.schedule) ...[
                Row(
                  children: [
                    Expanded(child: Text(month.format(row.date))),
                    Expanded(
                      child: Text(
                        money.format(row.interest),
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        money.format(row.balance),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8C5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Расчёт носит информационный характер. Условия банка, налоги и правила округления могут изменить итоговую сумму.',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget card(Widget child) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 18)],
    ),
    child: child,
  );
  Widget summary() => card(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          money.format(result.income),
          style: const TextStyle(
            color: Color(0xFF1717EF),
            fontSize: 34,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Text(
          'Доход по вкладу',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const Divider(height: 28),
        row('Итоговая сумма', result.finalAmount),
        if (result.totalRefills > 0)
          row('Всего пополнений', result.totalRefills),
        if (result.totalWithdrawals > 0)
          row('Всего снятий', result.totalWithdrawals),
      ],
    ),
  );
  Widget row(String title, double value) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
      children: [
        Expanded(child: Text(title)),
        Text(
          money.format(value),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
