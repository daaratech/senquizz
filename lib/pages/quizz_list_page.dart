import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/features/quiz/data/repository/quiz_repo.dart';
import 'package:senquizz/features/quiz/screens/quiz_form_screen.dart';
import 'package:senquizz/widgets/quiz_card.dart';

import '../features/shared/ui/bussiness_logic/quizz_list/quizz_list_cubit.dart';

class QuizListPage extends StatelessWidget {
  static const routeName = '/quizzes_list';
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuizListCubit(context.read<QuizRepository>())..loadQuizzes(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, QuizFormScreen.routeName);
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Quizzes'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Quizzes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (query) {
                    context.read<QuizListCubit>().searchQuiz(query);
                  },
                ),
              );
            }),
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: FilterByCategorySection(),
            ),
            Expanded(
              child: BlocBuilder<QuizListCubit, QuizListState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.error.isNotEmpty) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state.filteredQuizzes.isEmpty) {
                    return const Center(child: Text('No quizzes found'));
                  } else {
                    return ListView.builder(
                      itemCount: state.filteredQuizzes.length,
                      itemBuilder: (context, index) {
                        final quiz = state.filteredQuizzes[index];
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: QuizCard(
                            categories: quiz.categories,
                            title: quiz.name,
                            description: quiz.description,
                            questionCount: quiz.questions.length,
                            points: quiz.numberOfQuestions,
                            uuid: quiz.uuid!,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterByCategorySection extends StatefulWidget {
  const FilterByCategorySection({super.key});

  @override
  _FilterByCategorySectionState createState() =>
      _FilterByCategorySectionState();
}

class _FilterByCategorySectionState extends State<FilterByCategorySection> {
  final List<String> categories = ['Math', 'Science', 'History', 'Geography'];
  final List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: categories.map((category) {
        final isSelected = selectedCategories.contains(category);
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedCategories.add(category);
              } else {
                selectedCategories.remove(category);
              }
              context
                  .read<QuizListCubit>()
                  .filterByCategories(selectedCategories);
            });
          },
        );
      }).toList(),
    );
  }
}
