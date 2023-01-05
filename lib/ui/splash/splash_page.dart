import 'package:dota_trivia/constants/colors.dart';
import 'package:dota_trivia/ui/home/home_page.dart';
import 'package:dota_trivia/ui/splash/cubit/splash_cubit.dart';
import 'package:dota_trivia/ui/splash/cubit/splash_state.dart';
import 'package:dota_trivia/ui/splash/widgets/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kiwi/kiwi.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   final _splashCubit = KiwiContainer().resolve<SplashCubit>();

//   @override
//   void initState() {
//     super.initState();

//     _splashCubit.fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => _splashCubit,
//       child: BlocListener<SplashCubit, SplashState>(
//         listener: (context, state) {
//           if (state.isFetchDataSuccess) {
//             Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (_) => const HomePage()));
//           }
//         },
//         child: Scaffold(
//           body: Stack(
//             children: [
//               Center(
//                 child: Image.asset(
//                   'assets/logo.png',
//                   width: 120.0,
//                 ),
//               ),
//               Column(
//                 children: const [
//                   Spacer(),
//                   Center(child: CircularProgressIndicator()),
//                   SizedBox(height: 8.0),
//                   LoadingStatus(),
//                   SizedBox(height: 16.0)
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
