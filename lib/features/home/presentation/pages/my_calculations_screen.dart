import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/di/service_locator.dart';
import 'package:deposit_calc_satelit/core/routes/app_router.dart';
import 'package:deposit_calc_satelit/core/widgets/app_header.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/data/saved_calculations.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/domain/deposit_calculation.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/screens/deposit_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@RoutePage()
class MyCalculationsScreen extends StatefulWidget {
  const MyCalculationsScreen({super.key});

  @override
  State<MyCalculationsScreen> createState() => _MyCalculationsScreenState();
}

class _MyCalculationsScreenState extends State<MyCalculationsScreen> {
  static const violet = Color(0xFF6757ED);
  static const background = Color(0xFFF3F4F8);
  static final money = NumberFormat.currency(
    locale: 'ru',
    symbol: '₽',
    decimalDigits: 0,
  );
  late final SavedCalculationsStorage storage;
  List<SavedCalculation> calculations = [];

  @override
  void initState() {
    super.initState();
    storage = SavedCalculationsStorage(getIt());
    calculations = storage.load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: background,
    appBar: const AppHeader(title: 'Мои расчеты', showBackButton: false),
    body: calculations.isEmpty ? _empty() : _list(),
    bottomNavigationBar: _bottomNavigation(context),
  );

  Widget _list() => ListView.separated(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
    itemCount: calculations.length,
    separatorBuilder: (_, _) => const SizedBox(height: 12),
    itemBuilder: (context, index) => _card(calculations[index]),
  );

  Widget _card(SavedCalculation calculation) {
    final incomeRate = calculation.input.initialAmount == 0
        ? 0.0
        : calculation.result.income / calculation.input.initialAmount * 100;
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _metric(
                  'Ожидаемый доход:',
                  money.format(calculation.result.income),
                ),
              ),
              Container(width: 1, height: 38, color: const Color(0xFFE0E0E5)),
              const SizedBox(width: 15),
              Expanded(
                child: _metric(
                  'Доходность:',
                  '${NumberFormat('0.#', 'ru').format(incomeRate)}%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 9),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _row(
                  'Сумма вклада:',
                  money.format(calculation.input.initialAmount),
                ),
                _row(
                  'Годовая ставка:',
                  '${NumberFormat('0.##', 'ru').format(calculation.input.annualRate)}%',
                ),
                _row('Срок:', _term(calculation)),
                const Divider(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _features(calculation.input),
                    style: const TextStyle(
                      color: Color(0xFF2929ED),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 11),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      color: violet,
                      size: 19,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat('dd.MM.yyyy')
                          .format(calculation.input.endDate),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: violet,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  onPressed: () => _open(calculation),
                  child: const Text(
                    'Перейти',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFFFEEEE),
                  foregroundColor: const Color(0xFFFF4149),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                onPressed: () => _delete(calculation),
                icon: const Icon(Icons.delete_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(color: Color(0xFF777780), fontSize: 11),
      ),
      Text(
        value,
        style: const TextStyle(
          color: violet,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF777780), fontSize: 11),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );

  Widget _empty() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Column(
      children: [
        const Spacer(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Image.asset('assets/images/folder.png', height: 145),
              const SizedBox(height: 12),
              const Text(
                'У вас пока нет\nсохраненных расчетов',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Text(
                'После первого расчёта он появится здесь.\nВсе расчёты сохраняются, чтобы быстрее\nвозвращаться к ним',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF777780),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex: 2),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: violet,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => context.router.replace(const DepositRoute()),
            icon: const Icon(Icons.calculate_rounded, size: 21),
            label: const Text(
              'Перейти к расчету',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _bottomNavigation(BuildContext context) => Container(
    color: background,
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    child: SafeArea(
      top: false,
      child: Container(
        height: 66,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Color(0x16000000), blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomItem(
              Icons.home_rounded,
              'Главная',
              false,
              () => context.router.replace(const HomeRoute()),
            ),
            const _BottomItem(
              Icons.format_list_bulleted_rounded,
              'Мои расчеты',
              true,
              null,
            ),
          ],
        ),
      ),
    ),
  );

  String _term(SavedCalculation calculation) {
    final start = calculation.input.startDate, end = calculation.input.endDate;
    final months = math.max(
      1,
      (end.year - start.year) * 12 + end.month - start.month,
    );
    if (months % 12 == 0) {
      final years = months ~/ 12;
      return '$years ${years == 1
          ? 'год'
          : years < 5
          ? 'года'
          : 'лет'}';
    }
    return '$months ${months == 1
        ? 'месяц'
        : months < 5
        ? 'месяца'
        : 'месяцев'}';
  }

  String _features(DepositCalculationInput input) {
    final values = <String>[];
    if (input.capitalization != CapitalizationPeriod.none) {
      values.add('Капитализация');
    }
    if (input.refills.isNotEmpty) values.add('Пополнение');
    if (input.withdrawals.isNotEmpty) values.add('Снятие');
    return values.isEmpty ? 'Без дополнительных условий' : values.join(' • ');
  }

  Future<void> _open(SavedCalculation calculation) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            DepositResultScreen(calculation.result, calculation.input),
      ),
    );
  }

  Future<void> _delete(SavedCalculation calculation) async {
    await storage.delete(calculation);
    if (mounted) setState(() => calculations = storage.load());
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem(this.icon, this.title, this.selected, this.onTap);
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
            color: selected ? _MyCalculationsScreenState.violet : Colors.grey,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
