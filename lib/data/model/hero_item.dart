import 'package:dota_trivia/constants/hero_stats.dart';
import 'package:dota_trivia/data/model/common/primary_attr.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hero_item.g.dart';

@JsonSerializable()
class HeroItem {
  HeroItem({
    this.id,
    this.heroId,
    this.name,
    this.localizedName,
    this.primaryAttr,
    this.attackType,
    this.roles,
    this.img,
    this.icon,
    this.baseHealth,
    this.baseHealthRegen,
    this.baseMana,
    this.baseManaRegen,
    this.baseArmor,
    this.baseMr,
    this.baseAttackMin,
    this.baseAttackMax,
    this.baseStr,
    this.baseAgi,
    this.baseInt,
    this.strGain,
    this.agiGain,
    this.intGain,
    this.attackRange,
    this.projectileSpeed,
    this.attackRate,
    this.baseAttackTime,
    this.attackPoint,
    this.turnRate,
    this.cmEnabled,
    this.dayVision,
    this.nightVision,
    this.abilities,
    this.moveSpeed,
    this.legs,
  });

  final int? id;
  @JsonKey(name: 'hero_id')
  final int? heroId;
  final String? name;
  @JsonKey(name: 'localized_name')
  final String? localizedName;
  @JsonKey(name: 'primary_attr')
  final PrimaryAttr? primaryAttr;
  @JsonKey(name: 'attack_type')
  final String? attackType;
  final List<String>? roles;
  final String? img;
  final String? icon;
  @JsonKey(name: 'base_health')
  final int? baseHealth;
  @JsonKey(name: 'base_health_regen')
  final double? baseHealthRegen;
  @JsonKey(name: 'base_mana')
  final int? baseMana;
  @JsonKey(name: 'base_mana_regen')
  final double? baseManaRegen;
  @JsonKey(name: 'base_armor')
  final double? baseArmor;
  @JsonKey(name: 'base_mr')
  final int? baseMr;
  @JsonKey(name: 'base_attack_min')
  final int? baseAttackMin;
  @JsonKey(name: 'base_attack_max')
  final int? baseAttackMax;
  @JsonKey(name: 'base_str')
  final int? baseStr;
  @JsonKey(name: 'base_agi')
  final int? baseAgi;
  @JsonKey(name: 'base_int')
  final int? baseInt;
  @JsonKey(name: 'str_gain')
  final double? strGain;
  @JsonKey(name: 'agi_gain')
  final double? agiGain;
  @JsonKey(name: 'int_gain')
  final double? intGain;
  @JsonKey(name: 'attack_range')
  final int? attackRange;
  @JsonKey(name: 'projectile_speed')
  final int? projectileSpeed;
  @JsonKey(name: 'attack_rate')
  final double? attackRate;
  @JsonKey(name: 'base_attack_time')
  final int? baseAttackTime;
  @JsonKey(name: 'attack_point')
  final double? attackPoint;
  @JsonKey(name: 'move_speed')
  final int? moveSpeed;
  @JsonKey(name: 'turn_rate')
  final double? turnRate;
  @JsonKey(name: 'cm_enabled')
  final int? cmEnabled;
  final int? legs;
  @JsonKey(name: 'day_vision')
  final int? dayVision;
  @JsonKey(name: 'night_vision')
  final int? nightVision;
  final List<String>? abilities;

  factory HeroItem.fromJson(Map<String, dynamic> json) =>
      _$HeroItemFromJson(json);

  Map<String, dynamic> toJson() => _$HeroItemToJson(this);

  int getMinAttack() {
    int? primaryAttrValue;

    if (primaryAttr == PrimaryAttr.strength) {
      primaryAttrValue = baseStr;
    } else if (primaryAttr == PrimaryAttr.agility) {
      primaryAttrValue = baseAgi;
    } else if (primaryAttr == PrimaryAttr.intelligence) {
      primaryAttrValue = baseInt;
    }
    return (baseAttackMin ?? 0) +
        (HeroStats.attackDamage * (primaryAttrValue ?? 0));
  }

  int getMaxAttack() {
    int? primaryAttrValue;

    if (primaryAttr == PrimaryAttr.strength) {
      primaryAttrValue = baseStr;
    } else if (primaryAttr == PrimaryAttr.agility) {
      primaryAttrValue = baseAgi;
    } else if (primaryAttr == PrimaryAttr.intelligence) {
      primaryAttrValue = baseInt;
    }
    return (baseAttackMax ?? 0) +
        (HeroStats.attackDamage * (primaryAttrValue ?? 0));
  }

  String getArmor() {
    return ((baseArmor ?? 0) + (HeroStats.armor * (baseAgi ?? 0)))
        .toStringAsFixed(1);
  }
}
