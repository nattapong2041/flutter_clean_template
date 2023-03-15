// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsRequestModel _$NewsRequestModelFromJson(Map<String, dynamic> json) =>
    NewsRequestModel(
      search: json['q'] as String?,
      language: json['language'] as String?,
      sortBy: json['sortBy'] as String?,
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
    );

Map<String, dynamic> _$NewsRequestModelToJson(NewsRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('q', instance.search);
  writeNotNull('language', instance.language);
  writeNotNull('sortBy', instance.sortBy);
  val['page'] = instance.page;
  val['pageSize'] = instance.pageSize;
  return val;
}
