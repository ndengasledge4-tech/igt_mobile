import 'package:flutter/material.dart';

import 'routes/route_generator.dart';
import 'routes/route_names.dart';
import 'theme/app_theme.dart';

class IgtApp extends StatelessWidget {
  const IgtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IGT Campus',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: RouteNames.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}