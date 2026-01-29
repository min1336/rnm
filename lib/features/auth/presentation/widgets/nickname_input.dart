import 'package:flutter/material.dart';

class NicknameInput extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool isLoading;
  final ValueChanged<String>? onChanged;

  const NicknameInput({
    super.key,
    required this.controller,
    this.errorText,
    this.isLoading = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '닉네임을 알려주세요',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '2-10자의 한글, 영문, 숫자만 사용할 수 있어요',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controller,
          enabled: !isLoading,
          decoration: InputDecoration(
            hintText: '닉네임 입력',
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: isLoading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
          ),
          onChanged: onChanged,
          maxLength: 10,
        ),
      ],
    );
  }
}
