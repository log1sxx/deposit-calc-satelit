import 'package:deposit_calc_satelit/features/deposit_calculator/data/utils/formatters.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/domain/models/deposit_payment.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/domain/models/deposit_result.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/styles/my_finances_colors.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/widgets/app_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DepositResultScreen extends StatelessWidget {
  final DepositResult result;

  const DepositResultScreen(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.appBarBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(canPop: true, title: "Результат расчета"),
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _briefInfo(context),
                      const SizedBox(height: 20),
                      _payments(context),
                      const SizedBox(height: 20),
                      _warning(context),
                      const SizedBox(height: 24),
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

  Widget _briefInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currency(result.profit),
            style: AppStyles.display.copyWith(color: AppStyles.secondary),
          ),
          Text(
            "Составит ваш доход по вкладу",
            style: AppStyles.body.copyWith(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.5), height: 32),
          Text(
            "Общая сумма выплат на конец срока:",
            style: AppStyles.body.copyWith(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            currency(result.total),
            style: AppStyles.display.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _payments(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Выплаты по вкладу",
            style: AppStyles.display.copyWith(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppStyles.light,
            ),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Год:",
                      style: AppStyles.body.copyWith(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Сумма начисленных %:",
                        style: AppStyles.body.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...result.payments.map(_payment),
                Divider(color: Colors.black.withOpacity(0.2), thickness: 1),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      "Итого:",
                      style: AppStyles.h1.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        currency(result.profit),
                        style: AppStyles.h1.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
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

  Widget _payment(DepositPayment payment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            dateMY(payment.date),
            style: AppStyles.body.copyWith(fontSize: 20),
          ),
          Expanded(
            child: Text(
              currency(payment.sum),
              style: AppStyles.h1.copyWith(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _warning(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppStyles.beige,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/warning.svg', width: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              "С дохода по вкладам, который вы получите начиная с 1 января 2023 года, может взиматься НДФЛ",
              style: AppStyles.body.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
