import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

class PdfModel extends PdfEntity {
  const PdfModel({
    super.url,
    super.name,
    super.fileLocation,
    super.data,
    super.isSaved,
  });

  factory PdfModel.fromEntity(PdfEntity pdf) {
    return PdfModel(
      url: pdf.url,
      name: pdf.name,
      fileLocation: pdf.fileLocation,
      data: pdf.data,
      isSaved: pdf.isSaved,
    );
  }
}
