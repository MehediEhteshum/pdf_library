import 'package:equatable/equatable.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

abstract class RemotePdfState extends Equatable {
  final PdfEntity? pdf;
  final Exception? error;

  const RemotePdfState({this.pdf, this.error});

  @override
  List<Object?> get props => [pdf, error];
}

class RemotePdfLoadingState extends RemotePdfState {
  const RemotePdfLoadingState();
}

class RemotePdfReadyState extends RemotePdfState {
  const RemotePdfReadyState(PdfEntity pdf) : super(pdf: pdf);
}

class RemotePdfErrorState extends RemotePdfState {
  const RemotePdfErrorState(Exception error) : super(error: error);
}
