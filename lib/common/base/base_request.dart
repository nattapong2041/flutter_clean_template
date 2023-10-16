import 'package:json_annotation/json_annotation.dart';

base class BaseRequest {
  BaseRequest({required this.service});

  @JsonKey(includeFromJson: false, includeToJson: false)
  String service;
}