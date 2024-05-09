import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class PdfEntity extends Equatable {
  final Uint8List? data;
  final String? url;
  final String? name;
  final String? fileLocation;
  final bool? isSaved;

  const PdfEntity(
      {this.isSaved, this.url, this.name, this.fileLocation, this.data});

  @override
  List<Object?> get props => [data, url, name, fileLocation, isSaved];
}
