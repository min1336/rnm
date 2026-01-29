import 'package:flutter/material.dart';
import '../../domain/entities/auth_provider.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
  });

  final AuthProvider provider;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(),
          foregroundColor: _getForegroundColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: _getBorderSide(),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getForegroundColor(),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(),
                  const SizedBox(width: 12),
                  Text(
                    _getButtonText(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (provider) {
      case AuthProvider.google:
        return Colors.white;
      case AuthProvider.apple:
        return Colors.black;
      case AuthProvider.kakao:
        return const Color(0xFFFEE500);
    }
  }

  Color _getForegroundColor() {
    switch (provider) {
      case AuthProvider.google:
        return Colors.black87;
      case AuthProvider.apple:
        return Colors.white;
      case AuthProvider.kakao:
        return Colors.black87;
    }
  }

  BorderSide _getBorderSide() {
    switch (provider) {
      case AuthProvider.google:
        return BorderSide(color: Colors.grey[300]!);
      case AuthProvider.apple:
      case AuthProvider.kakao:
        return BorderSide.none;
    }
  }

  Widget _buildIcon() {
    switch (provider) {
      case AuthProvider.google:
        return Image.asset(
          'assets/icons/google_logo.png',
          width: 24,
          height: 24,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.g_mobiledata, size: 24);
          },
        );
      case AuthProvider.apple:
        return const Icon(Icons.apple, size: 24);
      case AuthProvider.kakao:
        return Image.asset(
          'assets/icons/kakao_logo.png',
          width: 24,
          height: 24,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.chat_bubble, size: 24);
          },
        );
    }
  }

  String _getButtonText() {
    switch (provider) {
      case AuthProvider.google:
        return 'Google로 계속하기';
      case AuthProvider.apple:
        return 'Apple로 계속하기';
      case AuthProvider.kakao:
        return '카카오로 계속하기';
    }
  }
}
