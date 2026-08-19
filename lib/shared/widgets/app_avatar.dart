<<<<<<< HEAD
import 'package:flutter/material.dart';

import '../../app/theme/dimensions.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final ImageProvider<Object>? image;
  final double size;
  final VoidCallback? onTap;

  const AppAvatar({
    super.key,
    required this.name,
    this.image,
    this.size = AppDimensions.avatarMedium,
    this.onTap,
  });

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    final first = parts.first.substring(0, 1);
    final last = parts.length > 1 ? parts.last.substring(0, 1) : '';
    return '$first$last'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: scheme.primaryContainer,
      foregroundImage: image,
      child: image == null
          ? Text(
              _initials,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: scheme.onPrimaryContainer,
              ),
            )
          : null,
    );
    if (onTap == null) return avatar;
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: avatar,
    );
  }
}
=======

>>>>>>> d061dc8b8ab474bae980863b8eb021f35012ec93
