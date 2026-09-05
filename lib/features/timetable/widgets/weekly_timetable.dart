import 'package:flutter/material.dart';

class WeeklyTimetable extends StatelessWidget {
  const WeeklyTimetable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Table(
          border: TableBorder.all(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          defaultColumnWidth: const FixedColumnWidth(120),
          children: [
            _buildHeader(),

            _buildRow("08:00", const [
              _CourseCell(title: "Algo", color: Color(0xFF2563EB)),
              _CourseCell(),
              _CourseCell(title: "BD", color: Color(0xFFF59E0B)),
              _CourseCell(),
              _CourseCell(title: "Projet", color: Color(0xFF8B5CF6)),
            ]),

            _buildRow("10:00", const [
              _CourseCell(title: "Math", color: Color(0xFF16A34A)),
              _CourseCell(title: "Réseaux", color: Color(0xFFEF4444)),
              _CourseCell(),
              _CourseCell(title: "Java", color: Color(0xFF0EA5E9)),
              _CourseCell(),
            ]),

            _buildRow("14:00", const [
              _CourseCell(),
              _CourseCell(title: "UML", color: Color(0xFFF97316)),
              _CourseCell(title: "Web", color: Color(0xFF06B6D4)),
              _CourseCell(),
              _CourseCell(title: "IA", color: Color(0xFF22C55E)),
            ]),

            _buildRow("16:00", const [
              _CourseCell(),
              _CourseCell(),
              _CourseCell(title: "Mobile", color: Color(0xFF7C3AED)),
              _CourseCell(title: "Cloud", color: Color(0xFF3B82F6)),
              _CourseCell(),
            ]),
          ],
        ),
      ),
    );
  }

  TableRow _buildHeader() {
    return const TableRow(
      decoration: BoxDecoration(color: Color(0xFFF3F4F6)),
      children: [
        _HeaderCell("Heure"),
        _HeaderCell("Lun"),
        _HeaderCell("Mar"),
        _HeaderCell("Mer"),
        _HeaderCell("Jeu"),
        _HeaderCell("Ven"),
      ],
    );
  }

  TableRow _buildRow(String hour, List<Widget> cells) {
    return TableRow(children: [_HourCell(hour), ...cells]);
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;

  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class _HourCell extends StatelessWidget {
  final String hour;

  const _HourCell(this.hour);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      child: Text(
        hour,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}

class _CourseCell extends StatelessWidget {
  final String? title;
  final Color? color;

  const _CourseCell({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return const SizedBox(height: 80);
    }

    return Container(
      height: 80,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        title!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
