import 'package:dota_trivia/constants/templates.dart';
import 'package:dota_trivia/ui/trivia/widgets/options/text_icon_option.dart';
import 'package:dota_trivia/ui/trivia/widgets/options/text_only_option.dart';
import 'package:flutter/material.dart';

class OptionContent extends StatelessWidget {
  const OptionContent({
    super.key,
    required this.templateId,
    required this.content,
  });

  final int templateId;
  final String content;

  @override
  Widget build(BuildContext context) {
    if (templateId == Templates.whatIsTheNameOfThisHero) {
      return TextOnlyOption(content: content);
    } else if (templateId == Templates.whatIsTheBaseMovementSpeedFor) {
      return TextIconOption(
        content: content,
        type: TextIconType.moveSpeed,
      );
    } else if (templateId == Templates.whatIsTheBaseAttackFor) {
      return TextIconOption(
        content: content,
        type: TextIconType.attack,
      );
    } else if (templateId == Templates.whatIsTheBaseArmorFor) {
      return TextIconOption(
        content: content,
        type: TextIconType.armor,
      );
    } else {
      return const SizedBox();
    }
  }
}
