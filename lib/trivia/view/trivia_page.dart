import 'dart:ui';

import 'package:dota_trivia/constants/apis.dart';
import 'package:dota_trivia/constants/colors.dart';
import 'package:dota_trivia/constants/templates.dart';
import 'package:dota_trivia/data/model/common/option_item.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/trivia/bloc/trivia_bloc.dart';
import 'package:dota_trivia/ui/trivia/widgets/question_area.dart';
import 'package:dota_trivia/ui/trivia/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaPage extends StatelessWidget {
  const TriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TriviaBloc(
          triviaRepository: RepositoryProvider.of<TriviaRepository>(context)),
      child: const TriviaView(),
    );
  }
}

class TriviaView extends StatelessWidget {
  const TriviaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: const [
                TopBar(),
                QuestionArea(),
                SizedBox(height: 8.0),
                OptionsArea(),
                SizedBox(height: 8.0),
                TimerArea(),
              ],
            ),
          ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          //   child: const Opacity(
          //     opacity: 0.8,
          //     child: ModalBarrier(
          //       dismissible: false,
          //       color: kBackgroundColor,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //           fixedSize: const Size(150, 0),
          //           shape: const RoundedRectangleBorder(
          //             borderRadius: BorderRadius.zero,
          //           ),
          //         ),
          //         child: Text(
          //           'START',
          //           style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //                 letterSpacing: 2.0,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //         ),
          //       ),
          //       const SizedBox(height: 20),
          //       ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //           fixedSize: const Size(150, 0),
          //           shape: const RoundedRectangleBorder(
          //             borderRadius: BorderRadius.zero,
          //           ),
          //         ),
          //         child: Text(
          //           'EXIT',
          //           style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //                 letterSpacing: 2.0,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.black.withRed(75),
            Colors.black.withRed(100),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Text(
            'DOTA TRIVIA',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                'POINTS:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
              ),
              const SizedBox(width: 4.0),
              Text(
                '1000',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class QuestionArea extends StatelessWidget {
  const QuestionArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            color: Colors.white12,
            height: 14.0,
            width: double.infinity,
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 80.0,
            width: 150.0,
            decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.white12, Colors.white12]),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsArea extends StatelessWidget {
  const OptionsArea({super.key});

  LinearGradient _activeOptionGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blueGrey.withOpacity(0.7),
        Colors.blueGrey.withOpacity(0.7),
      ],
    );
  }

  LinearGradient _selectedOptionGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withRed(25),
        Colors.black.withRed(75),
      ],
    );
  }

  LinearGradient _incorrectOptionGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withRed(25),
        Colors.black.withRed(75),
        Colors.black.withRed(125),
      ],
    );
  }

  LinearGradient _correctOptionGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withRed(25),
        Colors.black.withRed(100),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: <OptionItem>[].map((opt) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white54.withOpacity(0.3),
              width: 1.3,
            ),
            gradient: _activeOptionGradient(),
          ),
          width: MediaQuery.of(context).size.width / 2 - (8 * 2 - 4),
          height: 80.0,
          padding: const EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }
}

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

enum TextIconType { moveSpeed, attack, armor }

class TextIconOption extends StatelessWidget {
  const TextIconOption({super.key, this.content, this.type});

  final String? content;
  final TextIconType? type;

  @override
  Widget build(BuildContext context) {
    String? iconUrl;

    if (type == TextIconType.moveSpeed) {
      iconUrl =
          '${Apis.steamAssetURL}/apps/dota2/images/dota_react/heroes/stats/icon_movement_speed.png';
    } else if (type == TextIconType.attack) {
      iconUrl =
          '${Apis.steamAssetURL}/apps/dota2/images/dota_react/heroes/stats/icon_damage.png';
    } else if (type == TextIconType.armor) {
      iconUrl =
          '${Apis.steamAssetURL}/apps/dota2/images/dota_react/heroes/stats/icon_armor.png';
    }
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconUrl == null
              ? Container(
                  color: Colors.white,
                  height: 22.5,
                  width: 22.5,
                )
              : Image.network(
                  iconUrl,
                  width: 22.5,
                  height: 22.5,
                ),
          const SizedBox(width: 8.0),
          Text(
            content ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

class TextOnlyOption extends StatelessWidget {
  const TextOnlyOption({super.key, this.content});

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content != null ? content! : '',
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class TimerArea extends StatelessWidget {
  const TimerArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: const [
            Spacer(),
            CircularProgressIndicator(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class NoAnswerSubmitted extends StatelessWidget {
  const NoAnswerSubmitted({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'NO ANSWER SUBMITTED',
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: Colors.white60),
    );
  }
}

class TimerTicking extends StatelessWidget {
  const TimerTicking({super.key, required this.seconds});

  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '00:${seconds.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.deepOrangeAccent,
              ),
        ),
        Text(
          'TIME REMAINING',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
