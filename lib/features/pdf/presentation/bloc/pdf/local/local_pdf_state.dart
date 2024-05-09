import 'package:equatable/equatable.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

abstract class LocalPdfState extends Equatable {
  final PdfEntity? pdf;
  final List<PdfEntity>? pdfList;

  const LocalPdfState({this.pdf, this.pdfList});

  @override
  List<Object?> get props => [pdf, pdfList];
}

class LocalPdfListLoadingState extends LocalPdfState {
  const LocalPdfListLoadingState();
}

class LocalPdfReadyState extends LocalPdfState {
  const LocalPdfReadyState(PdfEntity pdf) : super(pdf: pdf);
}

class LocalPdfListReadyState extends LocalPdfState {
  const LocalPdfListReadyState(List<PdfEntity> pdfList)
      : super(pdfList: pdfList);
}
