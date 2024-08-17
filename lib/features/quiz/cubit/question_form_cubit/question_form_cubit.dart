import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/quiz.dart';

part 'question_form_state.dart';

class QuestionFormCubit extends Cubit<QuestionFormState> {
  QuestionFormCubit({QuestionFormState? initialState})
      : super(initialState ??
            QuestionFormState(quiz: Quiz.empty(), isLoading: true));

  void setQuestionText(String text) {
    emit(state.copyWith(questionText: text));
  }

  void setQuiz(Quiz quiz) {
    emit(state.copyWith(quiz: quiz, isLoading: false, questionIndex: 0));
  }

  void addAnswer() {
    emit(state.copyWith(answers: List.from(state.answers)..add('')));
  }

  void removeAnswer(int index) {
    if (state.answers.length > 2) {
      emit(state.copyWith(answers: List.from(state.answers)..removeAt(index)));
    }
  }

  void setAnswerText(int index, String text) {
    final updatedAnswers = List<String>.from(state.answers);
    updatedAnswers[index] = text;
    emit(state.copyWith(answers: updatedAnswers));
  }

  void setCorrectAnswerIndex(int index) {
    emit(state.copyWith(correctAnswerIndex: index));
  }

  void saveQuestionAndGoToTheNextOne() {
    final question = Question(
      name: state.questionText,
      answers: state.answers,
      indexOfRightAnswer: state.correctAnswerIndex,
    );
    late Quiz newQuiz;
    var nextQuestion =
        const Question(name: '', answers: ['', ''], indexOfRightAnswer: 0);
    if (state.questionIndex + 1 < state.quiz.questions.length) {
      var isNextQuestionAlreadySet =
          state.quiz.questions.length >= state.questionIndex + 1;
      if (isNextQuestionAlreadySet) {
        newQuiz = _editQuestion(question);
        nextQuestion = _loadNextQuestion(nextQuestion);
      } else {
        newQuiz = state.quiz.copyWith(questions: [
          ...state.quiz.questions.sublist(0, state.questionIndex),
          question,
        ]);
      }
    } else {
      newQuiz = state.quiz.copyWith(questions: [
        ...state.quiz.questions,
        question,
      ]);
    }

    emit(state.copyWith(
      questionIndex: state.questionIndex + 1,
      questionText: nextQuestion.name,
      answers: nextQuestion.answers,
      correctAnswerIndex: nextQuestion.indexOfRightAnswer,
      quiz: newQuiz,
    ));
  }

  saveLastQuestion() {
    final question = Question(
      name: state.questionText,
      answers: state.answers,
      indexOfRightAnswer: state.correctAnswerIndex,
    );
    final newQuiz = state.quiz.copyWith(questions: [
      ...state.quiz.questions,
      question,
    ]);
    emit(state.copyWith(
      quiz: newQuiz,
      isEditingComplet: true,
    ));
  }

  Question _loadNextQuestion(Question nextQuestion) {
    return nextQuestion.copyWith(
        name: state.quiz.questions[state.questionIndex + 1].name,
        answers: state.quiz.questions[state.questionIndex + 1].answers,
        indexOfRightAnswer:
            state.quiz.questions[state.questionIndex + 1].indexOfRightAnswer);
  }

  Quiz _editQuestion(Question question) {
    return state.quiz.copyWith(questions: [
      ...state.quiz.questions.sublist(0, state.questionIndex),
      question,
      ...state.quiz.questions.sublist(state.questionIndex + 1),
    ]);
  }

  void goToThepreviousQuestion() {
    //init state of previeous question
    final previousQuestion = state.quiz.questions[state.questionIndex - 1];
    emit(state.copyWith(
        questionIndex: state.questionIndex - 1,
        questionText: previousQuestion.name,
        answers: previousQuestion.answers,
        correctAnswerIndex: previousQuestion.indexOfRightAnswer,
        isEditingComplet: false));
  }

  void initializeQuestion(Question question) {}

  void clearQuestion() {}
}
