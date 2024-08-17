part of 'game_cubit.dart';

class GameState extends Equatable {
  const GameState(
    this.quiz,
    this.currentQuestionIndex,
    this.question,
    this.timeLeft,
    this.selectedAnswers, {
    this.correctAnswers = 0,
    this.status = GameStatus.initial,
  });

  final Quiz quiz;
  final int currentQuestionIndex;
  final Question question;
  final int timeLeft;
  final int correctAnswers;
  final GameStatus status;
  final List<int> selectedAnswers;

  GameState copyWith({
    Quiz? quiz,
    int? currentQuestionIndex,
    Question? question,
    int? timeLeft,
    int? correctAnswers,
    GameStatus? status,
    List<int>? selectedAnswers,
  }) {
    return GameState(
      quiz ?? this.quiz,
      currentQuestionIndex ?? this.currentQuestionIndex,
      question ?? this.question,
      timeLeft ?? this.timeLeft,
      selectedAnswers ?? this.selectedAnswers,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        quiz,
        currentQuestionIndex,
        question,
        timeLeft,
        correctAnswers,
        status,
        selectedAnswers
      ];
}

enum GameStatus {
  initial,
  loading,
  questionLoaded,
  questionAnsweredCorrectly,
  questionAnsweredIncorrectly,
  finished
}

// class GameInitial extends GameState {
//   const GameInitial(
//       super.quiz, super.currentQuestionIndex, super.question, super.timeLeft);
// }

// class GameQuestionLoaded extends GameState {
//   const GameQuestionLoaded(
//     super.quiz,
//     super.currentQuestionIndex,
//     super.question,
//     super.timeLeft, {
//     super.correctAnswers = 0,
//   });

//   GameQuestionLoaded copyWith({int? timeLeft}) {
//     return GameQuestionLoaded(
//       quiz,
//       currentQuestionIndex,
//       question,
//       timeLeft ?? this.timeLeft,
//       correctAnswers: correctAnswers,
//     );
//   }

//   @override
//   List<Object> get props =>
//       [quiz, currentQuestionIndex, question, timeLeft, correctAnswers];
// }

// class GameQuestionAnsweredCorrectly extends GameState {
//   const GameQuestionAnsweredCorrectly(
//     super.quiz,
//     super.currentQuestionIndex,
//     super.question,
//     super.timeLeft, {
//     super.correctAnswers = 0,
//   });

//   GameQuestionAnsweredCorrectly copyWith({int? correctAnswers}) {
//     return GameQuestionAnsweredCorrectly(
//       quiz,
//       currentQuestionIndex,
//       question,
//       timeLeft,
//       correctAnswers: correctAnswers ?? this.correctAnswers,
//     );
//   }

//   @override
//   List<Object> get props =>
//       [quiz, currentQuestionIndex, question, timeLeft, correctAnswers];
// }

// class GameQuestionAnsweredIncorrectly extends GameState {
//   const GameQuestionAnsweredIncorrectly(
//       super.quiz, super.currentQuestionIndex, super.question, super.timeLeft,
//       {super.correctAnswers});

//   GameQuestionAnsweredIncorrectly copyWith({int? correctAnswers}) {
//     return GameQuestionAnsweredIncorrectly(
//       quiz,
//       currentQuestionIndex,
//       question,
//       timeLeft,
//       correctAnswers: correctAnswers ?? this.correctAnswers,
//     );
//   }

//   @override
//   List<Object> get props =>
//       [quiz, currentQuestionIndex, question, timeLeft, correctAnswers];
// }

// class GameFinished extends GameState {
//   const GameFinished(
//     super.quiz,
//     super.currentQuestionIndex,
//     super.question,
//     super.timeLeft, {
//     super.correctAnswers = 0,
//   });

//   GameFinished copyWith({int? correctAnswers}) {
//     return GameFinished(
//       quiz,
//       currentQuestionIndex,
//       question,
//       timeLeft,
//       correctAnswers: correctAnswers ?? this.correctAnswers,
//     );
//   }

//   @override
//   List<Object> get props => [quiz, correctAnswers, question, timeLeft];
// }
