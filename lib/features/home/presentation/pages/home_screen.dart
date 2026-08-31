import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/di/service_locator.dart';
import 'package:deposit_calc_satelit/core/routes/app_router.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/data/saved_calculations.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/screens/deposit_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const violet = Color(0xFF6752F4);
  static const background = Color(0xFFF3F4F8);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const violet = HomeScreen.violet;
  static const background = HomeScreen.background;
  static final money = NumberFormat.currency(
    locale: 'ru',
    symbol: '₽',
    decimalDigits: 0,
  );
  late final SavedCalculationsStorage storage;
  final scrollController = ScrollController();
  List<SavedCalculation> calculations = [];
  bool showQuickCalculationButton = false;

  @override
  void initState() {
    super.initState();
    storage = SavedCalculationsStorage(getIt());
    calculations = storage.load();
    scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final shouldShow = scrollController.offset >= 245;
    if (shouldShow != showQuickCalculationButton) {
      setState(() => showQuickCalculationButton = shouldShow);
    }
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _openCalculator(BuildContext context) async {
    await context.router.push(const DepositRoute());
    if (mounted) setState(() => calculations = storage.load());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: background,
    body: ListView(
      controller: scrollController,
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
        if (calculations.isEmpty)
          _emptyCalculations(context)
        else
          _savedCalculations(),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Text(
            'Полезное',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        _articles(context),
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

  Widget _savedCalculations() => Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 145,
          child: Row(
            children: [
              for (
                var index = 0;
                index < (calculations.length > 2 ? 2 : calculations.length);
                index++
              ) ...[
                if (index > 0) const SizedBox(width: 10),
                Expanded(child: _calculationCard(context, calculations[index])),
              ],
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: violet,
              side: const BorderSide(color: violet),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => _showAllCalculations(context),
            child: const Text(
              'Все расчеты',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _calculationCard(BuildContext context, SavedCalculation calculation) {
    final months = _termMonths(calculation);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _openSaved(context, calculation),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Доход:',
                        style: TextStyle(
                          color: Color(0xFF777780),
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('dd.MM.yyyy')
                          .format(calculation.input.endDate),
                      style: const TextStyle(
                        color: Color(0xFF777780),
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
                Text(
                  money.format(calculation.result.income),
                  style: const TextStyle(
                    color: violet,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 9),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _valueChip(money.format(calculation.input.initialAmount)),
                    _valueChip(
                      '${NumberFormat('0.##', 'ru').format(calculation.input.annualRate)}%',
                    ),
                    _valueChip('$months мес.'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _valueChip(String value) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(9),
    ),
    child: Text(value, style: const TextStyle(fontSize: 11)),
  );

  int _termMonths(SavedCalculation calculation) {
    final start = calculation.input.startDate;
    final end = calculation.input.endDate;
    return (end.year - start.year) * 12 + end.month - start.month;
  }

  Future<void> _openSaved(
    BuildContext context,
    SavedCalculation calculation,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            DepositResultScreen(calculation.result, calculation.input),
      ),
    );
    if (mounted) setState(() => calculations = storage.load());
  }

  void _showAllCalculations(BuildContext context) {
    context.router.push(const MyCalculationsRoute());
  }

  Widget _articles(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _Article(
          'assets/icons/procents.svg',
          'Как работает капитализация?',
          () => context.router.push(const CapitalizationArticleRoute()),
        ),
        const SizedBox(height: 9),
        _Article(
          'assets/icons/protected_wallet.svg',
          'Вклады или накопительный счёт?',
          () => context.router.push(const DepositOrSavingsArticleRoute()),
        ),
        const SizedBox(height: 9),
        _Article(
          'assets/icons/calendar.svg',
          'Как выбрать срок вклада?',
          () => context.router.push(const DepositTermArticleRoute()),
        ),
        const SizedBox(height: 9),
        _Article(
          'assets/icons/chart.svg',
          'Ключевая ставка и вклады: взаимосвязь',
          () => context.router.push(const KeyRateArticleRoute()),
        ),
        const SizedBox(height: 9),
        _Article(
          'assets/icons/circle_locker.svg',
          'Что происходит при досрочном закрытии вклада',
          () => context.router.push(const EarlyClosureArticleRoute()),
        ),
      ],
    ),
  );

  Widget _bottomNavigation() => Container(
    color: background,
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, animation) => SizeTransition(
              sizeFactor: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: showQuickCalculationButton
                ? Padding(
                    key: const ValueKey('quick-calculation-button'),
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: violet,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _openCalculator(context),
                        icon: const Icon(Icons.calculate_rounded, size: 20),
                        label: const Text(
                          'Начать новый расчет',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(
                    key: ValueKey('quick-calculation-button-hidden'),
                  ),
          ),
          Container(
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
                const _BottomItem(Icons.home_rounded, 'Главная', true),
                _BottomItem(
                  Icons.format_list_bulleted_rounded,
                  'Мои расчеты',
                  false,
                  () => context.router.push(const MyCalculationsRoute()),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Article extends StatelessWidget {
  const _Article(this.asset, this.title, [this.onTap]);
  final String asset, title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
      ),
    ),
  );
}

class _BottomItem extends StatelessWidget {
  const _BottomItem(this.icon, this.title, this.selected, [this.onTap]);
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
          Icon(icon, color: selected ? HomeScreen.violet : Colors.grey),
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
