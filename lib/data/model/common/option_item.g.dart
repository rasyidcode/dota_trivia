// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionItem _$OptionItemFromJson(Map<String, dynamic> json) => OptionItem(
      id: json['id'] as int?,
      questionId: json['question_id'] as int?,
      label: json['label'] as String?,
      content: json['content'] as String?,
      isCorrect: json['is_correct'] as bool?,
      iconUrl: json['icon_url'] as String?,
    );

Map<String, dynamic> _$OptionItemToJson(OptionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'label': instance.label,
      'content': instance.content,
      'is_correct': instance.isCorrect,
      'icon_url': instance.iconUrl,
    };
