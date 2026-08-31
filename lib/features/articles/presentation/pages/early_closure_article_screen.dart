import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/theme/app_fonts.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_image_viewer.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_layout.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EarlyClosureArticleScreen extends StatelessWidget {
  const EarlyClosureArticleScreen({super.key});

  @override
  Widget build(BuildContext context) => const ArticleScaffold(
    headerTitle: 'Что происходит при досрочном закрытии вклада?',
    children: [
      ArticleImage(
        assetPath: 'assets/images/dosroch_close_main_background.png',
      ),
      SizedBox(height: 16),
      Text(
        'Что происходит при досрочном закрытии вклада',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 10),
      Text(
        'Иногда деньги со вклада нужны раньше запланированного срока. Забрать их можно, но итоговый доход может оказаться значительно меньше ожидаемого. Всё зависит от условий конкретного вклада.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 16),
      Text(
        'Проценты могут пересчитать',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'Главный риск досрочного закрытия — потеря части начисленных процентов. Если договор не предусматривает сохранение ставки при досрочном закрытии, банк может пересчитать доход за фактический период хранения денег по другой, обычно значительно более низкой ставке.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 14),
      ArticleCallout(
        title: 'Простой пример',
        text: 'Вклад был открыт под 15% годовых, но при досрочном закрытии проценты могут быть рассчитаны по ставке «до востребования».',
      ),
      SizedBox(height: 16),
      Text(
        'А что с уже выплаченными процентами?',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'Если проценты выплачивались ежемесячно или капитализировались, при закрытии вклада банк рассчитывает итоговую сумму в соответствии с условиями договора. Если ранее было начислено больше процентов, чем полагается после пересчёта, разница может быть учтена при окончательной выплате.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 16),
      Text(
        'Можно ли снять только часть денег?',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'Это зависит от условий продукта. Некоторые вклады позволяют частичное снятие до определённого остатка без полного закрытия. Если такой возможности нет, для получения денег потребуется закрыть весь вклад.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 16),
      Text(
        'Как избежать потери дохода?',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'Перед открытием вклада обратите внимание на условия досрочного расторжения и возможность частичного снятия. Если есть вероятность, что деньги понадобятся раньше, можно не размещать всю сумму на одном вкладе: часть оставить на накопительном счёте или распределить между несколькими вкладами.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 14),
      ArticleCallout(
        title: 'Итог',
        text: 'Досрочно закрыть вклад можно, но ожидаемый доход может уменьшиться. Поэтому перед закрытием полезно сравнить сумму, которую вы получите сейчас, с доходом при сохранении вклада до конца срока.',
      ),
    ],
  );
}
