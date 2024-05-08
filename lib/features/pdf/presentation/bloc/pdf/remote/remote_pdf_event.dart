import 'package:equatable/equatable.dart';

abstract class RemotePdfEvent extends Equatable {
  final String? url;

  const RemotePdfEvent({this.url});

  @override
  List<Object?> get props => [url];
}

class GetRemotePdfEvent extends RemotePdfEvent {
  const GetRemotePdfEvent(String url) : super(url: url);
}
