import 'package:json_annotation/json_annotation.dart';

enum StatusCode {
  @JsonValue('ok')
  success,
  @JsonValue(error)
  error,
} 
base class BaseResponse {
  @JsonKey(name: 'status')
  final StatusCode status;

  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'message')
  String? message;

  BaseResponse({this.status = StatusCode.error, this.code, this.message});
}
