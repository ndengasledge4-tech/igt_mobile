import 'package:flutter/material.dart';

import 'routes/route_generator.dart';
import 'routes/route_names.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_scope.dart';

class IgtApp extends StatefulWidget {
  final AppThemeModeNotifier? themeModeNotifier;
  final String initialRoute;

  const IgtApp({
    super.key,
    this.themeModeNotifier,
    this.initialRoute = RouteNames.splash,
  });

  @override
  State<IgtApp> createState() => _IgtAppState();
}

class _IgtAppState extends State<IgtApp> {
  late final AppThemeModeNotifier _themeModeNotifier;
  late final bool _ownsNotifier;

  @override
  void initState() {
    super.initState();
    _ownsNotifier = widget.themeModeNotifier == null;
    _themeModeNotifier =
        widget.themeModeNotifier ?? AppThemeModeNotifier(ThemeMode.system);
  }

  @override
  void dispose() {
    if (_ownsNotifier) _themeModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeModeScope(
      notifier: _themeModeNotifier,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeModeNotifier,
        builder: (context, themeMode, child) {
          return MaterialApp(
            title: 'IGT Campus',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: widget.initialRoute,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
