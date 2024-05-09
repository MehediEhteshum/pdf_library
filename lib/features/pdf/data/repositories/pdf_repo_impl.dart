import 'package:pdf_library/core/resources/data_state.dart';
import 'package:pdf_library/features/pdf/data/data_sources/local/local_pdf_service.dart';
import 'package:pdf_library/features/pdf/data/data_sources/remote/pdf_url_service.dart';
import 'package:pdf_library/features/pdf/data/models/pdf_model.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/domain/repositories/pdf_repo.dart';

class PdfRepoImpl implements PdfRepo {
  final PdfUrlService _pdfUrlService;
  final LocalPdfService _localPdfService;

  PdfRepoImpl(this._pdfUrlService, this._localPdfService);

  // remote
  @override
  Future<DataState<PdfModel>> getRemotePdf(String url) async {
    try {
      final data = await _pdfUrlService.getRemotePdf(url);
      return DataSuccess(data);
    } on Exception catch (e) {
      return DataFailed(e);
    }
  }

  // local
  @override
  List<PdfModel> getSavedPdfs() {
    return _localPdfService.getSavedPdfs();
  }

  @override
  Future<PdfModel> getSavedPdf(String url) async {
    return await _localPdfService.getSavedPdf(url);
  }

  @override
  Future<void> deletePdf(String url) {
    throw UnimplementedError();
  }

  @override
  Future<void> savePdf(PdfEntity pdf) {
    throw UnimplementedError();
  }
}
