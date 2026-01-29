// lib/app/routes.dart
import 'package:go_router/go_router.dart';
import '../features/auth/domain/entities/auth_state.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/course/presentation/screens/course_detail_screen.dart';
import '../features/course/presentation/screens/course_list_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

GoRouter createRouter(AuthState authState) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState == AuthState.authenticated;
      final isOnboarding = authState == AuthState.needsOnboarding;
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboardingRoute = state.matchedLocation == '/onboarding';

      // Not authenticated -> login
      if (!isLoggedIn && !isOnboarding && !isLoggingIn) {
        return '/login';
      }

      // Needs onboarding -> onboarding
      if (isOnboarding && !isOnboardingRoute) {
        return '/onboarding';
      }

      // Authenticated but on login/onboarding -> home
      if (isLoggedIn && (isLoggingIn || isOnboardingRoute)) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/course/:id',
        name: 'courseDetail',
        builder: (context, state) {
          final courseId = state.pathParameters['id']!;
          return CourseDetailScreen(courseId: courseId);
        },
      ),
    ],
  );
}
