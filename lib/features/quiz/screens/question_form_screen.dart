// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/question_form_cubit/question_form_cubit.dart';
import '../models/quiz.dart';
import 'clipped_topbar.dart';
import 'quiz_form_screen.dart';
import 'quiz_summary_screen.dart';

class QuestionFormScreen extends StatelessWidget {
  static const routeName = '/question-form';
  final int? editIndex;
  final Quiz quiz;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  QuestionFormScreen({super.key, this.editIndex, required this.quiz});
  void _submitQuestion(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<QuestionFormCubit>().saveLastQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuestionFormCubit()..setQuiz(quiz),
      child: Scaffold(
          body: QuestionForm(
            formKey: _formKey,
          ),
          bottomNavigationBar:
              BlocBuilder<QuestionFormCubit, QuestionFormState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 10.0,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: (state.questionIndex + 1 < state.quiz.numberOfQuestions)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (state.questionIndex > 0)
                            FormValidationButton(
                              onClick: () => context
                                  .read<QuestionFormCubit>()
                                  .goToThepreviousQuestion(),
                              label: 'Previous',
                              backGroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              textColor: Colors.white,
                            ),
                          FormValidationButton(
                            backGroundColor:
                                Theme.of(context).colorScheme.primary,
                            textColor: Theme.of(context).colorScheme.onPrimary,
                            onClick: () => context
                                .read<QuestionFormCubit>()
                                .saveQuestionAndGoToTheNextOne(),
                            label: 'Next',
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (state.questionIndex > 0)
                            FormValidationButton(
                              onClick: () {
                                context
                                    .read<QuestionFormCubit>()
                                    .goToThepreviousQuestion();
                              },
                              label: 'Previous',
                              backGroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              textColor: Colors.white,
                            ),
                          FormValidationButton(
                              onClick: () {
                                _submitQuestion(context);
                              },
                              label: 'Save',
                              backGroundColor:
                                  Theme.of(context).colorScheme.primary,
                              textColor:
                                  Theme.of(context).colorScheme.onPrimary),
                        ],
                      ),
              );
            },
          )),
    );
  }
}

class FormValidationButton extends StatelessWidget {
  final Function()? onClick;
  final String label;
  final Color? backGroundColor;
  final Color? textColor;
  const FormValidationButton({
    super.key,
    required this.onClick,
    required this.label,
    this.backGroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: onClick, //_submitQuestion(context),
          style: ElevatedButton.styleFrom(backgroundColor: backGroundColor),
          child: Text(label, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}

class QuestionPositionIndicator extends StatelessWidget {
  final int totalQuestions;
  final int currentPosition;

  const QuestionPositionIndicator({
    super.key,
    required this.totalQuestions,
    required this.currentPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalQuestions, (index) {
        return Expanded(
          child: Container(
            width: 20.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: index < currentPosition
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
          ),
        );
      }),
    );
  }
}

class QuestionForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  var questionTextController = TextEditingController();
  var answersTextController =
      List.generate(2, (index) => TextEditingController());

  QuestionForm({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionFormCubit, QuestionFormState>(
      listener: (context, state) {
        if (state.isEditingComplet) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizSummaryScreen(quiz: state.quiz),
            ),
          );
        }
      },
      builder: (context, state) {
        final questionFormCubit = context.read<QuestionFormCubit>();
        questionTextController.text = state.questionText;

        for (int i = 0; i < state.answers.length; i++) {
          answersTextController[i].text = state.answers[i];
        }
        var inputDecoration = InputDecoration(
          labelStyle: TextStyle(color: Colors.grey.shade200),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.grey, // Change this to your desired color
              width: 2.0,
            ),
          ),
        );

        return Stack(
          children: [
            const ClipShapeBackground(),
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    CustomAppBarForCurveBackground(
                      title: "Create Quiz",
                      onGoBack: () {},
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            boxShadow,
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          QuizLabel(
                              label: "Question No. ${state.questionIndex + 1}"),
                          QuestionPositionIndicator(
                            totalQuestions: state.quiz.numberOfQuestions,
                            currentPosition: state.questionIndex + 1,
                          ),
                          const QuizLabel(label: "Question Text"),
                          TextFormField(
                            controller: questionTextController,
                            // ..text = state.questionText,
                            //initialValue: state.questionText,
                            decoration: inputDecoration,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the question text';
                              }
                              return null;
                            },
                            onChanged: questionFormCubit.setQuestionText,
                          ),
                          const SizedBox(height: 16.0),
                          const QuizLabel(label: "Answers"),
                          Column(
                            children:
                                state.answers.asMap().entries.map((entry) {
                              int index = entry.key;
                              var answerController =
                                  answersTextController[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: answerController,
                                        decoration: inputDecoration.copyWith(
                                          labelStyle: const TextStyle(
                                              color: Colors.black),
                                          labelText: 'Option ${index + 1}',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter the answer';
                                          }
                                          return null;
                                        },
                                        onChanged: (text) => questionFormCubit
                                            .setAnswerText(index, text),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.remove_circle,
                                            size: 35,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                        onPressed: () {
                                          questionFormCubit.removeAnswer(index);
                                          answersTextController.removeAt(index);
                                        }),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  questionFormCubit.addAnswer();
                                  answersTextController
                                      .add(TextEditingController());
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.primary),
                                child: const Text('Add another option'),
                              ),
                            ],
                          ),
                          const QuizLabel(label: "Correct Answer"),
                          DropdownButtonFormField<int>(
                            value: state.correctAnswerIndex,
                            items: List.generate(state.answers.length, (index) {
                              return DropdownMenuItem<int>(
                                value: index,
                                child: Text('Answer ${index + 1}'),
                              );
                            }),
                            onChanged: (int? newValue) {
                              if (newValue != null) {
                                questionFormCubit
                                    .setCorrectAnswerIndex(newValue);
                              }
                            },
                            decoration: inputDecoration.copyWith(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary, // Change this to your desired color
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
