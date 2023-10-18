import 'package:json_annotation/json_annotation.dart';

// @JsonEnum(valueField: 'code')
// enum StatusCode {
//   success(200),
//   movedPermanently(301),
//   found(302),
//   badRequest(400),
//   unauthorized(401),
//   notfound(404),
//   internalServerError(500),
//   unknown(0);

//   const StatusCode(this.code);
//   final int code;
// }

enum Status {
  ok,
  error,
}

base class BaseResponse {
  @JsonKey(name: 'status')
  Status status;

  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'message')
  String? message;

  BaseResponse({this.status = Status.error, this.code, this.message});
}
