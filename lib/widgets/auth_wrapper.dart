import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/controllers/auth_controller.dart';
import 'package:ielts/screens/main_dashboard_screen.dart';
import 'package:ielts/screens/onboarding_screen.dart';
import 'package:ielts/screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(() {
      if (authController.user.value != null) {
        return const MainDashboardScreen();
      } else if (authController.isOnboardingCompleted.value) {
        return const LoginScreen();
      } else {
        return const OnboardingScreen();
      }
    });
  }
}
