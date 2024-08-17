import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/quiz.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  void createQuiz(String name, Level level, String description,
      List<String> categories, int numberOfQuestions, int duration) {
    emit(QuizDetailsEntered(
      name: name,
      level: level,
      description: description,
      categories: categories,
      numberOfQuestions: numberOfQuestions,
      duration: duration,
    ));
  }

  void addQuestions(List<Question> questions) {
    final currentState = state;
    if (currentState is QuizDetailsEntered) {
      emit(QuizDetailsEntered(
        name: currentState.name,
        level: currentState.level,
        description: currentState.description,
        categories: currentState.categories,
        numberOfQuestions: currentState.numberOfQuestions,
        duration: currentState.duration,
        questions: questions,
      ));
    }
  }

  void updateQuestion(int index, Question updatedQuestion) {
    final currentState = state;
    if (currentState is QuizDetailsEntered) {
      final updatedQuestions =
          List<Question>.from(currentState.questions ?? []);
      if (index >= 0 && index < updatedQuestions.length) {
        updatedQuestions[index] = updatedQuestion;
        emit(currentState.copyWith(questions: updatedQuestions));
      }
    }
  }

  void addOrUpdateQuestion(Question question, {int? index}) {
    final currentState = state;
    if (currentState is QuizDetailsEntered) {
      final questions = List<Question>.from(currentState.questions ?? []);
      if (index != null && index >= 0 && index < questions.length) {
        questions[index] = question;
      } else {
        questions.add(question);
      }
      emit(currentState.copyWith(questions: questions));
    }
  }

  Question getQuestion(int index) {
    final currentState = state;
    if (currentState is QuizDetailsEntered) {
      return currentState.questions?[index] ??
          const Question(name: '', answers: [], indexOfRightAnswer: 0);
    }
    return const Question(name: '', answers: [], indexOfRightAnswer: 0);
  }
}
