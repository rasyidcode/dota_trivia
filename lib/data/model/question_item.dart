import 'package:dota_trivia/data/model/common/option_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_item.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionItem {
  QuestionItem({
    this.id,
    this.question,
    this.imageUrl,
    this.templateId,
  });

  final int? id;
  final String? question;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'template_id')
  final int? templateId;
  List<OptionItem>? options;

  factory QuestionItem.fromJson(Map<String, dynamic> json) =>
      _$QuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionItemToJson(this);
}
