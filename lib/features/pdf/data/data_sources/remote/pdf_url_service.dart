import 'dart:typed_data';

import 'package:internet_file/internet_file.dart';
import 'package:pdf_library/features/pdf/data/models/pdf_model.dart';

class PdfUrlService {
  Future<PdfModel> getRemotePdf(String url) async {
    Uint8List data = await InternetFile.get(url);
    return PdfModel(data: data);
  }
}
