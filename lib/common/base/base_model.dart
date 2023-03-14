import 'package:json_annotation/json_annotation.dart';

class BaseRequest {
  BaseRequest({required this.service});

  @JsonKey(includeFromJson: false, includeToJson: false)
  String service;
}

class BaseResponse {
  @JsonKey(name: 'result')
  int? result;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'token')
  bool? token;

  @JsonKey(name: 'loginProvider')
  int? loginProvider;
}
