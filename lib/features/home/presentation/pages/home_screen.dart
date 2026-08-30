import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const violet = Color(0xFF6752F4);
  static const background = Color(0xFFF3F4F8);

  void _openCalculator(BuildContext context) {
    context.router.push(const DepositRoute());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: background,
    body: ListView(
      padding: EdgeInsets.zero,
      children: [
        _hero(context),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 6, 16, 10),
          child: Text(
            'Мои расчеты',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        _emptyCalculations(context),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Text(
            'Полезное',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        _articles(),
        const SizedBox(height: 92),
      ],
    ),
    bottomNavigationBar: _bottomNavigation(),
  );

  Widget _hero(BuildContext context) => SizedBox(
    height: 260,
    child: Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 48, 178, 22),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main_page_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Достигайте большего\nс умными расчётами',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Рассчитайте доход по вкладу и примите лучшее решение',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 4,
          child: Material(
            color: Colors.white,
            elevation: 5,
            shadowColor: const Color(0x22000000),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _openCalculator(context),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E5FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset('assets/icons/calculator.svg'),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Начать новый расчёт',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Рассчитайте доход по вкладу с учетом капитализации, пополнений, частичных снятий и досрочного закрытия',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF777780),
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: violet,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _emptyCalculations(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Image.asset('assets/images/folder.png', height: 95),
        const Text(
          'У вас пока нет сохраненных расчетов',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        const Text(
          'После первого расчёта он появится здесь. Все расчёты сохраняются, чтобы быстрее возвращаться к ним',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10, color: Color(0xFF888891)),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: violet,
            side: const BorderSide(color: violet),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => _openCalculator(context),
          child: const Text('Перейти к расчёту'),
        ),
      ],
    ),
  );

  Widget _articles() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: const [
        _Article('assets/icons/procents.svg', 'Как работает капитализация?'),
        SizedBox(height: 9),
        _Article(
          'assets/icons/protected_wallet.svg',
          'Вклады или накопительный счёт?',
        ),
        SizedBox(height: 9),
        _Article('assets/icons/calendar.svg', 'Как выбрать срок вклада?'),
        SizedBox(height: 9),
        _Article(
          'assets/icons/chart.svg',
          'Ключевая ставка и вклады: взаимосвязь',
        ),
        SizedBox(height: 9),
        _Article(
          'assets/icons/circle_locker.svg',
          'Что происходит при досрочном закрытии вклада',
        ),
      ],
    ),
  );

  Widget _bottomNavigation() => Container(
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomItem(Icons.home_rounded, 'Главная', true),
            _BottomItem(
              Icons.format_list_bulleted_rounded,
              'Мои расчеты',
              false,
            ),
          ],
        ),
      ),
    ),
  );
}

class _Article extends StatelessWidget {
  const _Article(this.asset, this.title);
  final String asset, title;
  @override
  Widget build(BuildContext context) => Container(
    height: 58,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E5FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(asset),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 13))),
        Container(
          width: 30,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F8),
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Icon(Icons.chevron_right, color: Color(0xFF9A9AA2)),
        ),
      ],
    ),
  );
}

class _BottomItem extends StatelessWidget {
  const _BottomItem(this.icon, this.title, this.selected);
  final IconData icon;
  final String title;
  final bool selected;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: selected ? HomeScreen.violet : Colors.grey),
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
