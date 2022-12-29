import 'package:dota_trivia/data/model/common/content_type.dart';
import 'package:dota_trivia/data/model/common/option_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'template_item.g.dart';

@JsonSerializable()
class TemplateItem {
  TemplateItem({
    this.id,
    this.templateId,
    this.question,
    this.contentType,
    this.optionType,
    this.sourceData,
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

  factory TemplateItem.fromJson(Map<String, dynamic> json) =>
      _$TemplateItemFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateItemToJson(this);
}
