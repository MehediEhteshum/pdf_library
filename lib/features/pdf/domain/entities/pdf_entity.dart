import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class PdfEntity extends Equatable {
  final Uint8List? data;

  const PdfEntity({this.data});

  @override
  List<Object?> get props => [data];
}
