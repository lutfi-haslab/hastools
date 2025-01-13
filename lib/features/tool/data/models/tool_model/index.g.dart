// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ToolImpl _$$ToolImplFromJson(Map<String, dynamic> json) => _$ToolImpl(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      clickCount: (json['clickCount'] as num).toInt(),
      path: json['path'] as String,
    );

Map<String, dynamic> _$$ToolImplToJson(_$ToolImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'clickCount': instance.clickCount,
      'path': instance.path,
    };
