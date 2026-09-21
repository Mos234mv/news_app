// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';

import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/extentions/date_time_extention.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/Home/components/trending_news_shimmer.dart';
import 'package:news_app/features/Home/components/view_all%20_comoponent.dart';
import 'package:news_app/features/Home/models/home_provider.dart';
import 'package:news_app/features/deatails/news_details.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h330,
        child: Stack(
          children: [
            SizedBox(
              height: AppSizes.h240,
              width: double.infinity,

              child: Image.asset(
                'assets/images/home_background.png',
                fit: BoxFit.cover,
                height: AppSizes.h140,
                width: AppSizes.w240,
              ),
            ),

            Positioned.fill(
              top: AppSizes.ph70,
              child: Column(
                children: [
                  Text('NEWST', style: Theme.of(context).textTheme.labelSmall),
                  SizedBox(height: AppSizes.ph6),
                  ViewAllComoponent(title: 'Trending News', onTap: () {}),
                  SizedBox(height: AppSizes.ph12),
                  SizedBox(
                    height: AppSizes.h140,
                    child: Consumer<HomeProvider>(
                      builder:
                          (BuildContext context, HomeProvider controller, Widget? child) {
                            switch (controller.everyThingStutas) {
                              case RequestStytasEnum.loding:
                                return TrendingNewsShimmer();
                              case RequestStytasEnum.error:
                                return Center(
                                  child: Text(
                                    controller.errorMessage!,
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                );

                              case RequestStytasEnum.loded:
                                return ListView.separated(
                                  separatorBuilder: (BuildContext context, int index) =>
                                      SizedBox(width: AppSizes.pw12),
                                  padding: EdgeInsets.only(left: AppSizes.pw16),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.newsEveryThing.take(5).length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final model = controller.newsEveryThing[index];
                                    // ignore: sized_box_for_whitespace
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return NewsDetails(model: model);
                                            },
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: AppSizes.w240,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.r12,
                                          ),
                                          child: Stack(
                                            children: [
                                              if (model.urlToImage != null)
                                                CustomCachedNetworkImage(
                                                  path: model.urlToImage ?? '',
                                                  width: AppSizes.w240,
                                                  height: AppSizes.h140,
                                                ),

                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Colors.black.withValues(
                                                          alpha: 0.1,
                                                        ),
                                                        Colors.black.withValues(
                                                          alpha: 0.7,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: AppSizes.h12,
                                                left: AppSizes.w12,
                                                right: AppSizes.w12,

                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model.title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                      maxLines: 2,
                                                    ),
                                                    SizedBox(height: AppSizes.ph6),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                      model.urlToImage ??
                                                                          "",
                                                                    ),
                                                                radius: AppSizes.r10,
                                                              ),
                                                              SizedBox(
                                                                width: AppSizes.pw6,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  model.author.toString(),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          model.publishedAt
                                                              .formatDateTime(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                            }
                          },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDateTime(String? date) {
  if (date == null) return "";
  final diff = DateTime.now().difference(DateTime.parse(date));

  if (diff.inMinutes < 60) {
    return "${diff.inMinutes}m ago";
  }
  if (diff.inHours < 24) {
    return "${diff.inHours}h ago";
  }

  return "${diff.inDays}d ago";
}
