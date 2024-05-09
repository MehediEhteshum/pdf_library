import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

class PdfModel extends PdfEntity {
  const PdfModel({
    super.url,
    super.name,
    super.fileLocation,
    super.data,
  });
}
