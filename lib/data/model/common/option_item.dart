import 'package:json_annotation/json_annotation.dart';

part 'option_item.g.dart';

@JsonSerializable()
class OptionItem {
  OptionItem({
    required this.id,
    required this.questionId,
    required this.label,
    required this.content,
    required this.isCorrect,
    required this.iconUrl,
  });

  final int? id;
  @JsonKey(name: 'question_id')
  final int? questionId;
  final String? label;
  final String? content;
  @JsonKey(name: 'is_correct')
  final bool? isCorrect;
  @JsonKey(name: 'icon_url')
  final String? iconUrl;

  factory OptionItem.fromJson(Map<String, dynamic> json) =>
      _$OptionItemFromJson(json);

  Map<String, dynamic> toJson() => _$OptionItemToJson(this);
}
