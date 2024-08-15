import 'package:flutter/material.dart';
import 'package:senquizz/home_page.dart';
import 'package:senquizz/pages/authors_page.dart';
import 'package:senquizz/pages/categories_page.dart';
import 'package:senquizz/pages/quizz_list_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomePage.routeName:
        return _materialRoute(
          view: const HomePage(),
          settings: settings,
        );

      case CategoryPage.routeName:
        return _materialRoute(
          view: const CategoryPage(),
          settings: settings,
        );

      case AuthorPage.routeName:
        return _materialRoute(
          view: const AuthorPage(),
          settings: settings,
        );

      case QuizPage.routeName:
        return _materialRoute(
          view: const QuizPage(),
          settings: settings,
        );

      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _materialRoute({
    required Widget view,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => view,
    );
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(child: Text("Error page")),
        );
      },
    );
  }
}
