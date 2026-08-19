import 'package:flutter/material.dart';

import 'widgets/daily_timetable.dart';
import 'widgets/day_selector.dart';
import 'widgets/timetable_header.dart';
import 'widgets/weekly_timetable.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  bool isDaily = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TimetableHeader(
              isDaily: isDaily,
              onChanged: (value) {
                setState(() {
                  isDaily = value;
                });
              },
            ),

            const SizedBox(height: 16),

            const DaySelector(),

            const SizedBox(height: 20),

            Expanded(
              child: isDaily ? const DailyTimetable() : const WeeklyTimetable(),
            ),
          ],
        ),
      ),
    );
  }
}
