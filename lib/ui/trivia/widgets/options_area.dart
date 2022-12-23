import 'package:dota_trivia/data/model/common/option_item.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
import 'package:dota_trivia/ui/trivia/trivia_page.dart';
import 'package:dota_trivia/ui/trivia/widgets/empty_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocSelector<TriviaCubit, TriviaState, List<OptionItem>?>(
      selector: (state) => state.question?.options,
      builder: (context, opts) {
        if (opts == null) {
          return const EmptyOptions();
        }

        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: opts.map((opt) {
            return BlocSelector<TriviaCubit, TriviaState, OptionsStatus?>(
              selector: (state) => state.optionsStatus,
              builder: (context, optStat) {
                LinearGradient linearGradient;
                if (optStat == OptionsStatus.active) {
                  linearGradient = _activeOptionGradient();
                } else if (optStat == OptionsStatus.locked) {
                  linearGradient = _selectedOptionGradient();
                } else if (optStat == OptionsStatus.incorrect) {
                  linearGradient = _incorrectOptionGradient();
                } else if (optStat == OptionsStatus.correct) {
                  linearGradient = _correctOptionGradient();
                } else {
                  linearGradient = const LinearGradient(colors: [
                    Colors.transparent,
                    Colors.transparent,
                  ]);
                }

                return GestureDetector(
                  onTap: () {
                    if (opt.label != null && optStat == OptionsStatus.active) {
                      BlocProvider.of<TriviaCubit>(context)
                          .chooseOption(opt.label!);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white54.withOpacity(0.3),
                        width: 1.3,
                      ),
                      gradient: linearGradient,
                    ),
                    width: MediaQuery.of(context).size.width / 2 - (8 * 2 - 4),
                    height: 80.0,
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Text(
                          opt.label != null ? opt.label!.toUpperCase() : '',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.deepOrangeAccent,
                                  ),
                        ),
                        Center(
                          child: Text(
                            opt.content != null ? opt.content! : '',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),

                        // if (true)
                        //   const Positioned(
                        //     bottom: 0,
                        //     child: Icon(
                        //       Icons.check,
                        //       color: Colors.green,
                        //     ),
                        //   )
                        // else
                        //   Positioned(
                        //     bottom: 0,
                        //     child: Icon(
                        //       Icons.close,
                        //       color: Colors.deepOrangeAccent,
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
