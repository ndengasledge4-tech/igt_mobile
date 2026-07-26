import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  const DaySelector({super.key});

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  int selectedIndex = 0;

  final List<String> days = [
    "Lun",
    "Mar",
    "Mer",
    "Jeu",
    "Ven",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          days.length,
              (index) {
            final selected = index == selectedIndex;

            return Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      days[index],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: selected
                            ? const Color(0xFF2F6DB5)
                            : Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 10),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      width: selected ? 26 : 0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F6DB5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}