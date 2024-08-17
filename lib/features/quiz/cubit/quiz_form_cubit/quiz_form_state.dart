part of 'quiz_form_cubit.dart';

class QuizFormState extends Equatable {
  final String name;
  final Level level;
  final String description;
  final List<String> categories;
  final int numberOfQuestions;
  final int duration;
  final Quiz? quiz;

  const QuizFormState({
    this.name = '',
    this.level = Level.easy,
    this.description = '',
    this.categories = const [],
    this.numberOfQuestions = 1,
    this.duration = 1,
    this.quiz,
  });

  QuizFormState copyWith({
    String? name,
    Level? level,
    String? description,
    List<String>? categories,
    int? numberOfQuestions,
    int? duration,
    Quiz? quiz,
  }) {
    return QuizFormState(
      name: name ?? this.name,
      level: level ?? this.level,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      duration: duration ?? this.duration,
      quiz: quiz ?? this.quiz,
    );
  }

  @override
  List<Object?> get props => [
        name,
        level,
        description,
        categories,
        numberOfQuestions,
        duration,
        quiz,
      ];
}
