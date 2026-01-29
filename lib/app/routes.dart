import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/course/presentation/screens/course_list_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

/// App routes configuration using go_router
class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String onboarding = '/onboarding';
  static const String courses = '/courses';
  static const String courseDetail = '/courses/:id';
  static const String tracking = '/tracking';
  static const String runSummary = '/run-summary';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String runHistory = '/run-history';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: courses,
        name: 'courses',
        builder: (context, state) => const CourseListScreen(),
      ),
      // TODO: Add more routes as screens are implemented
      // GoRoute(
      //   path: login,
      //   name: 'login',
      //   builder: (context, state) => const LoginScreen(),
      // ),
      // GoRoute(
      //   path: courseDetail,
      //   name: 'courseDetail',
      //   builder: (context, state) {
      //     final courseId = state.pathParameters['id']!;
      //     return CourseDetailScreen(courseId: courseId);
      //   },
      // ),
      // GoRoute(
      //   path: tracking,
      //   name: 'tracking',
      //   builder: (context, state) => const TrackingScreen(),
      // ),
      // GoRoute(
      //   path: profile,
      //   name: 'profile',
      //   builder: (context, state) => const ProfileScreen(),
      // ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
