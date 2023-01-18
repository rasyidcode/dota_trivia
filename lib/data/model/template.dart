import 'package:dota_trivia/data/model/common/content_type.dart';
import 'package:dota_trivia/data/model/common/option_type.dart';
import 'package:dota_trivia/data/model/level.dart';
import 'package:json_annotation/json_annotation.dart';

part 'template.g.dart';

@JsonSerializable()
class Template {
  Template({
    this.id,
    this.templateId,
    this.question,
    this.contentType,
    this.optionType,
    this.sourceData,
    this.info,
    this.level,
  });

  final int? id;
  @JsonKey(name: 'template_id')
  final int? templateId;
  final String? question;
  @JsonKey(name: 'content_type')
  final ContentType? contentType;
  @JsonKey(name: 'option_type')
  final OptionType? optionType;
  @JsonKey(name: 'source_data')
  final List<String>? sourceData;
  final String? info;
  final Level? level;

  factory Template.fromJson(Map<String, dynamic> json) =>
      _$TemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateToJson(this);
}
