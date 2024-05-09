import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf_library/features/pdf/data/data_sources/local/local_pdf_service.dart';
import 'package:pdf_library/features/pdf/data/data_sources/remote/pdf_url_service.dart';
import 'package:pdf_library/features/pdf/data/repositories/pdf_repo_impl.dart';
import 'package:pdf_library/features/pdf/domain/repositories/pdf_repo.dart';
import 'package:pdf_library/features/pdf/domain/usecases/delete_saved_pdf.dart';
import 'package:pdf_library/features/pdf/domain/usecases/get_remote_pdf.dart';
import 'package:pdf_library/features/pdf/domain/usecases/get_saved_pdf.dart';
import 'package:pdf_library/features/pdf/domain/usecases/get_saved_pdflist.dart';
import 'package:pdf_library/features/pdf/domain/usecases/save_pdf.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/local/local_pdf_bloc.dart';
import 'package:pdf_library/features/pdf/presentation/bloc/pdf/remote/remote_pdf_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// service locator global instance
final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await sharedPreferences.setStringList('pdf_key_list', <String>[]);
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Test
  var url1 = sha1.convert(utf8.encode("url1")).toString();
  var url2 = sha1.convert(utf8.encode("url2")).toString();
  await sharedPreferences.setStringList('pdf_key_list', <String>[url1, url2]);
  var x = {
    "url": "url1",
    "name": "s1",
    "fileLocation": "C:/Users/Oshan/Downloads/Documents/s1.pdf",
    "isSaved": true
  };
  var y = {
    "url": "url2",
    "name": "s2",
    "fileLocation": "C:/Users/Oshan/Downloads/Documents/s2.pdf",
    "isSaved": true
  };
  await sharedPreferences.setString(url1, jsonEncode(x));
  await sharedPreferences.setString(url2, jsonEncode(y));

  // Test

  sl.registerSingleton<PdfUrlService>(PdfUrlService());
  sl.registerSingleton<LocalPdfService>(LocalPdfService(sl()));
  sl.registerSingleton<PdfRepo>(PdfRepoImpl(sl(), sl()));

  // usecases
  sl.registerSingleton<GetRemotePdfUseCase>(GetRemotePdfUseCase(sl()));
  sl.registerSingleton<GetSavedPdfListUseCase>(GetSavedPdfListUseCase(sl()));
  sl.registerSingleton<GetSavedPdfUseCase>(GetSavedPdfUseCase(sl()));
  sl.registerSingleton<SavePdfUseCase>(SavePdfUseCase(sl()));
  sl.registerSingleton<DeleteSavedPdfUseCase>(DeleteSavedPdfUseCase(sl()));

  // blocs
  sl.registerFactory<RemotePdfBloc>(() => RemotePdfBloc(sl()));
  sl.registerFactory<LocalPdfBloc>(() => LocalPdfBloc(sl(), sl(), sl(), sl()));
}
