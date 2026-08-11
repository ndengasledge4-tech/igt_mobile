import 'package:flutter/material.dart';
import 'routes/route_generator.dart';
import 'routes/route_names.dart';
import 'theme/app_theme.dart';

class IgtApp extends StatelessWidget {
  const IgtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IGT Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Démarrage direct sur la navigation pour éviter les crashs de redirection
      initialRoute: RouteNames.navigation,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
