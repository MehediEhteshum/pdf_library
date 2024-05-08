import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/custom_back_button.dart';
import 'package:pdfx/pdfx.dart';

class ViewPdf extends StatefulWidget {
  const ViewPdf({super.key});

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  late PdfController pdfController;
  @override
  void initState() {
    pdfController = PdfController(
      document: PdfDocument.openData(InternetFile.get(
          'https://ia601608.us.archive.org/14/items/pdfy-vJFcaYG7Xau9y5ZZ/01_The_Lightning_Thief.pdf')),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("PDF Viewer"),
      leading: const CustomBackButton(),
    );
  }

  Widget _buildBody() {
    return PdfView(
      controller: pdfController,
    );
  }
}
