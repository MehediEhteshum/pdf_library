import 'package:flutter/material.dart';
import 'package:pdf_library/core/constants/constants.dart';
import 'package:pdf_library/features/pdf/presentation/pages/home.dart';
import 'package:pdf_library/features/pdf/presentation/pages/pdf_library.dart';
import 'package:pdf_library/features/pdf/presentation/pages/view_pdf.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeRoute:
        return _materialPageRoute(const Home(), routeSettings);
      case viewPdfRoute:
        return _materialPageRoute(const ViewPdf(), routeSettings);
      case pdfLibraryRoute:
        return _materialPageRoute(const PdfLibrary(), routeSettings);
      default:
        return _materialPageRoute(const Home(), routeSettings);
    }
  }

  static Route _materialPageRoute(Widget page, RouteSettings routeSettings) {
    return MaterialPageRoute(
        settings: routeSettings, builder: (context) => page);
  }
}
