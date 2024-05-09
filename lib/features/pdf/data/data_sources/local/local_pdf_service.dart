import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:pdf_library/features/pdf/data/models/pdf_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPdfService {
  final SharedPreferences _sharedPreferences;

  LocalPdfService(this._sharedPreferences);

  List<PdfModel> getSavedPdfs() {
    List<String>? pdfKeyList = _sharedPreferences.getStringList('pdf_key_list');
    if (pdfKeyList!.isNotEmpty) {
      List<PdfModel> pdfList = pdfKeyList.map<PdfModel>((pdfKey) {
        var pdfJson = jsonDecode(_sharedPreferences.getString(pdfKey)!);
        PdfModel pdf = PdfModel(
          url: pdfJson["url"].toString(),
          name: pdfJson["name"].toString(),
          fileLocation: pdfJson["fileLocation"].toString(),
        );
        return pdf;
      }).toList();
      return pdfList;
    }
    return [];
  }

  PdfModel getSavedPdf(String url) {
    String pdfKey = sha1.convert(utf8.encode(url)).toString();
    var pdfJson = jsonDecode(_sharedPreferences.getString(pdfKey)!);
    PdfModel pdf = PdfModel(
      url: pdfJson["url"].toString(),
      name: pdfJson["name"].toString(),
      fileLocation: pdfJson["fileLocation"].toString(),
    );
    return pdf;
  }

  Future<void> deletePdf(String url) {
    throw UnimplementedError();
  }

  Future<void> savePdf(PdfModel article) {
    throw UnimplementedError();
  }
}
