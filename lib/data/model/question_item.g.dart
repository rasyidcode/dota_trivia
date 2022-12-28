// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionItem _$QuestionItemFromJson(Map<String, dynamic> json) => QuestionItem(
      id: json['id'] as int?,
      question: json['question'] as String?,
      imageUrl: json['image_url'] as String?,
      templateId: json['template_id'] as int?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      templateItem: json['templateItem'] == null
          ? null
          : TemplateItem.fromJson(json['templateItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionItemToJson(QuestionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'image_url': instance.imageUrl,
      'template_id': instance.templateId,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'templateItem': instance.templateItem?.toJson(),
    };
