import 'package:flutter/material.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/bookmark_button.dart';

class BookmarkButtonHandler extends StatelessWidget {
  final ValueNotifier<dynamic> pdfUrlDataNotifier;
  final PdfEntity pdf;

  const BookmarkButtonHandler({
    super.key,
    required this.pdfUrlDataNotifier,
    required this.pdf,
  });

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    bool isPdfSaved = true;
    bool hasError = false;
    return ValueListenableBuilder(
        valueListenable: pdfUrlDataNotifier,
        builder: (context, value, child) {
          var pdfUrlData = value;
          isLoading = (pdfUrlData == 0) ? true : false;
          if (!isLoading) {
            isPdfSaved = (pdfUrlData == null) ? true : false;
            hasError = (pdfUrlData == 1) ? true : false;
          }
          if (isLoading || hasError) {
            return const SizedBox();
          } else {
            String pdfName = pdf.url!
                .split('/')
                .last
                .replaceAll(".pdf", '')
                .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_')
                .toUpperCase();
            PdfEntity newPdf = PdfEntity(
                url: pdf.url,
                name: pdfName,
                data: pdfUrlData,
                isSaved: isPdfSaved);
            return BookmarkButton(pdf: newPdf);
          }
        });
  }
}
