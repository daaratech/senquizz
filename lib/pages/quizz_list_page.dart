import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/widgets/quiz_card.dart';

import '../features/shared/ui/bussiness_logic/quizz/quizz_cubit.dart';

class QuizPage extends StatelessWidget {
  static const routeName = '/quizzes';
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..loadQuizzes(),
      child: Scaffold(
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
                    context.read<QuizCubit>().searchQuiz(query);
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
              child: BlocBuilder<QuizCubit, QuizState>(
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
                              title: quiz.title,
                              description: quiz.description,
                              questionCount: quiz.questions,
                              points: quiz.points),
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
              context.read<QuizCubit>().filterByCategories(selectedCategories);
            });
          },
        );
      }).toList(),
    );
  }
}
