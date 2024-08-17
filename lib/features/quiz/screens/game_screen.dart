import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/game_cubit/game_cubit.dart';
import '../data/repository/quiz_repo.dart';
import '../models/quiz.dart';
import 'game_widget.dart';
import 'result_screen.dart';

class GameScreen extends StatelessWidget {
  static const routeName = '/game';
  static const uuidArgs = "quiz_uuid";
  final String uuid;

  const GameScreen({super.key, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GameCubit(uuid, context.read<QuizRepository>())..loadQuiz(uuid),
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state.status == GameStatus.questionLoaded ||
              state.status == GameStatus.questionAnsweredIncorrectly ||
              state.status == GameStatus.questionAnsweredCorrectly) {
            return GameWidget(
              state: state,
              onAnswer: (index) {
                context.read<GameCubit>().answerQuestion(index);
              },
              onGoToNextQuestion: () {
                context.read<GameCubit>().nextQuestion();
              },
            );
          } else if (state.status == GameStatus.finished) {
            return QuizResultPage(
              totalQuestions: state.quiz.questions.length,
              correctAnswers: state.correctAnswers,
              unansweredQuestions:
                  state.quiz.questions.length - state.correctAnswers,
              points: state.correctAnswers * 10,
            );
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}

class QuestionView extends StatelessWidget {
  final GameState state;

  const QuestionView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${state.timeLeft}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
              child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.question.name),
              ],
            ),
          )),
          Text(
            'Question ${state.currentQuestionIndex + 1}:',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            state.question.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          ...state.question.answers.asMap().entries.map((entry) {
            int index = entry.key;
            String answer = entry.value;
            return ListTile(
              title: Text(answer),
              onTap: () => gameCubit.answerQuestion(index),
            );
          }),
        ],
      ),
    );
  }
}

class AnswerView extends StatelessWidget {
  final GameState state;

  const AnswerView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();
    final isCorrect = state.status == GameStatus.questionAnsweredCorrectly;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCorrect ? 'Correct!' : 'Incorrect!',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isCorrect ? Colors.green : Colors.red),
          ),
          const SizedBox(height: 16),
          const Text(
            'Question:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            state.question.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Text(
            // 'Correct Answer: ${currentState.question.answers[currentState.question.indexOfRightAnswer]}',
            'Correct Answer: ${state.question.answers[state.question.indexOfRightAnswer]} ',
            style: const TextStyle(fontSize: 18, color: Colors.green),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => gameCubit.nextQuestion(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Next Question'),
          ),
        ],
      ),
    );
  }
}
