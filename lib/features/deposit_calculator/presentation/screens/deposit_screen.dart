import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/domain/deposit_calculation.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/screens/deposit_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

@RoutePage()
class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});
  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  static const violet = Color(0xFF6752F4),
      navy = Color(0xFF062967),
      green = Color(0xFF2FC76E),
      background = Color(0xFFF3F4F8);
  final amount = TextEditingController(text: '100 000');
  final term = TextEditingController(text: '12');
  final rate = TextEditingController(text: '12');
  final earlyRate = TextEditingController(text: '0,01');
  DateTime start = DateTime.now(),
      earlyDate = addMonthsClamped(DateTime.now(), 6);
  bool months = true,
      capitalization = false,
      moveWeekends = false,
      early = false;
  CapitalizationPeriod capitalPeriod = CapitalizationPeriod.monthly;
  final refills = <_Draft>[], withdrawals = <_Draft>[];

  @override
  void initState() {
    super.initState();
    refills.add(_Draft(addMonthsClamped(start, 1)));
    withdrawals.add(_Draft(addMonthsClamped(start, 1)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: background,
    appBar: AppBar(
      toolbarHeight: 70,
      backgroundColor: navy,
      foregroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: IconButton.filled(
          style: IconButton.styleFrom(backgroundColor: const Color(0xFF123A7B)),
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      title: const Text('Калькулятор', style: TextStyle(fontSize: 17)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF123A7B),
              foregroundColor: Colors.white,
            ),
            onPressed: reset,
            child: const Text('Сбросить'),
          ),
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(10),
      children: [
        section(
          'Параметры вклада',
          Column(
            children: [
              number('Сумма вложений, ₽', amount),
              gap,
              label('Срок вклада'),
              const SizedBox(height: 7),
              Row(
                children: [
                  Expanded(child: input(term)),
                  const SizedBox(width: 8),
                  choice(
                    'Месяцев',
                    months,
                    () => setState(() => months = true),
                  ),
                  const SizedBox(width: 8),
                  choice('Лет', !months, () => setState(() => months = false)),
                ],
              ),
              gap,
              number('Ставка, % годовых', rate, decimal: true),
              gap,
              dateField(
                'Дата открытия вклада',
                start,
                (v) => setState(() {
                  start = v;
                  earlyDate = addMonthsClamped(v, 6);
                }),
              ),
            ],
          ),
        ),
        gap,
        switchCard(
          'Начисление процентов с учетом капитализации',
          capitalization,
          (v) => setState(() => capitalization = v),
          child: capitalization
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Периодичность капитализации:',
                      style: TextStyle(color: Color(0xFF85858D), fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: CapitalizationPeriod.values
                          .where((e) => e != CapitalizationPeriod.none)
                          .map(
                            (e) => chip(
                              e.label,
                              capitalPeriod == e,
                              () => setState(() => capitalPeriod = e),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : null,
        ),
        gap,
        switchCard(
          'Переносить даты операций с выходных на понедельник',
          moveWeekends,
          (v) => setState(() => moveWeekends = v),
        ),
        gap,
        switchCard(
          'Досрочное закрытие вклада',
          early,
          (v) => setState(() => early = v),
          child: early
              ? Column(
                  children: [
                    number(
                      'Ставка при досрочном закрытии, %',
                      earlyRate,
                      decimal: true,
                    ),
                    gap,
                    dateField(
                      'Дата досрочного закрытия',
                      earlyDate,
                      (v) => setState(() => earlyDate = v),
                    ),
                  ],
                )
              : null,
        ),
        gap,
        operations('Пополнение вклада', 'Добавить пополнение', refills, false),
        gap,
        operations(
          'Частичное снятие вклада',
          'Добавить частичное снятие',
          withdrawals,
          true,
        ),
        const SizedBox(height: 100),
      ],
    ),
    bottomNavigationBar: Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: violet,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: calculate,
                icon: const Icon(Icons.calculate_outlined),
                label: const Text(
                  'Рассчитать доходность',
                  style: TextStyle(fontWeight: FontWeight.w600),
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(Icons.home_rounded, 'Главная', true),
                  _NavItem(
                    Icons.format_list_bulleted_rounded,
                    'Мои расчёты',
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  static const gap = SizedBox(height: 12);
  Widget section(String title, Widget child) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          gap,
        ],
        child,
      ],
    ),
  );
  Widget switchCard(
    String title,
    bool value,
    ValueChanged<bool> changed, {
    Widget? child,
  }) => section(
    '',
    Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Switch(
              value: value,
              activeTrackColor: green,
              activeThumbColor: Colors.white,
              onChanged: changed,
            ),
          ],
        ),
        if (child != null) ...[gap, child],
      ],
    ),
  );
  Widget label(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      '$text:*',
      style: const TextStyle(fontSize: 13, color: Color(0xFF65656D)),
    ),
  );
  Widget number(
    String title,
    TextEditingController c, {
    bool decimal = false,
  }) => Column(
    children: [
      label(title),
      const SizedBox(height: 7),
      input(c, decimal: decimal),
    ],
  );
  Widget input(TextEditingController c, {bool decimal = false}) => TextField(
    controller: c,
    keyboardType: TextInputType.numberWithOptions(decimal: decimal),
    inputFormatters: [
      FilteringTextInputFormatter.allow(
        RegExp(decimal ? r'[0-9,.\s]' : r'[0-9\s]'),
      ),
    ],
    decoration: decoration(),
  );
  InputDecoration decoration([String? title]) => InputDecoration(
    labelText: title,
    filled: true,
    fillColor: background,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
  );
  Widget choice(String text, bool selected, VoidCallback tap) => Expanded(
    child: SizedBox(
      height: 48,
      child: FilledButton(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: selected ? violet : background,
          foregroundColor: selected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: tap,
        child: Text(text),
      ),
    ),
  );
  Widget chip(String text, bool selected, VoidCallback tap) => FilledButton(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, 40),
      padding: const EdgeInsets.symmetric(horizontal: 13),
      backgroundColor: selected ? violet : background,
      foregroundColor: selected ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: tap,
    child: Text(text, style: const TextStyle(fontSize: 12)),
  );
  Widget dateField(
    String title,
    DateTime value,
    ValueChanged<DateTime> changed,
  ) => Column(
    children: [
      label(title),
      const SizedBox(height: 7),
      InkWell(
        onTap: () async {
          final v = await showDatePicker(
            context: context,
            initialDate: value.isBefore(start) ? start : value,
            firstDate: start,
            lastDate: DateTime(2100),
          );
          if (v != null) changed(v);
        },
        child: InputDecorator(
          decoration: decoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('dd.MM.yyyy').format(value)),
              const Icon(Icons.calendar_month, color: violet),
            ],
          ),
        ),
      ),
    ],
  );
  Widget dropdown<T>(
    String title,
    T value,
    List<T> values,
    String Function(T) text,
    ValueChanged<T> changed,
  ) => DropdownButtonFormField<T>(
    initialValue: value,
    decoration: decoration(title),
    items: values
        .map((e) => DropdownMenuItem(value: e, child: Text(text(e))))
        .toList(),
    onChanged: (v) => changed(v as T),
  );

  Widget operations(
    String title,
    String addTitle,
    List<_Draft> items,
    bool withdrawal,
  ) => section(
    title,
    Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          operation(items[i], i, items, withdrawal),
          gap,
        ],
        SizedBox(
          width: double.infinity,
          child: FilledButton.tonalIcon(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE8F1FF),
              foregroundColor: const Color(0xFF1717EF),
            ),
            onPressed: () =>
                setState(() => items.add(_Draft(addMonthsClamped(start, 1)))),
            icon: const Icon(Icons.add_circle),
            label: Text(addTitle),
          ),
        ),
      ],
    ),
  );
  Widget operation(_Draft d, int index, List<_Draft> items, bool withdrawal) =>
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${withdrawal ? 'Снятие' : 'Пополнение'} №${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    d.dispose();
                    setState(() => items.removeAt(index));
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Color(0xFFB5B5B8),
                    size: 22,
                  ),
                ),
              ],
            ),
            dateField(
              'Дата операции',
              d.date,
              (v) => setState(() => d.date = v),
            ),
            gap,
            number('Сумма, ₽', d.amount),
            if (!withdrawal) ...[
              gap,
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Периодичность:',
                  style: TextStyle(color: Color(0xFF85858D), fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: RefillPeriod.values
                      .map(
                        (e) => chip(
                          e.label,
                          d.period == e,
                          () => setState(() => d.period = e),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ],
        ),
      );

  double numberValue(TextEditingController c) =>
      double.parse(c.text.replaceAll(' ', '').replaceAll(',', '.'));
  void reset() {
    for (final d in [...refills, ...withdrawals]) {
      d.dispose();
    }
    setState(() {
      amount.text = '100 000';
      term.text = '12';
      rate.text = '12';
      earlyRate.text = '0,01';
      start = DateTime.now();
      earlyDate = addMonthsClamped(start, 6);
      months = true;
      capitalization = false;
      moveWeekends = false;
      early = false;
      capitalPeriod = CapitalizationPeriod.monthly;
      refills
        ..clear()
        ..add(_Draft(addMonthsClamped(start, 1)));
      withdrawals
        ..clear()
        ..add(_Draft(addMonthsClamped(start, 1)));
    });
  }

  void calculate() {
    try {
      final t = numberValue(term).round();
      if (t <= 0) {
        throw const FormatException('Срок вклада должен быть больше нуля');
      }
      final contractualEnd = addMonthsClamped(start, months ? t : t * 12);
      if (early && earlyDate.isAfter(contractualEnd)) {
        throw const FormatException(
          'Досрочное закрытие должно быть раньше окончания вклада',
        );
      }
      final result = const DepositCalculator().calculate(
        DepositCalculationInput(
          initialAmount: numberValue(amount),
          annualRate: numberValue(rate),
          startDate: start,
          endDate: early ? earlyDate : contractualEnd,
          capitalization: capitalization
              ? capitalPeriod
              : CapitalizationPeriod.none,
          moveWeekendPayments: moveWeekends,
          earlyClosingRate: early ? numberValue(earlyRate) : null,
          refills: refills.map((e) => e.operation()).toList(),
          withdrawals: withdrawals.map((e) => e.operation()).toList(),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DepositResultScreen(result)),
      );
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Проверьте заполнение полей')),
      );
    }
  }

  @override
  void dispose() {
    amount.dispose();
    term.dispose();
    rate.dispose();
    earlyRate.dispose();
    for (final d in [...refills, ...withdrawals]) {
      d.dispose();
    }
    super.dispose();
  }
}

class _Draft {
  _Draft(this.date) : amount = TextEditingController(text: '10 000');
  DateTime date;
  final TextEditingController amount;
  RefillPeriod period = RefillPeriod.once;
  DepositOperation operation() => DepositOperation(
    date: date,
    amount: double.parse(amount.text.replaceAll(' ', '').replaceAll(',', '.')),
    period: period,
  );
  void dispose() => amount.dispose();
}

class _NavItem extends StatelessWidget {
  const _NavItem(this.icon, this.title, this.selected);
  final IconData icon;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: selected ? _DepositScreenState.violet : Colors.grey),
      Text(
        title,
        style: TextStyle(
          fontSize: 10,
          color: selected ? Colors.black : Colors.grey,
        ),
      ),
    ],
  );
}
