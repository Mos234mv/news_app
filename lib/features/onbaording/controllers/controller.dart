import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/local_data/prefrence_manager.dart';
import 'package:news_app/features/auth/login_screen.dart';

class OnboardingProvider with ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;
  bool isLastPage = false;
  void onPageChanged(int index) {
    currentIndex = index;
    if (index == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    notifyListeners();
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  Future<void> onFinishOnboarding(BuildContext context) async {
    await PrefrenceManager().setBool("onboarding_compelete", true);
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }
}
