import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/nickname_input.dart';
import '../widgets/weight_picker.dart';
import '../widgets/goal_selector.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    final notifier = ref.read(onboardingProvider.notifier);
    final state = ref.read(onboardingProvider);

    switch (state.currentStep) {
      case 0:
        await notifier.setNickname(_nicknameController.text);
        break;
      case 1:
        notifier.setWeight(state.weightKg);
        break;
      case 2:
        await _completeOnboarding();
        break;
    }
  }

  Future<void> _completeOnboarding() async {
    final notifier = ref.read(onboardingProvider.notifier);
    try {
      await notifier.completeOnboarding();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필 저장에 실패했어요: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    return Scaffold(
      appBar: AppBar(
        leading: state.currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () =>
                    ref.read(onboardingProvider.notifier).goBack(),
              )
            : null,
        title: _StepIndicator(currentStep: state.currentStep),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: _buildStepContent(state),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : _handleNext,
                  child: state.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(state.currentStep == 2 ? '시작하기' : '다음'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(OnboardingState state) {
    return switch (state.currentStep) {
      0 => NicknameInput(
          controller: _nicknameController,
          errorText: state.error,
          isLoading: state.isLoading,
        ),
      1 => WeightPicker(
          value: state.weightKg,
          onChanged: (v) {
            ref.read(onboardingProvider.notifier).setWeight(v);
          },
        ),
      2 => GoalSelector(
          value: state.goal,
          onChanged: (v) {
            ref.read(onboardingProvider.notifier).setGoal(v);
          },
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;

  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive || isCompleted
                ? Theme.of(context).primaryColor
                : Colors.grey[300],
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      }),
    );
  }
}
