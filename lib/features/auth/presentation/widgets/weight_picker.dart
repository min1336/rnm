import 'package:flutter/material.dart';

class WeightPicker extends StatelessWidget {
  final double? value;
  final ValueChanged<double?> onChanged;

  const WeightPicker({
    super.key,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '체중을 알려주세요',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '칼로리 계산에 사용돼요 (나중에 설정해도 돼요)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 32),
        Center(
          child: Column(
            children: [
              Text(
                value != null ? '${value!.toStringAsFixed(1)} kg' : '-- kg',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              Slider(
                value: value ?? 60,
                min: 30,
                max: 200,
                divisions: 170,
                label: value?.toStringAsFixed(1),
                onChanged: (v) => onChanged(v),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => onChanged(null),
                child: const Text('건너뛰기'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
