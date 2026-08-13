import 'package:flutter/material.dart';

import 'widgets/academic_header.dart';
import 'widgets/academic_info.dart';
import 'widgets/academic_menu.dart';
import 'widgets/semester_summary.dart';

class AcademicPage extends StatelessWidget {
  const AcademicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              AcademicHeader(),

              SizedBox(height: 20),

              AcademicInfo(),

              SizedBox(height: 20),

              AcademicMenu(),

              SizedBox(height: 20),

              SemesterSummary(),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
