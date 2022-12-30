import 'package:dota_trivia/constants/templates.dart';

extension TemplateParsing on int {
  bool isWhatIsTheNameOfThisHero() {
    return this == Templates.whatIsTheNameOfThisHero;
  }
}
