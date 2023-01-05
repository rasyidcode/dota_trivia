import 'package:dota_trivia/ui/home/cubit/home_cubit.dart';
import 'package:dota_trivia/ui/home/widgets/action_bar.dart';
import 'package:dota_trivia/ui/home/widgets/action_menu.dart';
import 'package:dota_trivia/ui/home/widgets/high_score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // final _homeCubit = KiwiContainer().resolve<HomeCubit>();

//   @override
//   void initState() {
//     super.initState();

//     // _homeCubit.getScore();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => _homeCubit,
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: const [
//               ActionBar(),
//               SizedBox(height: 50.0),
//               HighScore(),
//               Spacer(),
//               ActionMenu(),
//               Spacer(),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
