import 'package:pdf_library/core/resources/data_state.dart';
import 'package:pdf_library/core/usecases/usecase.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/domain/repositories/pdf_repo.dart';

class GetRemotePdfUseCase implements UseCase<DataState<PdfEntity>, String> {
  final PdfRepo _pdfRepo;

  GetRemotePdfUseCase(this._pdfRepo);

  @override
  Future<DataState<PdfEntity>> call({String? params}) async {
    return await _pdfRepo.getRemotePdf(params!);
  }
}
