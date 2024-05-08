import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/core/resources/data_state.dart';
import 'package:pdf_library/features/pdf/domain/usecases/get_remote_pdf.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_event.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_state.dart';

class RemotePdfBloc extends Bloc<RemotePdfEvent, RemotePdfState> {
  final GetRemotePdfUseCase _getRemotePdfUseCase;

  RemotePdfBloc(this._getRemotePdfUseCase)
      : super(const RemotePdfLoadingState()) {
    on<GetRemotePdfEvent>(onGetRemotePdfEvent);
  }

  Future<void> onGetRemotePdfEvent(
      GetRemotePdfEvent event, Emitter<RemotePdfState> emit) async {
    final DataState remotePdfDataState =
        await _getRemotePdfUseCase(params: event.url);
    if (remotePdfDataState is DataSuccess && remotePdfDataState.data != null) {
      emit(RemotePdfReadyState(remotePdfDataState.data));
    }

    if (remotePdfDataState is DataFailed) {
      emit(RemotePdfErrorState(remotePdfDataState.error!));
    }
  }
}
