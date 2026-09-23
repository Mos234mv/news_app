import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/data_source/local_data/prefrence_manager.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onbaording/cubit/on_boarding_cubit.dart';

import 'package:news_app/features/onbaording/models/onboarding_model.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final PageController pageController = PageController();
  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> onFinishOnboarding(BuildContext context) async {
    await PrefrenceManager().setBool(Constants.isOnboardingComplete, true);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OnBoardingCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFF5F5F5),
              actions: [
                BlocBuilder<OnBoardingCubit, OnBoardingState>(
                  builder: (BuildContext context, state) {
                    return state.isLastPage
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              onFinishOnboarding(context);
                            },
                            child: Text(
                              'skip',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          );
                  },
                ),
              ],
            ),

            body: SafeArea(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  context.read<OnBoardingCubit>().onPageChanged(index);
                },
                itemCount: OnboardingModel.onboardingList.length,
                itemBuilder: (BuildContext context, int index) {
                  final OnboardingModel model = OnboardingModel.onboardingList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.ph30,
                      horizontal: AppSizes.pw16,
                    ),
                    child: Column(
                      children: [
                        Image.asset(model.path, width: AppSizes.w325),
                        SizedBox(height: AppSizes.ph24),
                        Text(
                          model.title,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(height: AppSizes.ph12),
                        Text(
                          model.description,
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSizes.ph24),
                        SmoothPageIndicator(
                          controller: pageController, // PageController
                          count: OnboardingModel.onboardingList.length,
                          effect: const WormEffect(
                            dotColor: Color(0xffD3D3D3),
                            activeDotColor: Color(0xFFC53030),
                          ), // your preferred effect
                          onDotClicked: (index) {
                            nextPage();
                          },
                        ),

                        const Spacer(),
                        BlocBuilder<OnBoardingCubit, OnBoardingState>(
                          builder: (BuildContext context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width,
                                  AppSizes.h48,
                                ),
                              ),
                              onPressed: () {
                                if (!state.isLastPage) {
                                  nextPage();
                                } else {
                                  onFinishOnboarding(context);
                                }
                              },

                              child: Text(state.isLastPage ? 'Get Started' : 'Next'),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
