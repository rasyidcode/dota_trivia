// import 'package:dota_trivia/data/model/question_item.dart';
// import 'package:equatable/equatable.dart';

// enum TriviaStatus {
//   initial,
//   loading,
//   error,
//   success,
//   playing,
//   checking,
//   showing
// }

// class TriviaState extends Equatable {
//   const TriviaState({
//     required this.status,
//     this.question,
//     this.error,
//     this.timer,
//     this.playerOption,
//     this.points,
//   });

//   final TriviaStatus status;

//   final QuestionItem? question;
//   final String? error;
//   final int? timer;
//   final String? playerOption;
//   final int? points;

//   String? get correctOption =>
//       question?.options?.firstWhere((opt) => opt.isCorrect == true).label;

//   bool get isInitial => status == TriviaStatus.initial;
//   bool get isLoading => status == TriviaStatus.loading;
//   bool get isError => status == TriviaStatus.error;
//   bool get isReady => status == TriviaStatus.success && question != null;
//   bool get isPlaying => status == TriviaStatus.playing;
//   bool get isChecking => status == TriviaStatus.checking;
//   bool get isShowing => status == TriviaStatus.showing;

//   @override
//   List<Object?> get props => [
//         status,
//         question,
//         error,
//         timer,
//         playerOption,
//       ];

//   TriviaState copyWith({
//     TriviaStatus? status,
//     QuestionItem? question,
//     String? error,
//     int? timer,
//     String? playerOption,
//   }) {
//     return TriviaState(
//       status: status ?? this.status,
//       question: question ?? this.question,
//       error: error ?? this.error,
//       timer: timer ?? this.timer,
//       playerOption: playerOption ?? this.playerOption,
//     );
//   }

//   TriviaState reset() {
//     return TriviaState(
//         status: TriviaStatus.initial, playerOption: null, question: question);
//   }
// }
