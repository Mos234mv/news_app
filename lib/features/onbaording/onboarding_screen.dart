import 'package:flutter/material.dart';
import 'package:news_app/features/onbaording/controllers/controller.dart';
import 'package:news_app/features/onbaording/models/onboarding_model.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingProvider>(
      builder: (context, _) {
        final controller = context.read<OnboardingProvider>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFF5F5F5),
            actions: [
              Consumer<OnboardingProvider>(
                builder:
                    (
                      BuildContext context,
                      OnboardingProvider value,
                      Widget? child,
                    ) {
                      return value.isLastPage
                          ? SizedBox()
                          : TextButton(
                              onPressed: () {
                                OnboardingProvider().onFinishOnboarding(
                                  context,
                                );
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
              controller: controller.pageController,
              onPageChanged: (index) {
                Provider.of<OnboardingProvider>(
                  context,
                  listen: false,
                ).onPageChanged(index);
              },
              itemCount: OnboardingModel.onboardingList.length,
              itemBuilder: (BuildContext context, int index) {
                final OnboardingModel model =
                    OnboardingModel.onboardingList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Image.asset(model.path, width: 325),
                      SizedBox(height: 24),
                      Text(
                        model.title,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox(height: 12),
                      Text(
                        model.description,
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      SmoothPageIndicator(
                        controller: controller.pageController, // PageController
                        count: OnboardingModel.onboardingList.length,
                        effect: WormEffect(
                          dotColor: Color(0xffD3D3D3),
                          activeDotColor: Color(0xFFC53030),
                        ), // your preferred effect
                        onDotClicked: (index) {
                          controller.nextPage();
                        },
                      ),

                      Spacer(),
                      Consumer<OnboardingProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width,
                                48,
                              ),
                            ),
                            onPressed: () {
                              if (!value.isLastPage) {
                                controller.nextPage();
                              } else {
                                OnboardingProvider().onFinishOnboarding(
                                  context,
                                );
                              }
                            },

                            child: Text(
                              value.isLastPage ? 'Get Started' : 'Next',
                            ),
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
      create: (BuildContext _) => OnboardingProvider(),
    );
  }
}
