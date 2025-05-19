// lib/controllers/onboarding_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../views/auth/login_screen.dart';

class OnboardingController extends GetxController {
  final box = GetStorage();
  final currentPage = 0.obs;
  final pageController = PageController();

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome to B-Medix',
      description: 'Your Personal Health Assistant',
      icon: Icons.health_and_safety_outlined,
    ),
    OnboardingItem(
      title: 'Consult doctors easily',
      description: 'Consult with a specialist doctor, anytime and anywhere easily',
      icon: Icons.question_answer_outlined,
    ),
    OnboardingItem(
      title: 'Read, Learn, Grow',
      description: 'Read anytime, anywhere, and trusted by experts in their fields',
      icon: Icons.article_outlined,
    ),
    OnboardingItem(
      title: 'Your Medicine, Ready',
      description: 'All medications are available and prescribed by professionals.',
      icon: Icons.medication_outlined,
    ),
  ];

  void nextPage() {
    if (currentPage.value < onboardingItems.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void completeOnboarding() {
    box.write('hasSeenOnboarding', true);
    Get.offAll(
      () => LoginScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 700),
    );
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}