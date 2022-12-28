import 'package:dota_trivia/data/model/common/option_item.dart';
import 'package:dota_trivia/data/model/template_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_item.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionItem {
  QuestionItem({
    this.id,
    this.question,
    this.imageUrl,
    this.templateId,
    this.options,
    this.templateItem,
  });

  final int? id;
  final String? question;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'template_id')
  final int? templateId;
  final List<OptionItem>? options;
  final TemplateItem? templateItem;

  QuestionItem copyWith({
    int? id,
    String? question,
    String? imageUrl,
    int? templateId,
    List<OptionItem>? options,
    TemplateItem? templateItem,
  }) {
    return QuestionItem(
      id: id ?? this.id,
      question: question ?? this.question,
      imageUrl: imageUrl ?? this.imageUrl,
      templateId: templateId ?? this.templateId,
      options: options ?? this.options,
      templateItem: templateItem ?? this.templateItem,
    );
  }

  factory QuestionItem.fromJson(Map<String, dynamic> json) =>
      _$QuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionItemToJson(this);
}
