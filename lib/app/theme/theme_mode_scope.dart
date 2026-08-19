import 'package:flutter/material.dart';

class AppThemeModeNotifier extends ValueNotifier<ThemeMode> {
  AppThemeModeNotifier([super.value = ThemeMode.system]);
}

class AppThemeModeScope extends InheritedNotifier<AppThemeModeNotifier> {
  const AppThemeModeScope({
    super.key,
    required AppThemeModeNotifier notifier,
    required super.child,
  }) : super(notifier: notifier);

  static AppThemeModeNotifier of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppThemeModeScope>();
    assert(scope != null, 'No AppThemeModeScope found in context.');
    return scope!.notifier!;
  }
}
