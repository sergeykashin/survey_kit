// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepContent _$StepContentFromJson(Map<String, dynamic> json) => StepContent(
      type: $enumDecode(_$TypeEnumMap, json['type']),
      content: json['content'] as String,
    );

Map<String, dynamic> _$StepContentToJson(StepContent instance) =>
    <String, dynamic>{
      'type': _$TypeEnumMap[instance.type]!,
      'content': instance.content,
    };

const _$TypeEnumMap = {
  Type.text: 'text',
  Type.html: 'html',
  Type.image: 'image',
  Type.video: 'video',
  Type.youtube: 'youtube',
};
