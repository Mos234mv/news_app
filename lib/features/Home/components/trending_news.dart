// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/extentions/date_time_extention.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/Home/components/trending_news_shimmer.dart';
import 'package:news_app/features/Home/components/view_all%20_comoponent.dart';
import 'package:news_app/features/Home/models/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 330,
        child: Stack(
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,

              child: Image.asset('assets/images/home_background.png', fit: BoxFit.cover, height: 140, width: 240),
            ),

            Positioned.fill(
              top: 70,
              child: Column(
                children: [
                  Text('NEWST', style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 6),
                  ViewAllComoponent(title: 'Trending News', onTap: () {}),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                    child: Consumer<HomeProvider>(
                      builder: (BuildContext context, HomeProvider controller, Widget? child) {
                        switch (controller.everyThingStutas) {
                          case RequestStytasEnum.loding:
                            return TrendingNewsShimmer();
                          case RequestStytasEnum.error:
                            return Center(
                              child: Text(controller.errorMessage!, style: Theme.of(context).textTheme.titleSmall),
                            );

                          case RequestStytasEnum.loded:
                            return ListView.separated(
                              separatorBuilder: (BuildContext context, int index) => SizedBox(width: 12),
                              padding: EdgeInsets.only(left: 16),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.newsEveryThing.take(5).length,
                              itemBuilder: (BuildContext context, int index) {
                                final model = controller.newsEveryThing[index];
                                // ignore: sized_box_for_whitespace
                                return Container(
                                  width: 240,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      children: [
                                        if (model.urlToImage != null)
                                          CustomCachedNetworkImage(
                                            path: model.urlToImage ?? '',
                                            width: 240,
                                            height: 140,
                                          ),

                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withValues(alpha: 0.1),
                                                  Colors.black.withValues(alpha: 0.7),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          left: 12,
                                          right: 12,

                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.title,
                                                style: Theme.of(context).textTheme.bodyMedium,
                                                maxLines: 2,
                                              ),
                                              SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: NetworkImage(model.urlToImage ?? ""),
                                                          radius: 10,
                                                        ),
                                                        SizedBox(width: 6),
                                                        Expanded(child: Text(model.author.toString(), maxLines: 1)),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(model.publishedAt.formatDateTime()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
