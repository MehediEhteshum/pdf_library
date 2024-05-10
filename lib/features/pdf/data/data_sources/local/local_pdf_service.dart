import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_library/features/pdf/data/models/pdf_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPdfService {
  final SharedPreferences _sharedPreferences;

  LocalPdfService(this._sharedPreferences);

  List<PdfModel> getSavedPdfList() {
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

        List<String>? pdfKeyList =
            _sharedPreferences.getStringList('pdf_key_list');
        pdfKeyList?.removeWhere((item) => (item == pdfKey));
        await _sharedPreferences
            .setStringList('pdf_key_list', [...?pdfKeyList]);

        return PdfModel(url: url, isSaved: false);
      }
    }
    return PdfModel(url: url, isSaved: false);
  }

  Future<void> deleteSavedPdf(String url) async {
    String pdfKey = sha1.convert(utf8.encode(url)).toString();
    var pdfValue = _sharedPreferences.getString(pdfKey);
    if (pdfValue != null) {
      var pdfJson = jsonDecode(pdfValue);
      bool fileExists = await File(pdfJson["fileLocation"].toString()).exists();
      if (fileExists) {
        // delete the file
        await File(pdfJson["fileLocation"].toString()).delete();
      }
    }
    await _sharedPreferences.remove(pdfKey);

    List<String>? pdfKeyList = _sharedPreferences.getStringList('pdf_key_list');
    pdfKeyList?.removeWhere((item) => (item == pdfKey));
    await _sharedPreferences.setStringList('pdf_key_list', [...?pdfKeyList]);
  }

  Future<void> savePdf(PdfModel pdf) async {
    // write data to file
    final docDirectory = await getApplicationDocumentsDirectory();
    final appDocDirectory =
        await Directory(path.join(docDirectory.path, 'PDF Library'))
            .create(recursive: true);
    File file = File(path.join(appDocDirectory.path, '${pdf.name}.pdf'));
    file = await file.writeAsBytes(pdf.data!);

    // update _sharedPreferences
    String pdfKey = sha1.convert(utf8.encode(pdf.url!)).toString();
    var pdfJson = {
      "url": pdf.url!,
      "name": pdf.name!,
      "fileLocation": file.path,
      "isSaved": true
    };
    String pdfValue = jsonEncode(pdfJson);
    await _sharedPreferences.setString(pdfKey, pdfValue);

    await _sharedPreferences.setStringList('pdf_key_list',
        [...?_sharedPreferences.getStringList('pdf_key_list'), pdfKey]);
  }
}
