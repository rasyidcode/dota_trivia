// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateItem _$TemplateItemFromJson(Map<String, dynamic> json) => TemplateItem(
      id: json['id'] as int?,
      templateId: json['template_id'] as int?,
      question: json['question'] as String?,
      contentType:
          $enumDecodeNullable(_$ContentTypeEnumMap, json['content_type']),
      optionType: $enumDecodeNullable(_$OptionTypeEnumMap, json['option_type']),
      sourceData: (json['source_data'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      info: json['info'] as String?,
      level: $enumDecodeNullable(_$LevelEnumMap, json['level']),
    );

Map<String, dynamic> _$TemplateItemToJson(TemplateItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'template_id': instance.templateId,
      'question': instance.question,
      'content_type': _$ContentTypeEnumMap[instance.contentType],
      'option_type': _$OptionTypeEnumMap[instance.optionType],
      'source_data': instance.sourceData,
      'info': instance.info,
      'level': _$LevelEnumMap[instance.level],
    };

const _$ContentTypeEnumMap = {
  ContentType.image: 'image',
  ContentType.soundHeroAttack: 'sound_hero_attack',
  ContentType.itemCombinations: 'item_combinations',
  ContentType.heroAttributes: 'hero_attributes',
  ContentType.soundAbility: 'sound_ability',
  ContentType.textLore: 'text_lore',
  ContentType.quasWexExort: 'quas_wex_exort',
};

const _$OptionTypeEnumMap = {
  OptionType.text: 'text',
  OptionType.textIcon: 'text_icon',
  OptionType.image: 'image',
  OptionType.customHealthManaBar: 'custom_health_mana_bar',
};

const _$LevelEnumMap = {
  Level.easy: 'easy',
  Level.medium: 'medium',
  Level.hard: 'hard',
};
