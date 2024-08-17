part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizDetailsEntered extends QuizState {
  final String name;
  final Level level;
  final String description;
  final List<String> categories;
  final int numberOfQuestions;
  final int duration;
  final List<Question>? questions;

  const QuizDetailsEntered({
    required this.name,
    required this.level,
    required this.description,
    required this.categories,
    required this.numberOfQuestions,
    required this.duration,
    this.questions,
  });

  QuizDetailsEntered copyWith({List<Question>? questions}) {
    return QuizDetailsEntered(
      name: name,
      level: level,
      description: description,
      categories: categories,
      numberOfQuestions: numberOfQuestions,
      duration: duration,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object> get props => [
        name,
        level,
        description,
        categories,
        numberOfQuestions,
        duration,
        questions ?? []
      ];
}

class QuizCompleted extends QuizState {
  final Quiz quiz;

  const QuizCompleted({required this.quiz});

  @override
  List<Object> get props => [quiz];
}
