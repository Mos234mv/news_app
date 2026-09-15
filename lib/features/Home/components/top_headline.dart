import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';

import 'package:news_app/features/Home/components/news_item.dart';
import 'package:news_app/features/Home/components/top_head_line_shimmer.dart';
import 'package:news_app/features/Home/models/home_provider.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, controller, Widget? child) {
        switch (controller.topheadlinestutas) {
          case RequestStytasEnum.loding:
            return TopHeadLineShimmer();
          case RequestStytasEnum.error:
            return SliverToBoxAdapter(
              child: Center(child: Text(controller.errorMessage!, style: Theme.of(context).textTheme.titleSmall)),
            );
          case RequestStytasEnum.loded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadLine.take(20).length,
              itemBuilder: (BuildContext context, int index) {
                final model = controller.newsTopHeadLine[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
