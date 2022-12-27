import 'package:json_annotation/json_annotation.dart';

enum ContentType {
  @JsonValue('image')
  image,
  @JsonValue('sound_hero_attack')
  soundHeroAttack,
  @JsonValue('item_combinations')
  itemCombinations,
  @JsonValue('hero_attributes')
  heroAttributes,
  @JsonValue('sound_ability')
  soundAbility,
  @JsonValue('text_lore')
  textLore,
  @JsonValue('quas_wex_exort')
  quasWexExort
}
