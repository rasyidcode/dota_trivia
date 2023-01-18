// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hero _$HeroFromJson(Map<String, dynamic> json) => Hero(
      id: json['id'] as int?,
      heroId: json['hero_id'] as int?,
      name: json['name'] as String?,
      localizedName: json['localized_name'] as String?,
      primaryAttr:
          $enumDecodeNullable(_$PrimaryAttrEnumMap, json['primary_attr']),
      attackType: json['attack_type'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      img: json['img'] as String?,
      icon: json['icon'] as String?,
      baseHealth: json['base_health'] as int?,
      baseHealthRegen: (json['base_health_regen'] as num?)?.toDouble(),
      baseMana: json['base_mana'] as int?,
      baseManaRegen: (json['base_mana_regen'] as num?)?.toDouble(),
      baseArmor: (json['base_armor'] as num?)?.toDouble(),
      baseMr: json['base_mr'] as int?,
      baseAttackMin: json['base_attack_min'] as int?,
      baseAttackMax: json['base_attack_max'] as int?,
      baseStr: json['base_str'] as int?,
      baseAgi: json['base_agi'] as int?,
      baseInt: json['base_int'] as int?,
      strGain: (json['str_gain'] as num?)?.toDouble(),
      agiGain: (json['agi_gain'] as num?)?.toDouble(),
      intGain: (json['int_gain'] as num?)?.toDouble(),
      attackRange: json['attack_range'] as int?,
      projectileSpeed: json['projectile_speed'] as int?,
      attackRate: (json['attack_rate'] as num?)?.toDouble(),
      baseAttackTime: json['base_attack_time'] as int?,
      attackPoint: (json['attack_point'] as num?)?.toDouble(),
      turnRate: (json['turn_rate'] as num?)?.toDouble(),
      cmEnabled: json['cm_enabled'] as int?,
      dayVision: json['day_vision'] as int?,
      nightVision: json['night_vision'] as int?,
      abilities: (json['abilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      moveSpeed: json['move_speed'] as int?,
      legs: json['legs'] as int?,
    );

Map<String, dynamic> _$HeroToJson(Hero instance) => <String, dynamic>{
      'id': instance.id,
      'hero_id': instance.heroId,
      'name': instance.name,
      'localized_name': instance.localizedName,
      'primary_attr': _$PrimaryAttrEnumMap[instance.primaryAttr],
      'attack_type': instance.attackType,
      'roles': instance.roles,
      'img': instance.img,
      'icon': instance.icon,
      'base_health': instance.baseHealth,
      'base_health_regen': instance.baseHealthRegen,
      'base_mana': instance.baseMana,
      'base_mana_regen': instance.baseManaRegen,
      'base_armor': instance.baseArmor,
      'base_mr': instance.baseMr,
      'base_attack_min': instance.baseAttackMin,
      'base_attack_max': instance.baseAttackMax,
      'base_str': instance.baseStr,
      'base_agi': instance.baseAgi,
      'base_int': instance.baseInt,
      'str_gain': instance.strGain,
      'agi_gain': instance.agiGain,
      'int_gain': instance.intGain,
      'attack_range': instance.attackRange,
      'projectile_speed': instance.projectileSpeed,
      'attack_rate': instance.attackRate,
      'base_attack_time': instance.baseAttackTime,
      'attack_point': instance.attackPoint,
      'move_speed': instance.moveSpeed,
      'turn_rate': instance.turnRate,
      'cm_enabled': instance.cmEnabled,
      'legs': instance.legs,
      'day_vision': instance.dayVision,
      'night_vision': instance.nightVision,
      'abilities': instance.abilities,
    };

const _$PrimaryAttrEnumMap = {
  PrimaryAttr.strength: 'str',
  PrimaryAttr.agility: 'agi',
  PrimaryAttr.intelligence: 'int',
};
