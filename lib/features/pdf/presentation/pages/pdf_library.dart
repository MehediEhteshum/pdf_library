import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_library/dependency_container.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_event.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_state.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/custom_back_button.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/pdf_tile.dart';

class PdfLibrary extends StatelessWidget {
  const PdfLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalPdfBloc>(
      create: (context) =>
          sl<LocalPdfBloc>()..add(const GetLocalPdfListEvent()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("My Library"),
      leading: const CustomBackButton(),
    );
  }

  Widget _buildBody() => BlocBuilder<LocalPdfBloc, LocalPdfState>(
        builder: (context, state) {
          if (state is LocalPdfListLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: kToolbarHeight,
              ),
            );
          }

          if (state is LocalPdfListReadyState) {
            if (state.pdfList!.isEmpty) {
              return const Center(
                child: Text(
                  "No Saved Pdfs",
                  style: TextStyle(
                    fontSize: kToolbarHeight * 0.3,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.pdfList!.length,
                itemBuilder: (context, index) {
                  final PdfEntity pdf = state.pdfList![index];
                  return PdfTile(pdf: pdf);
                },
              );
            }
          }

          return const SizedBox();
        },
      );
}
