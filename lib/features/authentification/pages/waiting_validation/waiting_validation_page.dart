import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';

import '../../widgets/waiting_validation/waiting_validation_icon.dart';
import '../../widgets/waiting_validation/waiting_validation_title.dart';
import '../../widgets/waiting_validation/waiting_validation_description.dart';
import '../../widgets/waiting_validation/waiting_validation_button.dart';


class WaitingValidationPage extends StatelessWidget {
  const WaitingValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                WaitingValidationIcon(),

                SizedBox(height: 35),

                WaitingValidationTitle(),

                SizedBox(height: 18),

                WaitingValidationDescription(),

                SizedBox(height: 40),

                WaitingValidationButton(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}