import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';

import 'package:news_app/features/Home/components/news_item.dart';
import 'package:news_app/features/Home/components/top_head_line_shimmer.dart';
import 'package:news_app/features/Home/cubit/cubit/home_cubit.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        switch (state.topheadlinestutas) {
          case RequestStytasEnum.loding:
            return TopHeadLineShimmer();
          case RequestStytasEnum.error:
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.errorMessage!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            );
          case RequestStytasEnum.loded:
            return SliverList.builder(
              itemCount: state.newsTopHeadLine.take(20).length,
              itemBuilder: (BuildContext context, int index) {
                final model = state.newsTopHeadLine[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
