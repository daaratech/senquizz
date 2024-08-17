// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senquizz/features/quiz/data/repository/quiz_repo.dart';

import '../../models/quiz.dart';

part 'quiz_form_state.dart';

class QuizFormCubit extends Cubit<QuizFormState> {
  final QuizRepository quizRepository;
  QuizFormCubit(
    this.quizRepository,
  ) : super(const QuizFormState());

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setLevel(Level level) {
    emit(state.copyWith(level: level));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void setCategories(String category) {
    var categories = state.categories;
    if (state.categories.contains(category)) {
      categories = List.from(state.categories)..remove(category);
      emit(state.copyWith(categories: categories));
    } else {
      categories = List.from(categories + [category]);
      emit(state.copyWith(categories: categories));
    }
  }

  void setNumberOfQuestions(int numberOfQuestions) {
    emit(state.copyWith(numberOfQuestions: numberOfQuestions));
  }

  void setDuration(int duration) {
    emit(state.copyWith(duration: duration));
  }

  void createQuiz() {
    final quiz = Quiz(
      name: state.name,
      level: state.level,
      description: state.description,
      categories: state.categories,
      numberOfQuestions: state.numberOfQuestions,
      duration: state.duration,
    );
//quizRepository.createQuiz(quiz);
    emit(state.copyWith(quiz: quiz));
  }
}
