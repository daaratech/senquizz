import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/pages/author_detail.dart';

class AuthorState extends Equatable {
  final List<Author> authors;
  final List<Author> filteredAuthors;
  final bool isLoading;
  final String error;

  const AuthorState(
      {required this.authors,
      required this.filteredAuthors,
      this.isLoading = false,
      this.error = ''});

  AuthorState copyWith({
    List<Author>? authors,
    List<Author>? filteredAuthors,
    bool? isLoading,
    String? error,
  }) {
    return AuthorState(
      authors: authors ?? this.authors,
      filteredAuthors: filteredAuthors ?? this.filteredAuthors,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [authors, isLoading, error, filteredAuthors];
}

class AuthorCubit extends Cubit<AuthorState> {
  AuthorCubit() : super(const AuthorState(authors: [], filteredAuthors: []));

  void loadAuthors() {
    emit(state.copyWith(isLoading: true));
    final authors = [
      Author(
          profileImageUrl:
              'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png',
          name: 'Saliou Seck',
          quizCount: 10),
      Author(
          profileImageUrl:
              'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png',
          name: 'Moussa Fall',
          quizCount: 15),
      Author(
          profileImageUrl:
              'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png',
          name: 'Fatou Ndiaye',
          quizCount: 10),
      Author(
          profileImageUrl:
              'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_1280.png',
          name: 'Alioune Diop',
          quizCount: 15),
    ];
    // Simulate a network call
    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(
          authors: authors, filteredAuthors: authors, isLoading: false));
    });
  }

  void searchAuthor(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredAuthors: state.authors));
    } else {
      final filteredAuthors = state.authors
          .where((author) =>
              author.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(state.copyWith(filteredAuthors: filteredAuthors));
    }
  }
}
