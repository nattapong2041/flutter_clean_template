import 'package:json_annotation/json_annotation.dart';

import '../../../../common/base/base_model.dart';
import 'article_model.dart';

part 'news_response_model.g.dart';

@JsonSerializable()
class NewsResponseModel extends BaseResponse {
  NewsResponseModel({
    this.articles,
  });

  @JsonKey(name: 'totalResults')
  int? totalResults;

  @JsonKey(name: 'articles')
  List<ArticleModel>? articles;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NewsResponseModelToJson(this);
}
