import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/shared/ui/bussiness_logic/author/author_cubit.dart';
import 'author_detail.dart'; // Adjust the import path as necessary

class AuthorPage extends StatelessWidget {
  static const routeName = '/authors';
  const AuthorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorCubit()..loadAuthors(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Authors'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Authors',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (query) {
                    context.read<AuthorCubit>().searchAuthor(query);
                  },
                ),
              );
            }),
          ),
        ),
        body: BlocBuilder<AuthorCubit, AuthorState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error.isNotEmpty) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state.filteredAuthors.isEmpty) {
              return const Center(child: Text('No authors found'));
            } else {
              return ListView.builder(
                itemCount: state.filteredAuthors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          state.filteredAuthors[index].profileImageUrl),
                    ),
                    title: Text(state.filteredAuthors[index].name),
                    subtitle: Text(
                        '${state.filteredAuthors[index].quizCount} quizzes'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigate to author details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthorDetailsPage(
                                author: state.filteredAuthors[index]),
                          ),
                        );
                      },
                      child: const Text('View Details'),
                    ),
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
