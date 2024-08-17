// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/quiz_cubit.dart';
import '../cubit/quiz_form_cubit/quiz_form_cubit.dart';
import '../data/repository/quiz_repo.dart';
import '../models/quiz.dart';
import 'clipped_topbar.dart';
import 'question_form_screen.dart';

var boxShadow = BoxShadow(
  color: Colors.grey[400]!,
  blurRadius: 5.0,
  spreadRadius: 0.5,
);

class QuizFormScreen extends StatelessWidget {
  static const routeName = "/quiz_form";
  QuizFormScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizFormCubit(context.read<QuizRepository>()),
      child: Scaffold(
        bottomNavigationBar: Builder(builder: (context) {
          return CustomBottomBar(
            buttons: [
              FormValidationButton(
                backGroundColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                onClick: () {
                  _onSubmitQuiz(context);
                },
                label: 'Next',
              ),
            ],
          );
        }),
        body: QuizForm(
          formKey: _formKey,
        ),
      ),
    );
  }

  _onSubmitQuiz(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final quizFormCubit = context.read<QuizFormCubit>();
      quizFormCubit.createQuiz();
      // final quiz = quizFormCubit.state.quiz!;
      // context.read<QuizCubit>().createQuiz(
      //       quiz.name,
      //       quiz.level,
      //       quiz.description,
      //       quiz.categories,
      //       quiz.numberOfQuestions,
      //       quiz.duration,
      //     );
    }
  }
}

class CustomBottomBar extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> buttons;
  const CustomBottomBar(
      {super.key, this.backgroundColor = Colors.white, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
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
      child: Builder(builder: (context) {
        return Row(children: buttons);
      }),
    );
  }
}

class QuizForm extends StatelessWidget {
  final GlobalKey formKey;
  QuizForm({super.key, required this.formKey});
  final List<String> _categories = [
    'Science',
    'Math',
    'History',
    'Literature',
    'Sports'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizFormCubit, QuizFormState>(
      listener: (context, state) {
        if (state.quiz != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionFormScreen(
                quiz: state.quiz!,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<QuizFormCubit, QuizFormState>(
          builder: (context, state) {
            final quizFormCubit = context.read<QuizFormCubit>();
            var inputDecoration = InputDecoration(
              labelStyle: TextStyle(color: Colors.grey.shade200),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
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
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CustomAppBarForCurveBackground(
                        title: "Create Quiz",
                        onGoBack: () {},
                      ),
                      const QuizCreationDefaultHeader(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              boxShadow,
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const QuizLabel(
                                label: 'Quiz Name',
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: TextFormField(
                                  initialValue: state.name,
                                  decoration: inputDecoration,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the quiz name';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) =>
                                      quizFormCubit.setName(value),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const QuizLabel(label: 'Quiz Level'),
                              DropdownButtonFormField<Level>(
                                  value: state.level,
                                  items: Level.values.map((level) {
                                    return DropdownMenuItem<Level>(
                                      value: level,
                                      child: Text(
                                          level.toString().split('.').last),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      quizFormCubit.setLevel(value!),
                                  decoration: inputDecoration),
                              const SizedBox(height: 16.0),
                              const QuizLabel(label: 'Description'),
                              TextFormField(
                                initialValue: state.description,
                                decoration: inputDecoration,
                                onChanged: (value) =>
                                    quizFormCubit.setDescription(value),
                              ),
                              const SizedBox(height: 16.0),
                              const QuizLabel(label: 'Categories'),
                              Wrap(
                                spacing: 5.0,
                                children: _categories.map((category) {
                                  return FilterChip(
                                    label: Text(category),
                                    selected:
                                        state.categories.contains(category),
                                    onSelected: (bool selected) {
                                      quizFormCubit.setCategories(category);
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16.0),
                              const QuizLabel(label: 'Number of Questions'),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: TextFormField(
                                  initialValue:
                                      state.numberOfQuestions.toString(),
                                  decoration: inputDecoration,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the number of questions';
                                    }
                                    if (int.tryParse(value) == null ||
                                        int.tryParse(value)! <= 0) {
                                      return 'Please enter a valid number';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) =>
                                      quizFormCubit.setNumberOfQuestions(
                                          int.tryParse(value) ?? 1),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const QuizLabel(
                                  label: 'Duration by question (seconds)'),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: TextFormField(
                                  initialValue: state.duration.toString(),
                                  decoration: inputDecoration,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontSize: 14),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the duration';
                                    }
                                    if (int.tryParse(value) == null ||
                                        int.tryParse(value)! <= 0) {
                                      return 'Please enter a valid duration';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => quizFormCubit
                                      .setDuration(int.tryParse(value) ?? 1),
                                ),
                              ),
                              const SizedBox(height: 30),
                              // ElevatedButton(
                              //   onPressed: () {

                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //       backgroundColor: Colors.green),
                              //   child: const Text('Next'),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class QuizCreationDefaultHeader extends StatelessWidget {
  final String title;
  final String decription;
  const QuizCreationDefaultHeader({
    super.key,
    this.title = "Create a Quiz",
    this.decription = "Fill in the details below to create a quiz",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            boxShadow,
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            decription,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBarForCurveBackground extends StatelessWidget {
  final String title;
  final Function() onGoBack;
  final List<Widget>? actions;
  const CustomAppBarForCurveBackground({
    super.key,
    required this.title,
    required this.onGoBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onGoBack,
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: actions ?? [],
        )
      ],
    );
  }
}

class QuizLabel extends StatelessWidget {
  final String label;
  const QuizLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        textAlign: TextAlign.start,
        style: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
