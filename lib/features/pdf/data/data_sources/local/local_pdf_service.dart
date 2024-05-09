import 'package:pdf_library/features/pdf/data/models/pdf_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPdfService {
  static SharedPreferences? _sharedPreferences;
  static Future<SharedPreferences> get _instance async =>
      _sharedPreferences ??= await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _sharedPreferences = await _instance;
    return _sharedPreferences;
  }

  Future<List<PdfModel>> getSavedPdfs() {
    throw UnimplementedError();
  }

  Future<PdfModel> getSavedPdf(String url) {
    throw UnimplementedError();
  }

  Future<void> deletePdf(String url) {
    throw UnimplementedError();
  }

  Future<void> savePdf(PdfModel article) {
    throw UnimplementedError();
  }
}
