// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Level { easy, medium, hard, veryHard }

class Question extends Equatable {
  final String name;
  final List<String> answers;
  final int indexOfRightAnswer;

  const Question({
    required this.name,
    required this.answers,
    required this.indexOfRightAnswer,
  });

  Question copyWith(
      {String? name, required List<String> answers, int? indexOfRightAnswer}) {
    return Question(
        name: name ?? this.name,
        answers: answers,
        indexOfRightAnswer: indexOfRightAnswer ?? this.indexOfRightAnswer);
  }

  @override
  List<Object> get props => [name, answers, indexOfRightAnswer];
  Question.empty()
      : name = '',
        answers = [],
        indexOfRightAnswer = -1;
}

class Quiz extends Equatable {
  final String? uuid;
  final String name;
  final Level level;
  final String description;
  final List<String> categories;
  final int numberOfQuestions;
  final int duration;
  final List<Question> questions;

  const Quiz({
    this.uuid,
    required this.name,
    required this.level,
    required this.description,
    required this.categories,
    required this.numberOfQuestions,
    required this.duration,
    this.questions = const [],
  });
  @override
  List<Object> get props => [
        name,
        level,
        description,
        categories,
        numberOfQuestions,
        duration,
        questions
      ];

  Quiz copyWith({
    String? name,
    Level? level,
    String? description,
    List<String>? categories,
    int? numberOfQuestions,
    int? duration,
    List<Question>? questions,
    String? uuid,
  }) {
    return Quiz(
      name: name ?? this.name,
      level: level ?? this.level,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      duration: duration ?? this.duration,
      questions: questions ?? this.questions,
      uuid: uuid ?? this.uuid,
    );
  }

  static Quiz empty() {
    return const Quiz(
      name: '',
      level: Level.easy,
      description: '',
      categories: [],
      numberOfQuestions: 1,
      duration: 1,
    );
  }
}
