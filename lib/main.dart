import 'package:flutter/material.dart';
import 'package:pdf_library/config/routes/routes.dart';
import 'package:pdf_library/config/themes/themes.dart';
import 'package:pdf_library/features/pdf/presentation/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const Home(),
    );
  }
}
