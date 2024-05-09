import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class PdfEntity extends Equatable {
  final Uint8List? data;
  final String? url;
  final String? name;
  final String? fileLocation;

  const PdfEntity({this.url, this.name, this.fileLocation, this.data});

  @override
  List<Object?> get props => [data, url, name, fileLocation];
}
