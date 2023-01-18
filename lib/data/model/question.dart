import 'package:dota_trivia/data/model/common/option.dart';
import 'package:dota_trivia/data/model/template.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  Question({
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
  final List<Option>? options;
  final Template? template;

  Question copyWith({
    int? id,
    String? question,
    String? contentUrl,
    int? templateId,
    List<Option>? options,
    Template? template,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      contentUrl: contentUrl ?? this.contentUrl,
      templateId: templateId ?? this.templateId,
      options: options ?? this.options,
      template: template ?? this.template,
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
