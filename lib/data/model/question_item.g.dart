// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionItem _$QuestionItemFromJson(Map<String, dynamic> json) => QuestionItem(
      id: json['id'] as int?,
      question: json['question'] as String?,
      contentUrl: json['content_url'] as String?,
      templateId: json['template_id'] as int?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      template: json['template'] == null
          ? null
          : TemplateItem.fromJson(json['template'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionItemToJson(QuestionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'content_url': instance.contentUrl,
      'template_id': instance.templateId,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'template': instance.template?.toJson(),
    };
