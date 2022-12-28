import 'package:dota_trivia/data/model/question_item.dart';
import 'package:equatable/equatable.dart';

enum GenerateQuestionStatus { loading, error, success }

enum GetQuestionStatus { loading, error, success }

enum TriviaSessionStatus { ongoing, checking, showing, resetting }

class TriviaState extends Equatable {
  const TriviaState({
    this.generateQuestionStatus,
    this.getQuestionStatus,
    this.triviaSessionStatus,
    this.question,
    this.error,
    this.timer,
    this.playerOption,
    this.points,
  });

  final GenerateQuestionStatus? generateQuestionStatus;
  final GetQuestionStatus? getQuestionStatus;
  final TriviaSessionStatus? triviaSessionStatus;

  final QuestionItem? question;
  final String? error;
  final int? timer;
  final String? playerOption;
  final int? points;

  bool get isLoadingQuestion =>
      generateQuestionStatus == GenerateQuestionStatus.loading ||
      getQuestionStatus == GetQuestionStatus.loading;

  bool get isGenerateQuestionInitial => generateQuestionStatus == null;
  bool get isGenerateQuestionLoading =>
      generateQuestionStatus == GenerateQuestionStatus.loading;
  bool get isGenerateQuestionError =>
      generateQuestionStatus == GenerateQuestionStatus.error;
  bool get isGenerateQuestionSuccess =>
      generateQuestionStatus == GenerateQuestionStatus.success;

  bool get isGetQuestionError =>
      generateQuestionStatus == GetQuestionStatus.error;
  bool get isGetQuestionSuccess =>
      generateQuestionStatus == GetQuestionStatus.success;

  bool get isTriviaReady =>
      generateQuestionStatus == GenerateQuestionStatus.success &&
      getQuestionStatus == GetQuestionStatus.success;
  bool get isTriviaOngoing =>
      triviaSessionStatus == TriviaSessionStatus.ongoing;
  bool get isTriviaCheckingPlayerOption =>
      triviaSessionStatus == TriviaSessionStatus.checking;
  bool get isTriviaShowingResult =>
      triviaSessionStatus == TriviaSessionStatus.showing;
  bool get isTriviaResetting =>
      triviaSessionStatus == TriviaSessionStatus.resetting;

  String? get correctOption =>
      question?.options?.firstWhere((opt) => opt.isCorrect == true).label;

  @override
  List<Object?> get props => [
        generateQuestionStatus,
        getQuestionStatus,
        triviaSessionStatus,
        question,
        error,
        timer,
        playerOption,
      ];

  TriviaState copyWith({
    GenerateQuestionStatus? generateQuestionStatus,
    GetQuestionStatus? getQuestionStatus,
    TriviaSessionStatus? triviaSessionStatus,
    QuestionItem? question,
    String? error,
    int? timer,
    String? playerOption,
  }) {
    return TriviaState(
      generateQuestionStatus:
          generateQuestionStatus ?? this.generateQuestionStatus,
      getQuestionStatus: getQuestionStatus ?? this.getQuestionStatus,
      triviaSessionStatus: triviaSessionStatus ?? this.triviaSessionStatus,
      question: question ?? this.question,
      error: error ?? this.error,
      timer: timer ?? this.timer,
      playerOption: playerOption ?? this.playerOption,
    );
  }
}
