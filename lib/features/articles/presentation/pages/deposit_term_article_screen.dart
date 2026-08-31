import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/theme/app_fonts.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_image_viewer.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_layout.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DepositTermArticleScreen extends StatelessWidget {
  const DepositTermArticleScreen({super.key});

  @override
  Widget build(BuildContext context) => const ArticleScaffold(
    headerTitle: 'Как выбрать срок вклада?',
    children: [
      ArticleImage(assetPath: 'assets/images/srok_invs_main_background.png'),
      SizedBox(height: 16),
      Text(
        'Как выбрать срок вклада?',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 10),
      Text(
        'Срок вклада влияет не только на то, как долго деньги будут находиться в банке, но и на ставку, итоговый доход и возможность воспользоваться средствами. Самый длинный вклад не всегда оказывается самым выгодным.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 14),
      ArticleNumberedCard(
        number: 1,
        title: 'Определите, когда понадобятся деньги',
        text: 'Начните с цели. Если деньги могут понадобиться через несколько месяцев, не стоит размещать их на длительный срок только ради более высокой ставки. При досрочном закрытии вклада банк может пересчитать проценты по значительно более низкой ставке, и часть ожидаемого дохода будет потеряна.',
      ),
      SizedBox(height: 10),
      ArticleNumberedCard(
        number: 2,
        title: 'Сравните ставки на разные сроки',
        text: 'Более длительный срок не всегда означает более высокую ставку. Банк может предлагать лучшие условия, например, на 3 или 6 месяцев, а не на год. Поэтому сравнивайте не только процентную ставку, но и итоговый доход за выбранный период.',
      ),
      SizedBox(height: 10),
      ArticleNumberedCard(
        number: 3,
        title: 'Учитывайте ситуацию со ставками',
        text: 'Если ставки высокие и вы хотите зафиксировать условия надолго, длительный вклад может быть интереснее. Если ожидаете, что ставки могут вырасти, короткий срок даст больше гибкости: после окончания вклада деньги можно разместить заново уже на новых условиях.',
      ),
      SizedBox(height: 10),
      ArticleNumberedCard(
        number: 4,
        title: 'Не забывайте о финансовом резерве',
        text: 'Не стоит размещать на долгий срок все свободные деньги. Часть средств лучше оставить доступной на случай непредвиденных расходов. Можно также разделить сумму между несколькими вкладами с разными сроками. Тогда деньги будут освобождаться постепенно.',
      ),
      SizedBox(height: 14),
      Text(
        'Выбирайте срок не по принципу «где ставка выше», а исходя из того, когда вам понадобятся деньги, насколько важен свободный доступ к ним и какие условия предлагает банк на разных сроках.',
        style: TextStyles.body16,
      ),
    ],
  );
}
