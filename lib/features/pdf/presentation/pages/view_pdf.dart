import 'package:flutter/material.dart';
import 'package:pdf_library/features/pdf/presentation/widgets/custom_back_button.dart';

class ViewPdf extends StatelessWidget {
  const ViewPdf({super.key});

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

  Widget _buildBody() => Container();
}
