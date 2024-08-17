import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/features/quiz/data/repository/quiz_repo.dart';
import 'package:uuid/uuid.dart';

import '../../models/quiz.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  final QuizRepository quizRepository;
  SummaryCubit(this.quizRepository) : super(SummaryInitial());
  loadQuiz(Quiz quiz) {
    emit(SummarySuccess(quiz: quiz));
  }

  saveQuiz(Quiz quiz) {
    quizRepository.createQuiz(quiz.copyWith(uuid: const Uuid().v4()));
  }
}
