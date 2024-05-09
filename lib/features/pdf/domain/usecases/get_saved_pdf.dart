import 'dart:async';

import 'package:pdf_library/core/usecases/usecase.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/domain/repositories/pdf_repo.dart';

class GetSavedPdfUseCase implements UseCase<PdfEntity, String> {
  final PdfRepo _pdfRepo;

  GetSavedPdfUseCase(this._pdfRepo);

  @override
  FutureOr<PdfEntity> call({String? params}) {
    return _pdfRepo.getSavedPdf(params!);
  }
}
