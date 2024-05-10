import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/domain/usecases/delete_saved_pdf.dart';
import 'package:pdf_library/features/pdf/domain/usecases/get_saved_pdf.dart';
import 'package:pdf_library/features/pdf/domain/usecases/get_saved_pdflist.dart';
import 'package:pdf_library/features/pdf/domain/usecases/save_pdf.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_event.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_state.dart';

class LocalPdfBloc extends Bloc<LocalPdfEvent, LocalPdfState> {
  final GetSavedPdfListUseCase _getSavedPdfListUseCase;
  final GetSavedPdfUseCase _getSavedPdfUseCase;
  final SavePdfUseCase _savePdfUseCase;
  final DeleteSavedPdfUseCase _deleteSavedPdfUseCase;

  LocalPdfBloc(this._getSavedPdfListUseCase, this._getSavedPdfUseCase,
      this._savePdfUseCase, this._deleteSavedPdfUseCase)
      : super(const LocalPdfLoadingState()) {
    on<GetLocalPdfListEvent>(onGetLocalPdfListEvent);
    on<GetLocalPdfEvent>(onGetLocalPdfEvent);
    on<SaveLocalPdfEvent>(onSaveLocalPdfEvent);
    on<DeleteLocalPdfEvent>(onDeleteLocalPdfEvent);
  }

  Future<void> onGetLocalPdfListEvent(
      GetLocalPdfListEvent event, Emitter<LocalPdfState> emit) async {
    final List<PdfEntity> pdfList = await _getSavedPdfListUseCase();
    emit(LocalPdfListReadyState(pdfList));
  }

  Future<void> onGetLocalPdfEvent(
      GetLocalPdfEvent event, Emitter<LocalPdfState> emit) async {
    final PdfEntity pdf = await _getSavedPdfUseCase(params: event.url);
    emit(LocalPdfReadyState(pdf));
  }

  Future<void> onSaveLocalPdfEvent(
      SaveLocalPdfEvent event, Emitter<LocalPdfState> emit) async {
    await _savePdfUseCase(params: event.pdf);
  }

  Future<void> onDeleteLocalPdfEvent(
      DeleteLocalPdfEvent event, Emitter<LocalPdfState> emit) async {
    await _deleteSavedPdfUseCase(params: event.url);
  }
}
