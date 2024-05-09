import 'dart:convert';
import 'dart:io';

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

  Future<PdfModel> getSavedPdf(String url) async {
    String pdfKey = sha1.convert(utf8.encode(url)).toString();
    var pdfValue = _sharedPreferences.getString(pdfKey);
    if (pdfValue != null) {
      var pdfJson = jsonDecode(pdfValue);
      bool fileExists = await File(pdfJson["fileLocation"].toString()).exists();
      if (fileExists) {
        return PdfModel(
          url: pdfJson["url"].toString(),
          name: pdfJson["name"].toString(),
          fileLocation: pdfJson["fileLocation"].toString(),
          isSaved: pdfJson["isSaved"],
        );
      } else {
        await _sharedPreferences.remove(pdfKey);
        return const PdfModel(isSaved: false);
      }
    }
    return const PdfModel(isSaved: false);
  }

  Future<void> deletePdf(String url) {
    throw UnimplementedError();
  }

  Future<void> savePdf(PdfModel pdf) async {
    // save pdf
  }
}
