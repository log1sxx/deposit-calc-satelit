import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/theme/app_fonts.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_image_viewer.dart';
import 'package:deposit_calc_satelit/features/articles/presentation/widgets/article_layout.dart';
import 'package:flutter/material.dart';

@RoutePage()
class KeyRateArticleScreen extends StatelessWidget {
  const KeyRateArticleScreen({super.key});

  @override
  Widget build(BuildContext context) => const ArticleScaffold(
    headerTitle: 'Ключевая ставка и вклады: взаимосвязь',
    children: [
      ArticleImage(
        assetPath: 'assets/images/kluch_stav_link_main_background.png',
      ),
      SizedBox(height: 16),
      Text(
        'Ключевая ставка и вклады: взаимосвязь',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 10),
      Text(
        'Ключевая ставка — один из главных ориентиров для процентных ставок в экономике. Когда Банк России меняет её, со временем это отражается и на условиях банковских вкладов.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 14),
      ArticleCallout(
        title: 'Ключевая ставка растёт — вклады становятся привлекательнее',
        text: 'При повышении ключевой ставки банкам становится дороже привлекать деньги. Поэтому они могут повышать ставки по новым вкладам, чтобы заинтересовать клиентов. Например, если ключевая ставка растёт, через некоторое время на рынке могут появиться вклады с более высокой доходностью.',
      ),
      SizedBox(height: 10),
      ArticleCallout(
        title: 'Ключевая ставка снижается — ставки по вкладам тоже могут снижаться',
        text: 'При снижении ключевой ставки происходит обратная ситуация. Банки постепенно пересматривают предложения, и новые вклады могут открываться уже под меньший процент. При этом ставка по уже открытому вкладу с фиксированной ставкой обычно сохраняется до окончания его срока согласно условиям договора.',
      ),
      SizedBox(height: 16),
      ArticleImage(
        assetPath:
            'assets/images/how_to_work_kluch_stav_link_main_background.png',
        fit: BoxFit.fitWidth,
      ),
      SizedBox(height: 16),
      Text(
        'Почему ставки банков отличаются?',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'Ключевая ставка — ориентир, а не готовая ставка по вкладу. Каждый банк самостоятельно определяет условия своих продуктов. На предложение могут влиять срок вклада, сумма, возможность пополнения и снятия, способ выплаты процентов, акции и другие условия банка.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 16),
      Text(
        'Когда это особенно важно?',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 8),
      Text(
        'Если ставки находятся на высоком уровне и ожидается их снижение, вклад на более длительный срок может позволить зафиксировать текущую ставку. Если же ставки растут, короткие вклады дают больше гибкости: после окончания срока можно рассмотреть новые предложения банков.',
        style: TextStyles.body16,
      ),
      SizedBox(height: 14),
      ArticleCallout(
        title: 'Итог',
        text: 'Ключевая ставка и ставки по вкладам связаны, но не меняются строго один к одному. Следить за ключевой ставкой полезно, чтобы лучше понимать ситуацию на рынке и выбирать подходящий момент и срок для открытия вклада.',
      ),
    ],
  );
}
