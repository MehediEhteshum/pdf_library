import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_event.dart';

class BookmarkButton extends StatelessWidget {
  final ValueNotifier<dynamic> pdfUrlDataNotifier;
  final PdfEntity pdf;

  const BookmarkButton({
    super.key,
    required this.pdfUrlDataNotifier,
    required this.pdf,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pdfUrlDataNotifier,
        builder: (context, value, child) {
          var pdfUrlData = value;
          bool isLoading = (pdfUrlData == 0) ? true : false;
          bool isPdfSaved = true;
          bool hasError = false;
          if (!isLoading) {
            isPdfSaved = (pdfUrlData == null) ? true : false;
            hasError = (pdfUrlData == 1) ? true : false;
          }
          return isLoading || hasError
              ? const SizedBox()
              : SizedBox(
                  width: kToolbarHeight,
                  height: kToolbarHeight,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () =>
                          _onPressed(context, pdf, isPdfSaved, pdfUrlData),
                      shape: const CircleBorder(),
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.bookmark,
                        color: isPdfSaved ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
        });
  }

  void _onPressed(
      BuildContext context, PdfEntity pdf, bool isPdfSaved, var pdfUrlData) {
    if (isPdfSaved) {
      BlocProvider.of<LocalPdfBloc>(context).add(DeleteLocalPdfEvent(pdf.url!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF deleted successfully.'),
          duration: Duration(milliseconds: 500),
        ),
      );
    } else {
      String pdfName = pdf.url!
          .split('/')
          .last
          .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_')
          .toUpperCase();
      PdfEntity newPdf =
          PdfEntity(url: pdf.url, name: pdfName, data: pdfUrlData);
      BlocProvider.of<LocalPdfBloc>(context).add(SaveLocalPdfEvent(newPdf));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF saved successfully.'),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
    BlocProvider.of<LocalPdfBloc>(context).add(GetLocalPdfEvent(pdf.url!));
  }
}
