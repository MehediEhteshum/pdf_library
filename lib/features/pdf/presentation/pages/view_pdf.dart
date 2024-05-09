import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/dependency_container.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_event.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_state.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_event.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_state.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/custom_back_button.dart';
import 'package:pdfx/pdfx.dart';

class ViewPdf extends StatefulWidget {
  const ViewPdf({super.key, required this.pdf});

  final PdfEntity pdf;

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  bool hasDocumentError = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalPdfBloc>(
      create: (context) =>
          sl<LocalPdfBloc>()..add(GetLocalPdfEvent(widget.pdf.url!)),
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
    return BlocBuilder<LocalPdfBloc, LocalPdfState>(
      builder: (context, state) {
        if (state is LocalPdfLoadingState) {
          return _buildLoadingIndicator();
        }

        if (state is LocalPdfReadyState) {
          PdfEntity statePdf = state.pdf!;
          if (statePdf.isSaved!) {
            // open local pdf
            if (hasDocumentError) {
              return _buildErrorWidget();
            }

            PdfController pdfController = PdfController(
                document: PdfDocument.openFile(statePdf.fileLocation!));
            return _buildPdfView(pdfController);
          } else {
            // open remote pdf
            return BlocProvider<RemotePdfBloc>(
              create: (context) =>
                  sl<RemotePdfBloc>()..add(GetRemotePdfEvent(statePdf.url!)),
              child: BlocBuilder<RemotePdfBloc, RemotePdfState>(
                builder: (context, state) {
                  if (state is RemotePdfLoadingState) {
                    return _buildLoadingIndicator();
                  }

                  if (state is RemotePdfErrorState || hasDocumentError) {
                    return _buildErrorWidget();
                  }

                  if (state is RemotePdfReadyState) {
                    PdfController pdfController = PdfController(
                        document: PdfDocument.openData(state.pdf!.data!));
                    return _buildPdfView(pdfController);
                  }

                  return const SizedBox();
                },
              ),
            );
          }
        }

        return const SizedBox();
      },
    );
  }

  Center _buildLoadingIndicator() {
    return const Center(
      child: CupertinoActivityIndicator(
        radius: kToolbarHeight,
      ),
    );
  }

  PdfView _buildPdfView(PdfController pdfController) {
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

  Center _buildErrorWidget() {
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
}
