import 'package:flutter/material.dart';
import 'package:senquizz/Theme/theme.dart';
import 'package:senquizz/app_route.dart';

import 'home_page.dart';

void main() {
  runApp(const SenQuizz());
}

class SenQuizz extends StatelessWidget {
  const SenQuizz({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: MaterialTheme.lightScheme(),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      initialRoute: HomePage.routeName,
      //home: const HomePage(),
    );
  }
}
