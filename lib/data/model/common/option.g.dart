// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      id: json['id'] as int?,
      questionId: json['question_id'] as int?,
      label: json['label'] as String?,
      content: json['content'] as String?,
      isCorrect: json['is_correct'] as bool?,
      iconUrl: json['icon_url'] as String?,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'label': instance.label,
      'content': instance.content,
      'is_correct': instance.isCorrect,
      'icon_url': instance.iconUrl,
    };
