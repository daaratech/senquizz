// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senquizz/features/quiz/models/quiz.dart';

import '../../../../quiz/data/repository/quiz_repo.dart';

class QuizListState {
  final List<Quiz> quizzes;
  final List<Quiz> filteredQuizzes;
  final bool isLoading;
  final String error;

  QuizListState({
    required this.quizzes,
    required this.filteredQuizzes,
    this.isLoading = false,
    this.error = '',
  });

  QuizListState copyWith({
    List<Quiz>? quizzes,
    List<Quiz>? filteredQuizzes,
    bool? isLoading,
    String? error,
  }) {
    return QuizListState(
      quizzes: quizzes ?? this.quizzes,
      filteredQuizzes: filteredQuizzes ?? this.filteredQuizzes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class QuizListCubit extends Cubit<QuizListState> {
  final QuizRepository quizRepository;
  QuizListCubit(
    this.quizRepository,
  ) : super(QuizListState(quizzes: [], filteredQuizzes: []));

  void loadQuizzes() {
    emit(state.copyWith(isLoading: true));
    final List<Quiz> quizzes = quizRepository.getQuizzes();
    // Simulate a network call
    Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(
          quizzes: quizzes, filteredQuizzes: quizzes, isLoading: false));
    });
  }

  void searchQuiz(String query) {
    final filteredQuizzes = state.quizzes.where((quiz) {
      return quiz.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    emit(state.copyWith(filteredQuizzes: filteredQuizzes));
  }

  void filterByCategories(List<String> selectedCategories) {
    final filteredQuizzes = state.quizzes.where((quiz) {
      return selectedCategories
          .every((category) => quiz.categories.contains(category));
    }).toList();
    emit(state.copyWith(filteredQuizzes: filteredQuizzes));
  }
}
