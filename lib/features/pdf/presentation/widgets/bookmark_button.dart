import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_event.dart';

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({
    super.key,
    required this.pdf,
  });

  final PdfEntity pdf;

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool? isSaved;
  bool hasData = true;

  @override
  Widget build(BuildContext context) {
    PdfEntity pdf = widget.pdf;
    isSaved = isSaved ?? pdf.isSaved!;
    return hasData
        ? SizedBox(
            width: kToolbarHeight,
            height: kToolbarHeight,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () => _onPressed(context, pdf),
                shape: const CircleBorder(),
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.bookmark,
                  color: isSaved! ? Colors.black : Colors.white,
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  void _onPressed(BuildContext context, PdfEntity pdf) {
    if (isSaved!) {
      // delete
      BlocProvider.of<LocalPdfBloc>(context).add(DeleteLocalPdfEvent(pdf.url!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF deleted successfully.'),
          duration: Duration(milliseconds: 500),
        ),
      );
    } else {
      // save
      BlocProvider.of<LocalPdfBloc>(context).add(SaveLocalPdfEvent(pdf));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF saved successfully.'),
          duration: Duration(milliseconds: 500),
        ),
      );
    }

    setState(() {
      isSaved = !isSaved!;
      hasData = (pdf.data != null) ? true : false;
    });
  }
}
