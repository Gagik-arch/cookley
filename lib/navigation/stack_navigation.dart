import 'package:flutter/material.dart';
import '../screens/main.dart';
import 'tab_navigation.dart';

Map<String, Widget Function(BuildContext)> stackNavigation = {
  // '/': (context) => ProfileInfoScreen(),
  '/': (context) => const SelectLanguageScreen(),
  '/welcome': (context) => const WelcomeScreen(),
  '/signin': (context) => const SigninScreen(),
  '/signup': (context) => const SignupScreen(),
  '/otp': (context) {
    return OTPScreen(verificationId: '', mobileNumber: null);
  },
  '/profile-info': (context) => ProfileInfoScreen(mobileNumber: null),
  '/time-of-cooking': (context) => const TimeOfCooking(),
  '/profile': (context) => const TabNavigation(),
  '/settings': (context) => const SettingsScreen(),
  '/meal': (context) => const MealScreen(),
  '/planning': (context) => const MealPlanScreen(),
  '/support': (context) => const SupportScreen(),
};
