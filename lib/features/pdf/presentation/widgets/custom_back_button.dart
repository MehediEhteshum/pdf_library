import 'package:flutter/material.dart';
import 'package:pdf_library/core/constants/constants.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton>
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
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        ),
      ),
    );
  }

  void _navigate(BuildContext context) {
    _animationController.forward().then((_) {
      Navigator.pop(context);
      _animationController.reset();
    });
  }
}
