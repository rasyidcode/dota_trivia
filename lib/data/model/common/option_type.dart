import 'package:json_annotation/json_annotation.dart';

enum OptionType {
  @JsonValue('text')
  text,
  @JsonValue('text_icon')
  textIcon,
  @JsonValue('image')
  image,
  @JsonValue('custom_health_mana_bar')
  customHealthManaBar
}
