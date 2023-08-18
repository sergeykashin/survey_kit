// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepContent _$StepContentFromJson(Map<String, dynamic> json) => StepContent(
      type: $enumDecode(_$TypeEnumMap, json['type']),
      content: json['content'] as String,
      textAlign: $enumDecodeNullable(_$TextAlignEnumMap, json['textAlign']) ??
          TextAlign.center,
    );

Map<String, dynamic> _$StepContentToJson(StepContent instance) =>
    <String, dynamic>{
      'type': _$TypeEnumMap[instance.type]!,
      'content': instance.content,
      'textAlign': _$TextAlignEnumMap[instance.textAlign]!,
    };

const _$TypeEnumMap = {
  Type.text: 'text',
  Type.html: 'html',
  Type.image: 'image',
  Type.video: 'video',
  Type.youtube: 'youtube',
};

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};
