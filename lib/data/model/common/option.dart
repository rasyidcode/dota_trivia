import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  Option({
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

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
