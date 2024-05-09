import 'package:flutter/material.dart';
import 'package:pdf_library/core/constants/constants.dart';
import 'package:pdf_library/features/pdf/domain/entities/pdf_entity.dart';

class UrlInput extends StatefulWidget {
  const UrlInput({super.key});

  @override
  State<UrlInput> createState() => _UrlInputState();
}

class _UrlInputState extends State<UrlInput> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin:
              EdgeInsets.fromLTRB(screenWidth * 0.25, 0, screenWidth * 0.25, 0),
          child: TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter a PDF URL',
            ),
            onFieldSubmitted: (_) => _navigate(context),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        OutlinedButton(
          onPressed: () => _navigate(context),
          child: const Text(
            "VIEW",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  void _navigate(BuildContext context) {
    Navigator.pushNamed(
      context,
      viewPdfRoute,
      arguments: PdfEntity(url: textEditingController.text),
    );
    textEditingController.text = "";
  }
}
