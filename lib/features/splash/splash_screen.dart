import 'package:flutter/material.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/data_source/local_data/prefrence_manager.dart';
import 'package:news_app/features/Navigation/main_screen.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onbaording/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigtionAfterSplash();
  }

  void _navigtionAfterSplash() async {
    await Future.delayed(Duration(seconds: 5));
    final bool isOnboardingComplete =
        PrefrenceManager().getBool(Constants.isOnboardingComplete) ?? false;
    final bool isLogin = PrefrenceManager().getBool(Constants.isLogedIn) ?? false;
    if (!mounted) return;
    if (!isOnboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return OnboardingScreen();
          },
        ),
      );
    } else if (!isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset('assets/images/splash.png', width: double.infinity),
    );
  }
}
