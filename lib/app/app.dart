// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/domain/entities/auth_state.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import 'routes.dart';

class RunningMateApp extends ConsumerStatefulWidget {
  const RunningMateApp({super.key});

  @override
  ConsumerState<RunningMateApp> createState() => _RunningMateAppState();
}

class _RunningMateAppState extends ConsumerState<RunningMateApp> {
  @override
  void initState() {
    super.initState();
    // Check auth state on app start
    Future.microtask(() {
      ref.read(authStateNotifierProvider.notifier).checkAuthState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

    // Show loading while checking auth
    if (authState == AuthState.initial) {
      return MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp.router(
      title: 'RunningMate',
      theme: AppTheme.light,
      routerConfig: createRouter(authState),
    );
  }
}
