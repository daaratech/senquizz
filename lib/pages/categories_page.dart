import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/widgets/category_card.dart';
import '../features/shared/ui/bussiness_logic/category/category_cubit.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/categories';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..loadCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Categories',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (query) {
                    context.read<CategoryCubit>().searchCategory(query);
                  },
                ),
              );
            }),
          ),
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error.isNotEmpty) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state.filteredCategories.isEmpty) {
              return const Center(child: Text('No categories found'));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ),
                itemCount: state.filteredCategories.length,
                itemBuilder: (context, index) {
                  return CardWithImageBackground(
                    title: state.filteredCategories[index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
