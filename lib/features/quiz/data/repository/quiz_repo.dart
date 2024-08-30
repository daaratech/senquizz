import 'package:senquizz/features/quiz/models/quiz.dart';

class QuizRepository {
  final List<Quiz> quizzes = dummyQuizzes;
  createQuiz(Quiz quiz) {
    final lastQuizIndex = quizzes.length - 1;
    quizzes.insert(lastQuizIndex, quiz);
  }

  getQuizzes() {
    return quizzes;
  }

  getQuiz(String uuid) {
    return quizzes.firstWhere((quiz) => quiz.uuid == uuid);
  }
}
