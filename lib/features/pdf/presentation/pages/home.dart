import 'package:flutter/material.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/pdf_library_button.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/url_input.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Home"),
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: const PdfLibraryButton(),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return const Center(
      child: UrlInput(),
    );
  }
}
