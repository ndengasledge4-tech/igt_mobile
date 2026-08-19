import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;

<<<<<<< HEAD
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimensions.space16),
    this.onTap,
    this.color,
  });
=======
  const AppCard({super.key, required this.child, this.padding, this.onTap});
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93

  @override
  Widget build(BuildContext context) {
    final shape = Theme.of(context).cardTheme.shape;
    return Card(
<<<<<<< HEAD
      color: color,
      clipBehavior: Clip.antiAlias,
=======
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
