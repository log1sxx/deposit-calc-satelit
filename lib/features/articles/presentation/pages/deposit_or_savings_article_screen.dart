import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/theme/app_fonts.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_image_viewer.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_layout.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DepositOrSavingsArticleScreen extends StatelessWidget {
  const DepositOrSavingsArticleScreen({super.key});

  @override
  Widget build(BuildContext context) => const ArticleScaffold(
    headerTitle: 'Вклад или накопительный счет?',
    children: [
      ArticleImage(assetPath: 'assets/images/inv_or_nakop_main_background.png'),
      SizedBox(height: 16),
      Text(
        'Вклад или накопительный счет?',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 10),
      Text(
        'И вклад, и накопительный счёт позволяют получать проценты на свои деньги, но работают они по-разному. Главное отличие — в свободе распоряжения средствами и условиях начисления процентов.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 16),
      Text(
        'Вклад — когда важнее зафиксировать условия',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'Вклад обычно открывается на определённый срок и под установленную ставку. Деньги выгоднее оставить до окончания срока. При досрочном закрытии банк может пересчитать проценты по более низкой ставке. Возможность пополнения и частичного снятия зависит от условий конкретного вклада. Поэтому вклад чаще подходит для денег, которые не понадобятся в ближайшее время.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 16),
      Text(
        'Накопительный счёт — когда нужен свободный доступ',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'С накопительного счёта обычно можно снимать деньги и пополнять его без закрытия счёта. Но ставка менее предсказуема: банк может изменить её. Кроме того, проценты могут рассчитываться по-разному — например, на ежедневный или минимальный остаток за месяц.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 16),
      ArticleImage(
        assetPath: 'assets/images/how_to_work_inv_or_nakop_main_background.png',
        fit: BoxFit.fitWidth,
      ),
      SizedBox(height: 16),
      Text(
        'Что выбрать?',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'Вклад стоит рассмотреть, если вы хотите разместить определённую сумму на известный срок и заранее понимать условия получения дохода. Накопительный счёт удобнее, если деньги могут понадобиться в любой момент или вы планируете регулярно пополнять накопления. Можно использовать и оба инструмента одновременно: основную сумму разместить на вкладе, а финансовый резерв оставить на накопительном счёте.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 14),
      ArticleCallout(
        title: 'Итог',
        text: 'Вклад — про более фиксированные условия, накопительный счёт — про гибкость. При выборе сравнивайте не только ставку, но и правила начисления процентов, снятия и пополнения.',
      ),
    ],
  );
}
