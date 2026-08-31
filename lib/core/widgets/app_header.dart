import 'package:deposit_calc_satelit/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    required this.title,
    super.key,
    this.showBackButton = true,
    this.onBack,
    this.actions,
  });

  static const leftColor = Color(0xFF0B133B);
  static const rightColor = Color(0xFF03358C);

  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) => AppBar(
    toolbarHeight: preferredSize.height,
    automaticallyImplyLeading: false,
    backgroundColor: leftColor,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    flexibleSpace: const SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [leftColor, rightColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    ),
    leadingWidth: showBackButton ? 74 : 16,
    leading: showBackButton
        ? Padding(
            padding: const EdgeInsets.only(left: 20, top: 9, bottom: 9),
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF434C7A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: onBack ?? () => Navigator.maybePop(context),
              icon: const Icon(Icons.chevron_left_rounded, size: 34),
            ),
          )
        : const SizedBox.shrink(),
    titleSpacing: showBackButton ? 12 : 0,
    centerTitle: !showBackButton,
    title: Text(title, style: TextStyles.headerTitle),
    actions: actions,
  );
}
