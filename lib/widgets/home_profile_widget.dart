import 'package:flutter/material.dart';

import '../features/quiz/screens/clipped_topbar.dart';
import '../home_page.dart';
import 'quiz_card.dart';

class HomeProfileWidget extends StatelessWidget {
  const HomeProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.27,
          child: ClipShapeBackground(
            height: MediaQuery.of(context).size.height * 0.27,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              //  color: Theme.of(context).colorScheme.primary,
              //borderRadius: BorderRadius.circular(16),
              ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back! 🖐🏼",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Saliou Seck",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  const CircularAssetWidget(
                    size: 50,
                  )
                ],
              ),
              const Row(
                children: [
                  RoundedLabel(category: "Expert"),
                  ScoreCard(
                    score: 100,
                    size: 30,
                  ),
                  CircularAssetWidget(
                    icon: Icons.settings,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
