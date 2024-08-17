part of 'question_form_cubit.dart';

class QuestionFormState extends Equatable {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;
  final bool isLoading;
  final int questionIndex;
  final Quiz quiz;
  final bool isEditingComplet;

  const QuestionFormState({
    this.questionText = '',
    this.answers = const ['', ''],
    this.correctAnswerIndex = 0,
    this.isLoading = false,
    this.questionIndex = -1,
    required this.quiz,
    this.isEditingComplet = false,
  });

  QuestionFormState copyWith({
    String? questionText,
    List<String>? answers,
    int? correctAnswerIndex,
    bool? isLoading,
    Quiz? quiz,
    int? questionIndex,
    bool? isEditingComplet,
  }) {
    return QuestionFormState(
      questionText: questionText ?? this.questionText,
      answers: answers ?? this.answers,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      isLoading: isLoading ?? this.isLoading,
      quiz: quiz ?? this.quiz,
      questionIndex: questionIndex ?? this.questionIndex,
      isEditingComplet: isEditingComplet ?? this.isEditingComplet,
    );
  }

  @override
  List<Object> get props => [
        questionText,
        answers,
        correctAnswerIndex,
        isLoading,
        quiz,
        questionIndex,
        isEditingComplet
      ];
}
