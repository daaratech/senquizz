import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/features/quiz/data/repository/quiz_repo.dart';
import '../../models/quiz.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final QuizRepository quizRepository;
  GameCubit(this.uuid, this.quizRepository)
      : super(GameState(
          Quiz.empty(),
          0,
          Question.empty(),
          0,
          const [],
        ));

  loadQuiz(String uuid) {
    quiz = quizRepository.getQuiz(uuid);
    emit(state.copyWith(
      currentQuestionIndex: 0,
      quiz: quiz,
      question: quiz.questions[0],
      timeLeft: quiz.duration,
      status: GameStatus.loading,
      selectedAnswers: List.filled(quiz.questions.length, -1),
    ));
    _loadNextQuestion();
  }

  final String uuid;
  late final Quiz quiz;
  int currentQuestionIndex = 0;
  Timer? _timer;

  void _loadNextQuestion() {
    if (currentQuestionIndex < quiz.questions.length) {
      emit(state.copyWith(
          quiz: quiz,
          currentQuestionIndex: currentQuestionIndex,
          question: quiz.questions[currentQuestionIndex],
          timeLeft: quiz.duration,
          status: GameStatus.questionLoaded));
      _startTimer();
    } else {
      _timer?.cancel();
      emit(state.copyWith(
          correctAnswers: state.correctAnswers, status: GameStatus.finished));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeLeft > 0) {
        emit(state.copyWith(
            timeLeft: state.timeLeft - 1, status: GameStatus.questionLoaded));
      } else {
        _showCorrectAnswer();
      }
    });
  }

  void answerQuestion(int selectedAnswerIndex) {
    _timer?.cancel();
    var selectedAnswers = state.selectedAnswers;
    selectedAnswers[currentQuestionIndex] = selectedAnswerIndex;
    if (selectedAnswerIndex == state.question.indexOfRightAnswer) {
      final correctAnswers = state.correctAnswers + 1;
      emit(state.copyWith(
        quiz: quiz,
        currentQuestionIndex: state.currentQuestionIndex,
        question: state.question,
        timeLeft: state.timeLeft,
        correctAnswers: correctAnswers,
        status: GameStatus.questionAnsweredCorrectly,
        selectedAnswers: selectedAnswers,
      ));
    } else {
      _showCorrectAnswer();
    }
  }

  void _showCorrectAnswer() {
    emit(state.copyWith(
      quiz: quiz,
      currentQuestionIndex: state.currentQuestionIndex,
      question: state.question,
      timeLeft: state.timeLeft,
      correctAnswers: state.correctAnswers,
      status: GameStatus.questionAnsweredIncorrectly,
    ));
  }

  void nextQuestion() {
    currentQuestionIndex++;
    _loadNextQuestion();
  }
}
