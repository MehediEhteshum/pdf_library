import 'dart:async';

import 'package:pdf_library/core/usecases/usecase.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/domain/repositories/pdf_repo.dart';

class GetSavedPdfListUseCase implements UseCase<List<PdfEntity>, void> {
  final PdfRepo _pdfRepo;

  GetSavedPdfListUseCase(this._pdfRepo);

  @override
  FutureOr<List<PdfEntity>> call({void params}) {
    return _pdfRepo.getSavedPdfs();
  }
}
