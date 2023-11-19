import 'package:json_annotation/json_annotation.dart';

part 'news_request_model.g.dart';

@JsonSerializable()
final class NewsRequestModel {
  NewsRequestModel(
      {required this.search,
      this.country,
      this.category,
      required this.page,
      required this.pageSize});

  @JsonKey(name: 'q', includeIfNull: false)
  String? search;

  @JsonKey(name: 'country', includeIfNull: false)
  String? country;

  @JsonKey(name: 'category', includeIfNull: false)
  String? category;

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
