// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as int?,
      code: json['code'] as String?,
      itemId: json['item_id'] as int?,
      img: json['img'] as String?,
      dname: json['dname'] as String?,
      qual: json['qual'] as String?,
      cost: json['cost'] as int?,
      notes: json['notes'] as String?,
      mc: json['mc'] as int?,
      cd: json['cd'] as int?,
      lore: json['lore'] as String?,
      components: (json['components'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      created: json['created'] as int?,
      charges: json['charges'] as int?,
      tier: json['tier'] as int?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'item_id': instance.itemId,
      'img': instance.img,
      'dname': instance.dname,
      'qual': instance.qual,
      'cost': instance.cost,
      'notes': instance.notes,
      'mc': instance.mc,
      'cd': instance.cd,
      'lore': instance.lore,
      'components': instance.components,
      'created': instance.created,
      'charges': instance.charges,
      'tier': instance.tier,
    };
