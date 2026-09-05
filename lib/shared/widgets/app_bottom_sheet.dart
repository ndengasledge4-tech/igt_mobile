import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';

class AppBottomSheet extends StatelessWidget {
  final String? title;
  final Widget child;

  const AppBottomSheet({super.key, this.title, required this.child});

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      builder: (_) => AppBottomSheet(title: title, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.space20,
        0,
        AppDimensions.space20,
        MediaQuery.viewInsetsOf(context).bottom + AppDimensions.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppDimensions.space16),
          ],
          child,
        ],
      ),
    );
  }
}
