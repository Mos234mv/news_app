import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/widgets/custom_svg.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.pw16,
                  vertical: AppSizes.ph12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header card with badge
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppSizes.pw16),
                            decoration: BoxDecoration(
                              color: LightColor.primaryColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: CustomSvgPicture(
                              path: Constants.conditionIcon,
                              height: AppSizes.h36,
                              width: AppSizes.w36,
                              withColor: true,
                            ),
                          ),
                          SizedBox(height: AppSizes.ph12),
                          Text(
                            'Terms of Service',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: AppSizes.sp20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: AppSizes.ph4),
                          Text(
                            'Last updated: September 2026',
                            style: Theme.of(context).textTheme.displaySmall!
                                .copyWith(fontSize: AppSizes.sp12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.ph20),

                    // Section Cards
                    _buildSectionCard(
                      context,
                      title: '1. Acceptance of Terms',
                      content: 'By downloading, accessing, or using this News Application, you agree to comply with and be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the application.',
                    ),
                    SizedBox(height: AppSizes.ph12),

                    _buildSectionCard(
                      context,
                      title: '2. News Content & Third-Party APIs',
                      content: 'All news articles, headlines, multimedia, and summaries delivered through this application are aggregated from public sources via NewsAPI. Content ownership and copyright remain strictly with the respective original publishers and journalistic outlets.',
                    ),
                    SizedBox(height: AppSizes.ph12),

                    _buildSectionCard(
                      context,
                      title: '3. User Accounts & Security',
                      content: 'You are responsible for maintaining the confidentiality of your credentials and account information. You agree to accept responsibility for all activities that occur under your account.',
                    ),
                    SizedBox(height: AppSizes.ph12),

                    _buildSectionCard(
                      context,
                      title: '4. Bookmarks & Local Storage',
                      content: 'Articles saved using the Bookmark feature are stored locally on your device storage (Hive database) for offline access. We do not transmit, analyze, or sell your reading history or personal bookmarks.',
                    ),
                    SizedBox(height: AppSizes.ph12),

                    _buildSectionCard(
                      context,
                      title: '5. Privacy & Data Protection',
                      content: 'We respect your privacy. Personal data such as profile preferences and country filters are saved locally to provide customized feeds and are governed by our Privacy Policy.',
                    ),
                    SizedBox(height: AppSizes.ph12),

                    _buildSectionCard(
                      context,
                      title: '6. Modifications to Service',
                      content: 'We reserve the right to modify, suspend, or discontinue any feature of the service at any time without notice. Continued use of the application following updates constitutes agreement with the revised terms.',
                    ),
                    SizedBox(height: AppSizes.ph12),

                    _buildSectionCard(
                      context,
                      title: '7. Contact & Support',
                      content: 'If you have any questions or feedback regarding these Terms & Conditions, please contact us at support@newsapp.com.',
                    ),
                    SizedBox(height: AppSizes.ph20),
                  ],
                ),
              ),
            ),

            // Bottom Confirmation Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.pw16,
                vertical: AppSizes.ph12,
              ),
              child: SizedBox(
                width: double.infinity,
                height: AppSizes.h50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightColor.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'I Understand & Agree',
                    style: TextStyle(
                      fontSize: AppSizes.sp16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.pw16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: AppSizes.sp16,
              color: const Color(0xFF141414),
            ),
          ),
          SizedBox(height: AppSizes.ph8),
          Text(
            content,
            style: TextStyle(
              fontSize: AppSizes.sp14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6E7191),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
