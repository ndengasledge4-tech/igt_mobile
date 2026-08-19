import 'package:flutter/material.dart';

import '../../mock/mock_results.dart';
import 'widgets/results_header.dart';
import 'widgets/subject_card.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ResultsHeader(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    "DÉTAIL PAR MATIÈRE",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 18),
                  for (final result in MockResultsData.items) ...[
                    SubjectCard(
                      subject: result.subject,
                      teacher: result.teacher,
                      code: result.code,
                      grade: result.grade,
                      credits: result.credits,
                    ),
                    const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
