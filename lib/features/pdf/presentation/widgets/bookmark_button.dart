import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_event.dart';

class BookmarkButton extends StatelessWidget {
  final PdfEntity pdf;

  const BookmarkButton({
    super.key,
    required this.pdf,
  });

  @override
  Widget build(BuildContext context) {
    bool isPdfSaved = pdf.isSaved!;

    return SizedBox(
      width: kToolbarHeight,
      height: kToolbarHeight,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => _onPressed(context, isPdfSaved),
          shape: const CircleBorder(),
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.bookmark,
            color: isPdfSaved ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context, bool isPdfSaved) {
    if (isPdfSaved) {
      BlocProvider.of<LocalPdfBloc>(context).add(DeleteLocalPdfEvent(pdf.url!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF deleted successfully.'),
          duration: Duration(milliseconds: 500),
        ),
      );
    } else {
      BlocProvider.of<LocalPdfBloc>(context).add(SaveLocalPdfEvent(pdf));
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
