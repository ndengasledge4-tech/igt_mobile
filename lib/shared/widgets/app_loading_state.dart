import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';

class AppLoadingState extends StatelessWidget {
  final String label;

  const AppLoadingState({super.key, this.label = 'Chargement en cours'});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      liveRegion: true,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppDimensions.space16),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
