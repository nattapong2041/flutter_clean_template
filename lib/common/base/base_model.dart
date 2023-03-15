import 'package:json_annotation/json_annotation.dart';

class BaseRequest {
  BaseRequest({required this.service});

  @JsonKey(includeFromJson: false, includeToJson: false)
  String service;
}

class BaseResponse {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'message')
  String? message;
}
