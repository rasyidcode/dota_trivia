import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  Item({
    this.id,
    this.code,
    this.itemId,
    this.img,
    this.dname,
    this.qual,
    this.cost,
    this.notes,
    this.mc,
    this.cd,
    this.lore,
    this.components,
    this.created,
    this.charges,
    this.tier,
  });

  final int? id;
  final String? code;
  @JsonKey(name: 'item_id')
  final int? itemId;
  final String? img;
  final String? dname;
  final String? qual;
  final int? cost;
  final String? notes;
  final int? mc;
  final int? cd;
  final String? lore;
  final List<String>? components;
  final int? created;
  final int? charges;
  final int? tier;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
