import 'package:flutter_clean_template/common/config/config.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../common/base/base_model.dart';

part 'news_request_model.g.dart';

@JsonSerializable()
class NewsRequestModel extends BaseRequest {
  NewsRequestModel(
      {required this.search,
      this.language,
      this.sortBy,
      required this.page,
      required this.pageSize})
      : super(service: "NewsRequestModel");

  @JsonKey(name: 'q', includeIfNull: false)
  String? search;

  @JsonKey(name: 'language', includeIfNull: false)
  String? language;

  @JsonKey(name: 'sortBy', includeIfNull: false)
  String? sortBy;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'pageSize')
  int pageSize;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory NewsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$NewsRequestModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NewsRequestModelToJson(this);
}
