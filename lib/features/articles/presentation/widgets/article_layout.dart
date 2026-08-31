import 'package:auto_route/auto_route.dart';
import 'package:deposit_calc_satelit/core/routes/app_router.dart';
import 'package:deposit_calc_satelit/core/theme/app_fonts.dart';
import 'package:deposit_calc_satelit/core/widgets/app_header.dart';
import 'package:flutter/material.dart';

class ArticleScaffold extends StatelessWidget {
  const ArticleScaffold({
    required this.headerTitle,
    required this.children,
    super.key,
  });

  static const violet = Color(0xFF6757ED);
  static const background = Color(0xFFF3F4F8);
  final String headerTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: background,
    appBar: AppHeader(
      title: headerTitle,
      onBack: () => context.router.maybePop(),
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
      children: children,
    ),
    bottomNavigationBar: _bottomNavigation(context),
  );

  Widget _bottomNavigation(BuildContext context) => Container(
    color: background,
    padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomItem(
              Icons.home_rounded,
              'Главная',
              true,
              () => context.router.replace(const HomeRoute()),
            ),
            _BottomItem(
              Icons.format_list_bulleted_rounded,
              'Мои расчёты',
              false,
              () => context.router.replace(const MyCalculationsRoute()),
            ),
          ],
        ),
      ),
    ),
  );
}

class ArticleCallout extends StatelessWidget {
  const ArticleCallout({required this.title, required this.text, super.key});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFECEBFF),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.chat_bubble_rounded,
              color: ArticleScaffold.violet,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(text, style: TextStyles.body16),
      ],
    ),
  );
}

class ArticleNumberedCard extends StatelessWidget {
  const ArticleNumberedCard({
    required this.number,
    required this.title,
    required this.text,
    super.key,
  });

  final int number;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFECEBFF),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: ArticleScaffold.violet,
                shape: BoxShape.circle,
              ),
              child: Text(
                number.toString().padLeft(2, '0'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(text, style: TextStyles.body16),
      ],
    ),
  );
}

class _BottomItem extends StatelessWidget {
  const _BottomItem(this.icon, this.title, this.selected, this.onTap);
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: selected ? ArticleScaffold.violet : Colors.grey),
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
