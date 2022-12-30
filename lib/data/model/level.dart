import 'package:json_annotation/json_annotation.dart';

enum Level {
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard
}
