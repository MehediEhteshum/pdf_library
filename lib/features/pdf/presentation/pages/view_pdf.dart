import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/dependency_container.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_event.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_state.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/custom_back_button.dart';
import 'package:pdfx/pdfx.dart';

class ViewPdf extends StatelessWidget {
  const ViewPdf({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemotePdfBloc>(
      create: (context) => sl<RemotePdfBloc>()
        ..add(const GetRemotePdfEvent("https://www.pdf995.com/samples/pd.pdf")),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("PDF Viewer"),
      leading: const CustomBackButton(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemotePdfBloc, RemotePdfState>(
      builder: (context, state) {
        if (state is RemotePdfLoadingState) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: kToolbarHeight,
            ),
          );
        }

        if (state is RemotePdfErrorState) {
          return const Center(
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  size: kToolbarHeight,
                  color: Colors.red,
                ),
                Text("Something went wrong :("),
              ],
            ),
          );
        }

        if (state is RemotePdfReadyState) {
          PdfController pdfController =
              PdfController(document: PdfDocument.openData(state.pdf!.data!));
          return PdfView(
            controller: pdfController,
            scrollDirection: Axis.vertical,
          );
        }

        return const SizedBox();
      },
    );
  }
}
