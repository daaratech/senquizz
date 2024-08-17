import 'package:flutter/material.dart';
import 'package:senquizz/features/quiz/models/quiz.dart';
import 'package:senquizz/features/quiz/screens/quiz_form_screen.dart';
import 'package:senquizz/home_page.dart';
import 'package:senquizz/pages/authors_page.dart';
import 'package:senquizz/pages/categories_page.dart';
import 'package:senquizz/pages/quizz_list_page.dart';

import 'features/quiz/screens/game_screen.dart';
import 'features/quiz/screens/quiz_summary_screen.dart';

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

      case QuizListPage.routeName:
        return _materialRoute(
          view: const QuizListPage(),
          settings: settings,
        );

      case QuizSummaryScreen.routeName:
        return _materialRoute(
          view: QuizSummaryScreen(quiz: args as Quiz),
          settings: settings,
        );

      case GameScreen.routeName:
        if (args is Map<String, dynamic>) {
          return _materialRoute(
            view: GameScreen(uuid: args[GameScreen.uuidArgs] as String),
            settings: settings,
          );
        } else {
          return _errorRoute(settings);
        }

      case QuizFormScreen.routeName:
        return _materialRoute(
          view: QuizFormScreen(),
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
