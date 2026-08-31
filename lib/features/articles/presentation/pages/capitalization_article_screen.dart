import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/theme/app_fonts.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_image_viewer.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_layout.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CapitalizationArticleScreen extends StatelessWidget {
  const CapitalizationArticleScreen({super.key});

  @override
  Widget build(BuildContext context) => ArticleScaffold(
    headerTitle: 'Как работает капитализация?',
    children: [
      const ArticleImage(
        assetPath: 'assets/images/capitalization_main_background.png',
      ),
      const SizedBox(height: 16),
      const Text(
        'Как работает капитализация?',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 10),
      const Text(
        'Капитализация — это начисление процентов не только на первоначальную сумму вклада, но и на уже полученные проценты. Проще говоря, ваши проценты начинают приносить новые проценты.',
        style: TextStyles.body16,
      ),
      const SizedBox(height: 14),
      const ArticleCallout(
        title: 'Простой пример',
        text: 'Допустим, вы открыли вклад на 100 000 ₽ под 12% годовых с ежемесячной капитализацией.\n\nПосле первого месяца банк начислит проценты и добавит их к сумме вклада. В следующем месяце проценты будут рассчитываться уже от увеличенной суммы. Так происходит при каждой следующей капитализации.\n\nВ результате к концу срока доход будет немного выше, чем если бы проценты просто выплачивались отдельно.',
      ),
      const SizedBox(height: 16),
      const ArticleImage(
        assetPath: 'assets/images/how_to_work_capitalization.png',
        fit: BoxFit.fitWidth,
      ),
      const SizedBox(height: 16),
      const Text(
        'Чем чаще — тем больше доход',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 8),
      const Text(
        'Капитализация может происходить ежемесячно, ежеквартально, ежегодно или с другой периодичностью. При одинаковой ставке и сроке более частая капитализация обычно увеличивает итоговый доход.',
        style: TextStyles.body16,
      ),
      const SizedBox(height: 16),
      const Text(
        'Капитализация или выплата процентов?',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 8),
      const Text(
        'Если проценты капитализируются, они остаются на вкладе и продолжают приносить доход. Если проценты выплачиваются на карту или отдельный счёт, сумма вклада не увеличивается — поэтому новые проценты на ранее полученный доход не начисляются.',
        style: TextStyles.body16,
      ),
      const SizedBox(height: 14),
      const ArticleCallout(
        title: 'Итог',
        text: 'Капитализация особенно заметна на длительных сроках. Чем дольше деньги находятся на вкладе, тем сильнее проявляется эффект «процентов на проценты».',
      ),
    ],
  );
}
