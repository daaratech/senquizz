import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/features/quiz/data/repository/quiz_repo.dart';
import 'package:senquizz/home_page.dart';
import 'package:senquizz/pages/quizz_list_page.dart';
import '../cubit/summary_cubit/summary_cubit.dart';
import '../models/quiz.dart';
import 'clipped_topbar.dart';
import 'question_form_screen.dart';
import 'quiz_form_screen.dart';

class QuizSummaryScreen extends StatelessWidget {
  static const routeName = '/quiz-summary';
  final Quiz quiz;
  const QuizSummaryScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SummaryCubit(context.read<QuizRepository>())..loadQuiz(quiz),
      child: Scaffold(
        bottomNavigationBar: CustomBottomBar(
          buttons: [
            FormValidationButton(
              backGroundColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.onError,
              onClick: () {
                Navigator.pop(context);
              },
              label: 'Back',
            ),
            BlocBuilder<SummaryCubit, SummaryState>(builder: (context, state) {
              if (state is SummarySuccess) {
                return FormValidationButton(
                  backGroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  onClick: () {
                    context.read<SummaryCubit>().saveQuiz(quiz);
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        QuizListPage.routeName,
                        ModalRoute.withName(HomePage.routeName));
                  },
                  label: 'Confirm',
                );
              } else {
                return FormValidationButton(
                  backGroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  onClick: null,
                  label: 'Confirm',
                );
              }
            }),
          ],
        ),
        body: BlocProvider(
          create: (context) =>
              SummaryCubit(context.read<QuizRepository>())..loadQuiz(quiz),
          child: BlocBuilder<SummaryCubit, SummaryState>(
            builder: (context, state) {
              if (state is SummarySuccess) {
                return Stack(
                  children: [
                    const ClipShapeBackground(),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          CustomAppBarForCurveBackground(
                            title: "Create Quiz",
                            onGoBack: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const QuizCreationDefaultHeader(
                            title: "Quiz summary",
                            decription:
                                "Check the information you have entered",
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  boxShadow,
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${state.quiz.name}',
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                    'Level: ${state.quiz.level.toString().split('.').last}',
                                    style: const TextStyle(fontSize: 18)),
                                Text('Description: ${state.quiz.description}',
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                    'Categories: ${state.quiz.categories.join(', ')}',
                                    style: const TextStyle(fontSize: 18)),
                                Text(
                                    'Number of Questions: ${state.quiz.numberOfQuestions}',
                                    style: const TextStyle(fontSize: 18)),
                                Text('Duration: ${state.quiz.duration} minutes',
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(height: 16),
                                const Text('Questions:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                ...state.quiz.questions.map(
                                  (question) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(question.name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...question.answers
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              int answerIndex = entry.key;
                                              String answer = entry.value;
                                              return Text(
                                                '${answerIndex + 1}. $answer',
                                                style: TextStyle(
                                                  fontWeight: answerIndex ==
                                                          question
                                                              .indexOfRightAnswer
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: answerIndex ==
                                                          question
                                                              .indexOfRightAnswer
                                                      ? Colors.green
                                                      : Colors.black,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is SummaryFailure) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
