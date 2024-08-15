import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/features/shared/domain/model/quizz/quizz.dart';

class QuizState {
  final List<Quiz> quizzes;
  final List<Quiz> filteredQuizzes;
  final bool isLoading;
  final String error;

  QuizState({
    required this.quizzes,
    required this.filteredQuizzes,
    this.isLoading = false,
    this.error = '',
  });

  QuizState copyWith({
    List<Quiz>? quizzes,
    List<Quiz>? filteredQuizzes,
    bool? isLoading,
    String? error,
  }) {
    return QuizState(
      quizzes: quizzes ?? this.quizzes,
      filteredQuizzes: filteredQuizzes ?? this.filteredQuizzes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizState(quizzes: [], filteredQuizzes: []));

  void loadQuizzes() {
    emit(state.copyWith(isLoading: true));
    final quizzes = [
      Quiz(
        title: 'Math Quiz',
        description: 'A quiz about basic math concepts.',
        questions: 10,
        points: 100,
        categories: ['Math', 'Science'],
      ),
      Quiz(
        title: 'History Quiz',
        description: 'A quiz about world history.',
        questions: 15,
        points: 150,
        categories: ['History'],
      ),
      Quiz(
        title: 'Geography Quiz',
        description: 'A quiz about world history.',
        questions: 15,
        points: 150,
        categories: ['History', 'Geography'],
      ),
      Quiz(
        title: 'Science Quiz',
        description: 'A quiz about world history.',
        questions: 15,
        points: 150,
        categories: ['History', 'Geography', 'Science'],
      ),
      // Add more quizzes here
    ];
    // Simulate a network call
    Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(
          quizzes: quizzes, filteredQuizzes: quizzes, isLoading: false));
    });
  }

  void searchQuiz(String query) {
    final filteredQuizzes = state.quizzes.where((quiz) {
      return quiz.title.toLowerCase().contains(query.toLowerCase());
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
