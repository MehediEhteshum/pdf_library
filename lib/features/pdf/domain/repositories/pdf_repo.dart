import 'package:pdf_library/core/resources/data_state.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

abstract class PdfRepo {
  // remote
  Future<DataState<PdfEntity>> getRemotePdf(String url);

  // local
  List<PdfEntity> getSavedPdfs();
  PdfEntity getSavedPdf(String url);
  Future<void> savePdf(PdfEntity article);
  Future<void> deletePdf(String url);
}
