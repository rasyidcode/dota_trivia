import 'package:dota_trivia/data/model/question_item.dart';
import 'package:equatable/equatable.dart';

enum TriviaStateStatus {
  initial,
  loading,
  failure,
  success,
}

enum FetchDataStatus { loading, success, failed, completed }

enum SessionStatus { start, ongoing, checking, show }

enum OptionsStatus { active, locked, incorrect, correct }

class TriviaState extends Equatable {
  const TriviaState({
    required this.status,
    this.question,
    this.message,
    this.timer,
    this.fetchDataStatus,
    this.sessionStatus,
    this.optionsStatus,
    this.playerOption,
  });

  final TriviaStateStatus status;
  final QuestionItem? question;
  final String? message;
  final int? timer;
  final FetchDataStatus? fetchDataStatus;
  final SessionStatus? sessionStatus;
  final OptionsStatus? optionsStatus;
  final String? playerOption;

  bool get isLoadingQuestion => status == TriviaStateStatus.loading;
  bool get isTimerReady => sessionStatus == SessionStatus.start;
  bool get isTimerOngoing => sessionStatus == SessionStatus.ongoing;
  bool get isCheckingAnswer => sessionStatus == SessionStatus.checking;
  bool get isShowResult => sessionStatus == SessionStatus.show;
  bool get isFetchDataCompleted => fetchDataStatus == FetchDataStatus.success;

  @override
  List<Object?> get props => [
        status,
        question,
        message,
        timer,
        fetchDataStatus,
        sessionStatus,
        optionsStatus,
        playerOption,
      ];

  TriviaState copyWith({
    TriviaStateStatus? status,
    QuestionItem? question,
    String? message,
    int? timer,
    FetchDataStatus? fetchDataStatus,
    SessionStatus? sessionStatus,
    OptionsStatus? optionsStatus,
    String? playerOption,
  }) {
    return TriviaState(
      status: status ?? this.status,
      question: question ?? this.question,
      message: message ?? this.message,
      timer: timer ?? this.timer,
      fetchDataStatus: fetchDataStatus ?? this.fetchDataStatus,
      sessionStatus: sessionStatus ?? this.sessionStatus,
      optionsStatus: optionsStatus ?? this.optionsStatus,
      playerOption: playerOption ?? this.playerOption,
    );
  }
}
