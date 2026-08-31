import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/routes/app_router.dart';
import 'package:deposit_calc_satelit/core/widgets/app_header.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/domain/deposit_calculation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepositResultScreen extends StatefulWidget {
  const DepositResultScreen(this.result, this.input, {super.key});
  final DepositCalculationResult result;
  final DepositCalculationInput input;
  @override
  State<DepositResultScreen> createState() => _DepositResultScreenState();
}

class _DepositResultScreenState extends State<DepositResultScreen> {
  static const violet = Color(0xFF6757ED),
      navy = Color(0xFF062967),
      background = Color(0xFFF3F4F8);
  static final money = NumberFormat.currency(
    locale: 'ru',
    symbol: '₽',
    decimalDigits: 0,
  );
  static final monthName = DateFormat('LLLL yyyy', 'ru');
  bool expanded = false;
  DepositCalculationResult get result => widget.result;
  DepositCalculationInput get input => widget.input;
  int get termMonths => math.max(
    1,
    (input.endDate.year - input.startDate.year) * 12 +
        input.endDate.month -
        input.startDate.month,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: background,
    appBar: AppHeader(
      title: 'Результат расчета',
      onBack: () => Navigator.pop(context, true),
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      children: [
        _hero(),
        const SizedBox(height: 12),
        _parameters(),
        const SizedBox(height: 12),
        _details(),
        const SizedBox(height: 12),
        _incomeTable(),
      ],
    ),
    bottomNavigationBar: _bottomBar(),
  );

  Widget _hero() => AspectRatio(
    aspectRatio: 765 / 330,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(14),
        image: const DecorationImage(
          image: AssetImage('assets/images/result_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ваш доход',
                style: TextStyle(color: Color(0xFFB9C7E3), fontSize: 10),
              ),
              Text(
                money.format(result.income),
                style: const TextStyle(
                  color: Color(0xFF16D5F5),
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Text(
                'Сумма к концу срока',
                style: TextStyle(color: Color(0xFFB9C7E3), fontSize: 10),
              ),
              Text(
                money.format(result.finalAmount),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: _pill(
              'Доходность: ${_percent(result.income / input.initialAmount * 100)}%',
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: _pill('За $termMonths ${_months(termMonths)}'),
          ),
        ],
      ),
    ),
  );

  Widget _parameters() => _section(
    'Параметры расчета',
    Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _parameter(
                Icons.account_balance_wallet_rounded,
                'Сумма вклада',
                money.format(input.initialAmount),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _parameter(
                Icons.percent_rounded,
                'Годовая ставка',
                '${_percent(input.annualRate)}%',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _parameter(
                Icons.calendar_month_rounded,
                'Срок вклада',
                '$termMonths ${_months(termMonths)}',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _parameter(
                Icons.pie_chart_rounded,
                'Капитализация',
                input.capitalization == CapitalizationPeriod.none
                    ? 'Не учитывается'
                    : input.capitalization.label,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 42,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE5EFFF),
              foregroundColor: const Color(0xFF1515EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(Icons.edit_rounded, size: 19),
            label: const Text(
              'Изменить параметры',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _details() {
    final tax = math.max(0.0, result.income * .13),
        received = result.finalAmount - math.max(0.0, result.income * .13);
    return _section(
      'Детализация',
      Column(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: CustomPaint(
              painter: _DonutPainter(
                deposit: input.initialAmount,
                income: result.income,
                tax: tax,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _legend(violet, 'Сумма вклада:', input.initialAmount),
                _legend(navy, 'Начисленный доход:', result.income),
                _legend(const Color(0xFFD5DFF7), 'НДФЛ (13%):', -tax),
                const Divider(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Сумма к получению',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      money.format(received),
                      style: const TextStyle(
                        color: violet,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _incomeTable() {
    final yearly = termMonths > 12;
    final rows = yearly
        ? _yearRows()
        : result.schedule
              .map((e) => _IncomeRow(monthName.format(e.date), e.interest))
              .toList();
    final visible = expanded ? rows : rows.take(5).toList();
    return _section(
      yearly ? 'Доход по годам' : 'Доход по месяцам',
      Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Период',
                  style: TextStyle(color: Color(0xFF77777F), fontSize: 10),
                ),
              ),
              Text(
                'Начислено процентов',
                style: TextStyle(color: Color(0xFF77777F), fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 7),
          for (final row in visible) ...[
            Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      row.label,
                      style: const TextStyle(
                        color: Color(0xFF77777F),
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Text(
                    money.format(row.interest),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
          ],
          if (rows.length > 5)
            SizedBox(
              width: double.infinity,
              height: 42,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFE5EFFF),
                  foregroundColor: const Color(0xFF1515EE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                onPressed: () => setState(() => expanded = !expanded),
                child: Text(
                  expanded ? 'Скрыть' : 'Показать еще',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<_IncomeRow> _yearRows() {
    final values = <int, double>{};
    for (final row in result.schedule) {
      values.update(
        row.date.year,
        (v) => v + row.interest,
        ifAbsent: () => row.interest,
      );
    }
    return values.entries.map((e) => _IncomeRow('${e.key}', e.value)).toList();
  }

  Widget _bottomBar() => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
    child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 44,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF07174F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text(
                'Вернуться на главную',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Container(
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(color: Color(0x14000000), blurRadius: 8),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  Icons.home_rounded,
                  'Главная',
                  true,
                  () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                ),
                _NavItem(
                  Icons.format_list_bulleted_rounded,
                  'Мои расчёты',
                  false,
                  () {
                    final router = context.router;
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    router.push(const MyCalculationsRoute());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _section(String title, Widget child) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
  Widget _parameter(IconData icon, String label, String value) => Container(
    height: 80,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: violet, size: 20),
        const Spacer(),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF77777F), fontSize: 9),
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
  Widget _legend(Color color, String label, double value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF5F6068), fontSize: 10),
          ),
        ),
        Text(
          money.format(value),
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
  Widget _pill(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xFF173B78),
      border: Border.all(color: const Color(0xFF526B9B)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 9)),
  );
  String _percent(double value) => NumberFormat('0.##', 'ru').format(value);
  String _months(int value) {
    final n = value % 100;
    if (n >= 11 && n <= 14) return 'месяцев';
    return switch (value % 10) {
      1 => 'месяц',
      2 || 3 || 4 => 'месяца',
      _ => 'месяцев',
    };
  }
}

class _IncomeRow {
  const _IncomeRow(this.label, this.interest);
  final String label;
  final double interest;
}

class _NavItem extends StatelessWidget {
  const _NavItem(this.icon, this.title, this.selected, this.onTap);
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selected ? _DepositResultScreenState.violet : Colors.grey,
            size: 23,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 9,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({
    required this.deposit,
    required this.income,
    required this.tax,
  });
  final double deposit, income, tax;
  @override
  void paint(Canvas canvas, Size size) {
    final total = math.max(1.0, deposit + income + tax),
        paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 24;
    var start = -math.pi / 2;
    for (final part in [
      (deposit, const Color(0xFF6757ED)),
      (income, _DepositResultScreenState.navy),
      (tax, const Color(0xFFD5DFF7)),
    ]) {
      final sweep = math.pi * 2 * part.$1 / total;
      canvas.drawArc(
        (Offset.zero & size).deflate(14),
        start,
        sweep,
        false,
        paint..color = part.$2,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.deposit != deposit ||
      oldDelegate.income != income ||
      oldDelegate.tax != tax;
}
