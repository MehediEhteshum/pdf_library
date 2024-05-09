import 'dart:async';

import 'package:pdf_library/core/usecases/usecase.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/domain/repositories/pdf_repo.dart';

class SavePdfUseCase implements UseCase<void, PdfEntity> {
  final PdfRepo _pdfRepo;

  SavePdfUseCase(this._pdfRepo);

  @override
  FutureOr<void> call({PdfEntity? params}) async {
    await _pdfRepo.savePdf(params!);
  }
}
