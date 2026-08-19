import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';

/// Responsive page frame shared by new and progressively modernized screens.
class AppPage extends StatelessWidget {
  final Widget child;
  final bool safeArea;
  final bool scrollable;
  final EdgeInsetsGeometry? padding;
  final double maxWidth;

  const AppPage({
    super.key,
    required this.child,
    this.safeArea = true,
    this.scrollable = false,
    this.padding,
    this.maxWidth = AppDimensions.maxContentWidth,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth >= 700
            ? AppDimensions.tabletPagePadding
            : AppDimensions.pagePadding;
        Widget framed = Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding:
                  padding ??
                  EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: AppDimensions.space20,
                  ),
              child: child,
            ),
          ),
        );
        if (scrollable) framed = SingleChildScrollView(child: framed);
        return framed;
      },
    );
    if (safeArea) content = SafeArea(child: content);
    return content;
  }
}
