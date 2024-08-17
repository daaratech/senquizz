import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'quiz_form_screen.dart';

class QuizResultPage extends StatelessWidget {
  static const routeName = '/quiz-result';
  final int totalQuestions;
  final int correctAnswers;
  final int unansweredQuestions;
  final int points;

  const QuizResultPage({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.unansweredQuestions,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    int percentage = ((points / (totalQuestions * 10)) * 100).toInt();
    bool isPassed = percentage >= 50;
    String message = isPassed
        ? 'Congratulations! Great job!'
        : 'Keep trying! You can do it!';
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Quiz Result'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CardSection(
                isPassed: isPassed, percentage: percentage, message: message),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  boxShadow,
                ],
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: _buildSummaryItem(
                            'Total Questions', "$totalQuestions questions")),
                    Expanded(
                        child: _buildSummaryItem(
                            'Correct Answers', correctAnswers.toString())),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: _buildSummaryItem('Incorrect Answers',
                            unansweredQuestions.toString())),
                    Expanded(
                        child: _buildSummaryItem('Points', points.toString())),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Finish'),
            ),
          )
        ]
            .animate(interval: 300.ms)
            .fadeIn(duration: 500.ms)
            .move(begin: const Offset(0, 30), curve: Curves.easeOut),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CardSection extends StatelessWidget {
  const CardSection({
    super.key,
    required this.isPassed,
    required this.percentage,
    required this.message,
  });

  final bool isPassed;
  final int percentage;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: isPassed ? Colors.green[100] : Colors.red[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Your Score Percentage',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                          isPassed ? Colors.green : Colors.red),
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isPassed ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isPassed ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
