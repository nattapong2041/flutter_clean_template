import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/news.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  ArticleModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @JsonKey(name: 'author')
  String? author;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'urlToImage')
  String? urlToImage;

  @JsonKey(name: 'publishedAt')
  DateTime? publishedAt;

  @JsonKey(name: 'content')
  String? content;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  //convert this model to domain entity
  News toEntity() {
    return News(
      author ?? "",
      title ?? "",
      description ?? "",
      url,
      urlToImage,
      publishedAt,
      content ?? "",
    );
  }
}
