import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubit/game_cubit/game_cubit.dart';

class GameWidget extends StatelessWidget {
  final GameState state;
  final Function(int) onAnswer;
  final Function() onGoToNextQuestion;
  const GameWidget({
    super.key,
    required this.state,
    required this.onAnswer,
    required this.onGoToNextQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        middle: Text(
            '${state.currentQuestionIndex + 1}/${state.quiz.questions.length}'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 8,
            ),
            QuestionCard(state: state),
            PossibleResponseSection(state: state, onAnswer: onAnswer),
            const Spacer(),
            if (state.status != GameStatus.questionLoaded)
              StatusCard(
                  isSuccess:
                      state.status == GameStatus.questionAnsweredCorrectly,
                  onNextQuestion: onGoToNextQuestion),
          ],
        ),
      ),
    );
  }
}

class PossibleResponseSection extends StatelessWidget {
  const PossibleResponseSection({
    super.key,
    required this.state,
    required this.onAnswer,
  });

  final GameState state;
  final Function(int p1) onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: state.question.answers.asMap().entries.map((entry) {
        final index = entry.key;
        final answer = entry.value;
        final position = String.fromCharCode(65 + index + 1);
        return state.status == GameStatus.questionLoaded
            ? PossibleResponseCardWidget(
                statusColor: Colors.white,
                isSelected: false,
                text: answer,
                onTap: () => onAnswer(index),
                position: position,
              )
            : PossibleResponseCardWidget(
                statusColor: index == state.question.indexOfRightAnswer
                    ? Colors.green
                    : (state.selectedAnswers[state.currentQuestionIndex] ==
                            index
                        ? Colors.red
                        : Colors.white),
                isSelected: index == state.question.indexOfRightAnswer,
                text: answer,
                onTap: () {},
                position: position,
              );
      }).toList(),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.state,
  });

  final GameState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0.0, 10.0),
                blurRadius: 20.0,
                spreadRadius: -5.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              state.question.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          top: -35,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: CircularCounter(
            maxValue: state.quiz.duration.toDouble(),
            value: state.timeLeft.toDouble(),
          ),
        ),
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  final bool isSuccess;
  final VoidCallback onNextQuestion;

  const StatusCard(
      {super.key, required this.isSuccess, required this.onNextQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSuccess ? Colors.green[100] : Colors.red[100],

      //  margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isSuccess ? Icons.check_circle : Icons.error,
                      color: isSuccess ? Colors.green : Colors.red,
                      size: 30,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      isSuccess ? 'Correct!' : 'Incorrect!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSuccess ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.assistant_photo_outlined,
                  color: isSuccess ? Colors.green : Colors.red,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: isSuccess ? Colors.green : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: onNextQuestion,
                child: const Text('Next Question',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PossibleResponseCardWidget extends StatelessWidget {
  final Color statusColor;
  final bool isSelected;
  final String text;
  final Function() onTap;
  final String position;
  const PossibleResponseCardWidget({
    super.key,
    required this.statusColor,
    required this.isSelected,
    required this.text,
    required this.onTap,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor != Colors.white
                ? statusColor.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: statusColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  position,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                  child: Text(
                text,
                textAlign: TextAlign.center,
              )),
              Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    onTap();
                  },
                  activeColor: statusColor,
                  shape: const CircleBorder()),
            ],
          )),
    );
  }
}

class CircularCounter extends StatelessWidget {
  final double value;
  final double maxValue;
  final double size; // Add a size parameter

  const CircularCounter({
    super.key,
    required this.value,
    required this.maxValue,
    this.size = 100.0, // Default size is 100
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, // Use the size parameter
      height: size, // Use the size parameter
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value / maxValue,
            strokeWidth: 5,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          Center(
            child: Text(
              '${value.toInt()}',
              style: TextStyle(
                fontSize:
                    size * 0.2, // Adjust font size based on the size parameter
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
