import 'package:json_annotation/json_annotation.dart';

enum PrimaryAttr {
  @JsonValue('str')
  strength,
  @JsonValue('agi')
  agility,
  @JsonValue('int')
  intelligence,
}
