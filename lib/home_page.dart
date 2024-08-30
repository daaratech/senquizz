import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senquizz/features/quiz/data/repository/quiz_repo.dart';
import 'package:senquizz/features/shared/ui/bussiness_logic/quizz_list/quizz_list_cubit.dart';
import 'package:senquizz/pages/author_detail.dart';
import 'package:senquizz/pages/authors_page.dart';
import 'package:senquizz/pages/quizz_list_page.dart';
import 'package:senquizz/widgets/category_card.dart';

import 'features/quiz/screens/clipped_topbar.dart';
import 'features/shared/ui/bussiness_logic/author/author_cubit.dart';
import 'features/shared/ui/bussiness_logic/category/category_cubit.dart';
import 'widgets/home_profile_widget.dart';
import 'widgets/quiz_card.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              QuizListCubit(context.read<QuizRepository>())..loadQuizzes(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit()..loadCategories(),
        ),
        BlocProvider(create: (context) => AuthorCubit()..loadAuthors()),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          body: Container(
            //padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // const HomeProfileWidget(),
                  const HomeProfileWidget(),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthorCubit, AuthorState>(
                    builder: (context, state) {
                      return SubSectionList(
                        title: "Top Authors",
                        height: MediaQuery.of(context).size.height * 0.15,
                        onViewAll: () {
                          Navigator.of(context).pushNamed(AuthorPage.routeName);
                        },
                        children: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.authors.length,
                          itemBuilder: (context, index) {
                            return AuthorItem(author: state.authors[index]);
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Categories",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: CategoryPager(
                              categories: state.categories,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<QuizListCubit, QuizListState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          ViewAllWidget(
                              title: "Most popular Quizzes",
                              onViewAll: () {
                                Navigator.of(context)
                                    .pushNamed(QuizListPage.routeName);
                              }),
                          ...state.quizzes.map((quiz) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: QuizCard(
                                uuid: quiz.uuid!,
                                categories: quiz.categories,
                                title: quiz.name,
                                description: quiz.description,
                                questionCount: quiz.numberOfQuestions,
                                points: quiz.numberOfQuestions,
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubSectionList extends StatelessWidget {
  final Function() onViewAll;
  final String title;
  final Widget children;
  final double height;
  const SubSectionList({
    super.key,
    required this.onViewAll,
    this.title = "Authors",
    required this.children,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAllWidget(title: title, onViewAll: onViewAll),
        SizedBox(
          height: height,
          child: children,
        ),
      ],
    );
  }
}

class ViewAllWidget extends StatelessWidget {
  const ViewAllWidget({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  final String title;
  final Function() onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(
          onPressed: onViewAll,
          child: const Row(
            children: [
              Text("View All"),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class AuthorItem extends StatelessWidget {
  const AuthorItem({
    super.key,
    required this.author,
  });

  final Author author;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          CircularAssetWidget(
            imageUrl: author.profileImageUrl,
            size: MediaQuery.of(context).size.height * 0.08,
          ),
          Text(
            author.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String name;
  final String level;
  final String? imageUrl;
  const ProfileWidget(
      {super.key, required this.name, required this.level, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularAssetWidget(
            imageUrl: imageUrl,
          ),
          const SizedBox(width: 10),
          Column(
            children: <Widget>[
              Text(name),
              OvalTextCard(
                  text: "Expert",
                  backGroundColor: Theme.of(context).colorScheme.primary),
            ],
          ),
          const Spacer(),
          const ScoreCard(score: 100),
        ],
      ),
    );
  }
}

class CircularAssetWidget extends StatelessWidget {
  final String? imageUrl;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;

  const CircularAssetWidget({
    super.key,
    this.imageUrl,
    this.icon,
    this.backgroundColor,
    this.iconColor,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: const CircleBorder(),
      elevation: 5,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary, width: 2),
        ),
        child: ClipOval(
          child: imageUrl == null
              ? Icon(
                  icon ?? Icons.person,
                  color: iconColor,
                  size: size * 0.7,
                  //s size: size,
                )
              : Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: size * 0.7,
                  height: size * 0.7,
                ),
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  final Color? backgroundColor;
  final int score;
  final double size;
  const ScoreCard({
    super.key,
    this.backgroundColor,
    required this.score,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          children: [
            CircularAssetWidget(
              icon: Icons.star_rate_sharp,
              backgroundColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.onPrimary,
              size: size,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text("$score"),
            ),
          ],
        ),
      ),
    );
  }
}

class OvalTextCard extends StatelessWidget {
  final String text;
  final Color backGroundColor;
  final Color textColor;

  const OvalTextCard({
    super.key,
    required this.text,
    required this.backGroundColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backGroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 10, color: textColor),
        ),
      ),
    );
  }
}

var sampleAuthor = [
  "Saliou",
  "Moussa",
  "Fallou",
  "Sokhna",
  "Ndeye Fatou Ndiaye",
  "Mamadou",
  "Mouhamed",
  "Moussa",
  "Fallou",
  "Sokhna",
  "Fatou",
  "Mamadou",
  "Mouhamed"
];

var sampleCollection = [
  "Education",
  "Science",
  "Technology",
  "Mathematics",
  "Physics",
  "Chemistry",
  "Games",
  "Music",
  "Art",
  "Sport",
  "Health",
];
