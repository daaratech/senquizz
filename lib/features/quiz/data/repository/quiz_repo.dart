import 'package:senquizz/features/quiz/models/quiz.dart';

class QuizRepository {
  final List<Quiz> quizzes = [];
  createQuiz(Quiz quiz) {
    quizzes.add(quiz);
  }

  getQuizzes() {
    return quizzes;
  }

  getQuiz(String uuid) {
    return quizzes.firstWhere((quiz) => quiz.uuid == uuid);
  }
}
