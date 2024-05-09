import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

class ViewPdfArgs {
  final String? pdfUrl;
  final PdfEntity? pdf;

  ViewPdfArgs(this.pdfUrl, this.pdf);
}
