import 'package:flutter/material.dart';
import 'package:pdf_library/config/routes/view_pdf_args.dart';
import 'package:pdf_library/core/constants/constants.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

class PdfTile extends StatefulWidget {
  const PdfTile({
    super.key,
    required this.pdf,
  });

  final PdfEntity pdf;

  @override
  State<PdfTile> createState() => _PdfTileState();
}

class _PdfTileState extends State<PdfTile> with SingleTickerProviderStateMixin {
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
      end: 0.75,
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
        child: Center(
            child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 1.5)),
          child: Text(
            widget.pdf.name!,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: kToolbarHeight * 0.4,
            ),
          ),
        )),
      ),
    );
  }

  void _navigate(context) {
    _animationController.forward().then((_) {
      Navigator.pushNamed(
        context,
        viewPdfRoute,
        arguments: ViewPdfArgs(null, widget.pdf),
      );
      _animationController.reset();
    });
  }
}
