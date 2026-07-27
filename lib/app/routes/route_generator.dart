import 'package:flutter/material.dart';

import '../../features/auth/create_password/create_password_screen.dart';
import '../../features/auth/forgot_password/forgot_password_page.dart';
import '../../features/auth/activation/activation_screen.dart';
import '../../features/auth/login/login_page.dart';
import '../../features/auth/onboarding/onboarding_page.dart';
import '../../features/auth/splash/splash_page.dart';

import '../../features/dashboard/dashboard_page.dart';

import '../../features/news/news_detail_screen.dart';
import '../../features/news/news_page.dart';
import '../../features/events/events_page.dart';

import '../../features/academic/academic_screen.dart';
import '../../features/timetable/timetable_page.dart';
import '../../features/results/results_page.dart';
import '../../features/documents/documents_page.dart';

import '../../features/notifications/notifications_page.dart';

import '../../features/profile/profile_page.dart';
import '../../features/settings/settings_page.dart';

import '../../shared/navigation/navigation_screen.dart';

import 'route_names.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _page(const SplashPage());

      case RouteNames.onboarding:
        return _page(const OnboardingPage());

      case RouteNames.activation:
        return MaterialPageRoute(
          builder: (_) => const ActivationScreen(),
        );

      case RouteNames.login:
        return _page(const LoginPage());

      case RouteNames.createPassword:
        return MaterialPageRoute(
          builder: (_) => const CreatePasswordScreen(),
        );

      case RouteNames.forgotPassword:
        return _page(const ForgotPasswordPage());

      case RouteNames.dashboard:
        return _page(const DashboardPage());

      case RouteNames.news:
        return _page(const NewsPage());

      case RouteNames.newsDetail:
        return _page(
          const NewsDetailScreen(),
        );

      case RouteNames.events:
        return _page(const EventsPage());

      case RouteNames.academic:
        return MaterialPageRoute(
          builder: (_) => const AcademicScreen(),
          settings: settings,
        );

    case RouteNames.timetable:
        return _page(const TimetablePage());

      case RouteNames.results:
        return _page(const ResultsPage());

      case RouteNames.documents:
        return _page(const DocumentsPage());

      case RouteNames.notifications:
        return _page(const NotificationsPage());

      case RouteNames.profile:
        return _page(const ProfilePage());

      case RouteNames.settings:
        return _page(const SettingsPage());

      case RouteNames.navigation:
        return MaterialPageRoute(
          builder: (_) => const NavigationScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                '404\nPage introuvable',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _page(Widget page) {
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }
}