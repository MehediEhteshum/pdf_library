import 'dart:async';

import 'package:pdf_library/core/usecases/usecase.dart';
import 'package:pdf_library/features/pdf/domain/repositories/pdf_repo.dart';

class DeleteSavedPdfUseCase implements UseCase<void, String> {
  final PdfRepo _pdfRepo;

  DeleteSavedPdfUseCase(this._pdfRepo);

  @override
  FutureOr<void> call({String? params}) async {
    await _pdfRepo.deleteSavedPdf(params!);
  }
}
