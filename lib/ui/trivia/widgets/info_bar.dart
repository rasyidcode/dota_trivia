// import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
// import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// class InfoBar extends StatelessWidget {
//   const InfoBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: BlocSelector<TriviaCubit, TriviaState, int?>(
//         selector: (state) => state.question?.id,
//         builder: (context, id) => Text(
//           id != null ? '#${NumberFormat("#,###", "en_US").format(id)}' : '',
//           textAlign: TextAlign.end,
//           style: Theme.of(context)
//               .textTheme
//               .bodySmall
//               ?.copyWith(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
