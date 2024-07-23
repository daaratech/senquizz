import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final List<String> categories;
  final String title;
  final String description;
  final int questionCount;
  final int points;

  const QuizCard({
    super.key,
    required this.categories,
    required this.title,
    required this.description,
    required this.questionCount,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return RoundedLabel(category: categories[index]);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Description
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    LabelWithValueWidget(
                      questionCount: questionCount,
                      label: "Questions",
                    ),
                    const SizedBox(width: 10),
                    LabelWithValueWidget(
                      questionCount: points,
                      label: "Points",
                    ),
                  ],
                ),
              ),
              ClickableRoundedLabel(
                label: 'Commencer',
                onTap: () {
                  // Handle onTap action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LabelWithValueWidget extends StatelessWidget {
  const LabelWithValueWidget({
    super.key,
    required this.questionCount,
    required this.label,
  });

  final int questionCount;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularNumberWidget(number: questionCount),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class RoundedLabel extends StatelessWidget {
  const RoundedLabel({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Text(category),
      ),
    );
  }
}

class CircularNumberWidget extends StatelessWidget {
  final int number;

  const CircularNumberWidget({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // width: 50,
        //height: 50,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ClickableRoundedLabel extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ClickableRoundedLabel({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
