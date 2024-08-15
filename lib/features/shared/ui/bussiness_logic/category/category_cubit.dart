import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryState extends Equatable {
  final List<String> categories;
  final List<String> filteredCategories;
  final bool isLoading;
  final String error;

  const CategoryState(
      {required this.categories,
      required this.filteredCategories,
      this.isLoading = false,
      this.error = ''});

  CategoryState copyWith({
    List<String>? categories,
    List<String>? filteredCategories,
    bool? isLoading,
    String? error,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      filteredCategories: filteredCategories ?? this.filteredCategories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [categories, isLoading, error, filteredCategories];
}

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(const CategoryState(categories: [], filteredCategories: []));

  void loadCategories() {
    emit(state.copyWith(isLoading: true));
    // Simulate a network call
    final categories = ['Science', 'Math', 'History', 'Geography'];
    Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(
          filteredCategories: categories,
          categories: categories,
          isLoading: false));
    });
  }

  void searchCategory(String query) {
    if (query.isEmpty) {
      // Reload the original list of categories
      emit(state.copyWith(filteredCategories: state.categories));
    } else {
      final filteredCategories = state.categories
          .where((category) =>
              category.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(state.copyWith(filteredCategories: filteredCategories));
    }
  }
}
