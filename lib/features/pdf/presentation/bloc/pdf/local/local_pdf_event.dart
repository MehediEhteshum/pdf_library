import 'package:equatable/equatable.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

abstract class LocalPdfEvent extends Equatable {
  final String? url;
  final PdfEntity? pdf;

  const LocalPdfEvent({this.url, this.pdf});

  @override
  List<Object?> get props => [url, pdf];
}

class GetLocalPdfListEvent extends LocalPdfEvent {
  const GetLocalPdfListEvent();
}

class GetLocalPdfEvent extends LocalPdfEvent {
  const GetLocalPdfEvent(String url) : super(url: url);
}

class SaveLocalPdfEvent extends LocalPdfEvent {
  const SaveLocalPdfEvent(PdfEntity pdf) : super(pdf: pdf);
}

class DeleteLocalPdfEvent extends LocalPdfEvent {
  const DeleteLocalPdfEvent(String url) : super(url: url);
}
