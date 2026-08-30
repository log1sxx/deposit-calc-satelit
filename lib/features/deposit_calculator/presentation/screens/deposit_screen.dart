import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/data/utils/formatters.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/data/utils/text_editing_extension.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/domain/models/deposit_result.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/screens/deposit_result_screen.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/styles/my_finances_colors.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_calculator_chip.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_field_with_slider.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_header.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_input_label.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_numeric_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const amountInitial = 30000.0;
const amountMin = 10000.0;
const amountMax = 20000000.0;
const amountSliderStep = 5000.0;

const termInitial = 6.0;
const termMin = 1.0;
const termMax = 30.0;

const rateInitial = 12.0;
const rateMin = 1.0;
const rateMax = 30.0;

@RoutePage()
class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController();
  final _termController = TextEditingController();
  var _termType = TermType.year;
  final _rateController = TextEditingController();
  var _startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.scaffold,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(title: "Депозитный калькулятор"),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Вы сможете рассчитать доход по вкладу, оценить, как он меняется в зависимости от разных сроков и условий выплаты процентов",
                        style: AppStyles.body.copyWith(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _wrapWithPlate(_amountInput()),
                      const SizedBox(height: 12),
                      _wrapWithPlate(_termInput()),
                      const SizedBox(height: 12),
                      _wrapWithPlate(_rateInput()),
                      const SizedBox(height: 12),
                      _wrapWithPlate(_dateInput()),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFFFA800),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () {
                            final result = DepositResult(
                              amount: _amountController.numericValue,
                              term: _termController.numericValue,
                              termType: _termType,
                              rate: _rateController.numericValue,
                              startDate: _startDate,
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DepositResultScreen(result),
                              ),
                            );
                          },
                          child: const Text("Рассчитать"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieldWithSlider(
          controller: _amountController,
          initial: amountInitial,
          min: amountMin,
          max: amountMax,
          title: "Сумма вложений, ₽.:",
          sliderStep: amountSliderStep,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'от ${currency(amountMin)} до ${currency(amountMax)}',
            style: AppStyles.body.copyWith(
              color: Colors.black.withOpacity(0.5),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _termInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInputLabel("Срок вклада:"),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 120,
              child: AppNumericField(
                controller: _termController,
                initial: termInitial,
                min: termMin,
                max: termMax,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppCalculatorChip(
                title: "Лет",
                isSelected: _termType == TermType.year,
                onTap: () {
                  setState(() => _termType = TermType.year);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppCalculatorChip(
                title: "Месяцев",
                isSelected: _termType == TermType.month,
                onTap: () {
                  setState(() => _termType = TermType.month);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _rateInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInputLabel("Ставка, % годовых:"),
        const SizedBox(height: 12),
        AppNumericField(
          controller: _rateController,
          initial: rateInitial,
          min: rateMin,
          max: rateMax,
        ),
      ],
    );
  }

  Widget _dateInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInputLabel("Дата открытия вклада:"),
        const SizedBox(height: 12),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                initialDate: _startDate,
              );
              if (pickedDate != null && pickedDate != _startDate) {
                setState(() => _startDate = pickedDate);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dateDMY(_startDate), style: AppStyles.body),
                  SvgPicture.asset('assets/icons/calendar.svg', width: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _wrapWithPlate(Widget widget) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppStyles.light,
      ),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: widget,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _termController.dispose();
    _rateController.dispose();
    super.dispose();
  }
}
