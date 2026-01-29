import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/auth_provider.dart';
import '../providers/auth_providers.dart';
import '../widgets/social_login_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  AuthProvider? _loadingProvider;

  Future<void> _signIn(AuthProvider provider) async {
    setState(() => _loadingProvider = provider);

    try {
      await ref.read(authStateNotifierProvider.notifier).signIn(provider);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_getErrorMessage(e))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loadingProvider = null);
      }
    }
  }

  String _getErrorMessage(Object error) {
    return '로그인에 실패했어요. 다시 시도해주세요.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo and title
              Icon(
                Icons.directions_run,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'RunningMate',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '나에게 맞는 러닝 코스를 찾아보세요',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),

              const Spacer(flex: 2),

              // Social login buttons
              SocialLoginButton(
                provider: AuthProvider.google,
                onPressed: () => _signIn(AuthProvider.google),
                isLoading: _loadingProvider == AuthProvider.google,
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                provider: AuthProvider.apple,
                onPressed: () => _signIn(AuthProvider.apple),
                isLoading: _loadingProvider == AuthProvider.apple,
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                provider: AuthProvider.kakao,
                onPressed: () => _signIn(AuthProvider.kakao),
                isLoading: _loadingProvider == AuthProvider.kakao,
              ),

              const Spacer(),

              // Terms and privacy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('이용약관'),
                  ),
                  Text(
                    ' | ',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('개인정보처리방침'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
