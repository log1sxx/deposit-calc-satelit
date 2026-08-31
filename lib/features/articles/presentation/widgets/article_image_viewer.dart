import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({
    required this.assetPath,
    super.key,
    this.fit = BoxFit.cover,
    this.borderRadius = 14,
  });

  final String assetPath;
  final BoxFit fit;
  final double borderRadius;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(borderRadius),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => showArticleImage(context, assetPath),
      child: Image.asset(assetPath, width: double.infinity, fit: fit),
    ),
  );
}

Future<void> showArticleImage(BuildContext context, String assetPath) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Закрыть просмотр изображения',
    barrierColor: Colors.black.withValues(alpha: 0.88),
    transitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (dialogContext, animation, secondaryAnimation) =>
        _ImageViewer(assetPath: assetPath),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: .97, end: 1).animate(animation),
            child: child,
          ),
        ),
  );
}

class _ImageViewer extends StatelessWidget {
  const _ImageViewer({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 72),
              child: GestureDetector(
                onTap: () {},
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(assetPath, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF17171B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              tooltip: 'Закрыть',
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
            ),
          ),
        ],
      ),
    ),
  );
}
