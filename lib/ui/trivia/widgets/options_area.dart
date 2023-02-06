// import 'package:dota_trivia/constants/templates.dart';
// import 'package:dota_trivia/data/model/common/option.dart';
// import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
// import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
// import 'package:dota_trivia/ui/trivia/widgets/empty_options.dart';
// import 'package:dota_trivia/ui/trivia/widgets/option_content.dart';
// import 'package:dota_trivia/ui/trivia/widgets/options/text_icon_option.dart';
// import 'package:dota_trivia/ui/trivia/widgets/options/text_only_option.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class OptionsArea extends StatelessWidget {
//   const OptionsArea({super.key});

//   LinearGradient _activeOptionGradient() {
//     return LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Colors.blueGrey.withOpacity(0.7),
//         Colors.blueGrey.withOpacity(0.7),
//       ],
//     );
//   }

//   LinearGradient _selectedOptionGradient() {
//     return LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Colors.black.withRed(25),
//         Colors.black.withRed(75),
//       ],
//     );
//   }

//   LinearGradient _incorrectOptionGradient() {
//     return LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Colors.black.withRed(25),
//         Colors.black.withRed(75),
//         Colors.black.withRed(125),
//       ],
//     );
//   }

//   LinearGradient _correctOptionGradient() {
//     return LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Colors.black.withRed(25),
//         Colors.black.withRed(100),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TriviaCubit, TriviaState>(builder: (context, state) {
//       List<OptionItem>? opts = state.question?.options;

//       if (opts == null) {
//         return const EmptyOptions();
//       }

//       return Wrap(
//         spacing: 8.0,
//         runSpacing: 8.0,
//         children: opts.map((opt) {
//           String? playerOpt = state.playerOption;
//           String? correctOpt = state.correctOption;

//           LinearGradient linearGradient =
//               const LinearGradient(colors: [Colors.black, Colors.black]);

//           if (state.isPlaying || state.isChecking) {
//             if (playerOpt != null &&
//                 opt.label != null &&
//                 opt.label == playerOpt) {
//               linearGradient = _selectedOptionGradient();
//             } else {
//               linearGradient = _activeOptionGradient();
//             }
//           }

//           if (state.isShowing) {
//             if (playerOpt == null &&
//                 correctOpt != null &&
//                 correctOpt == opt.label) {
//               linearGradient = _selectedOptionGradient();
//             }

//             if (playerOpt != null && correctOpt != null && opt.label != null) {
//               if (opt.label == playerOpt) {
//                 if (playerOpt == correctOpt) {
//                   linearGradient = _correctOptionGradient();
//                 } else {
//                   linearGradient = _incorrectOptionGradient();
//                 }
//               } else {
//                 if (opt.label == correctOpt) {
//                   linearGradient = _selectedOptionGradient();
//                 }
//               }
//             }
//           }

//           return GestureDetector(
//             onTap: () {
//               if (opt.label != null && state.isPlaying && playerOpt == null) {
//                 BlocProvider.of<TriviaCubit>(context).chooseOption(opt.label!);
//               }
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.white54.withOpacity(0.3),
//                   width: 1.3,
//                 ),
//                 gradient: linearGradient,
//               ),
//               width: MediaQuery.of(context).size.width / 2 - (8 * 2 - 4),
//               height: 80.0,
//               padding: const EdgeInsets.all(8.0),
//               child: Stack(
//                 children: [
//                   Text(
//                     opt.label != null ? opt.label!.toUpperCase() : '',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           color: Colors.deepOrangeAccent,
//                         ),
//                   ),
//                   OptionContent(
//                     content: opt.content ?? '',
//                     templateId: state.question?.templateId ?? 0,
//                   ),
//                   if (state.isShowing &&
//                       playerOpt != null &&
//                       opt.label != null &&
//                       playerOpt == opt.label)
//                     Positioned(
//                       bottom: 0,
//                       child: playerOpt == correctOpt
//                           ? const Icon(
//                               Icons.check,
//                               color: Colors.green,
//                             )
//                           : const Icon(
//                               Icons.close,
//                               color: Colors.deepOrangeAccent,
//                             ),
//                     )
//                   else
//                     Container()
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       );
//     });
//   }
// }
