import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/dependency_container.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_event.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_state.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/custom_back_button.dart';
import 'package:pdfx/pdfx.dart';

class ViewPdf extends StatefulWidget {
  const ViewPdf({super.key, this.pdfUrl, this.pdf});

  final String? pdfUrl;
  final PdfEntity? pdf;

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  bool hasDocumentError = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemotePdfBloc>(
      create: (context) =>
          sl<RemotePdfBloc>()..add(GetRemotePdfEvent(widget.pdfUrl!)),
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
    var pdf = widget.pdf;
    if (pdf != null) {
      PdfController pdfController =
          PdfController(document: PdfDocument.openFile(pdf.fileLocation!));
      return PdfView(
        controller: pdfController,
        scrollDirection: Axis.vertical,
        onDocumentError: (_) {
          setState(() {
            hasDocumentError = true;
          });
        },
      );
    } else {
      return BlocBuilder<RemotePdfBloc, RemotePdfState>(
        builder: (context, state) {
          if (state is RemotePdfLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: kToolbarHeight,
              ),
            );
          }

          if (state is RemotePdfErrorState || hasDocumentError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
              onDocumentError: (_) {
                setState(() {
                  hasDocumentError = true;
                });
              },
            );
          }

          return const SizedBox();
        },
      );
    }
  }
}
