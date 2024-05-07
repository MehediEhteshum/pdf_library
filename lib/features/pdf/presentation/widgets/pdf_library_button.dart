import 'package:flutter/material.dart';
import 'package:pdf_library/core/constants/constants.dart';

class PdfLibraryButton extends StatefulWidget {
  const PdfLibraryButton({
    super.key,
  });

  @override
  State<PdfLibraryButton> createState() => _PdfLibraryButtonState();
}

class _PdfLibraryButtonState extends State<PdfLibraryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween(
      begin: 1.0,
      end: barScaleAnimEnd,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _navigate(context),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: const Icon(
          Icons.book,
          color: Colors.black,
          size: kToolbarHeight * 0.5,
        ),
      ),
    );
  }

  void _navigate(BuildContext context) {
    _animationController.forward().then((_) {
      Navigator.pushNamed(
        context,
        "/pdf_library",
      );
      _animationController.reset();
    });
  }
}
