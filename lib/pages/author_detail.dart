import 'package:flutter/material.dart';

import '../home_page.dart';

class AuthorDetailsPage extends StatelessWidget {
  final Author author;

  const AuthorDetailsPage({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(author.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(author.profileImageUrl),
            //   radius: 50,
            // ),
            const CircularAssetWidget(),
            const SizedBox(height: 16),
            Text(
              author.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('${author.quizCount} quizzes'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

class Author {
  final String profileImageUrl;
  final String name;
  final int quizCount;

  Author({
    required this.profileImageUrl,
    required this.name,
    required this.quizCount,
  });
}
