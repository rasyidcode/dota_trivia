import 'package:dota_trivia/data/model/common/option_item.dart';
import 'package:dota_trivia/data/model/template_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_item.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionItem {
  QuestionItem({
    this.id,
    this.question,
    this.contentUrl,
    this.templateId,
    this.options,
    this.template,
  });

  final int? id;
  final String? question;
  @JsonKey(name: 'content_url')
  final String? contentUrl;
  @JsonKey(name: 'template_id')
  final int? templateId;
  final List<OptionItem>? options;
  final TemplateItem? template;

  QuestionItem copyWith({
    int? id,
    String? question,
    String? contentUrl,
    int? templateId,
    List<OptionItem>? options,
    TemplateItem? template,
  }) {
    return QuestionItem(
      id: id ?? this.id,
      question: question ?? this.question,
      contentUrl: contentUrl ?? this.contentUrl,
      templateId: templateId ?? this.templateId,
      options: options ?? this.options,
      template: template ?? this.template,
    );
  }

  factory QuestionItem.fromJson(Map<String, dynamic> json) =>
      _$QuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionItemToJson(this);
}
