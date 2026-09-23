import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/features/Home/components/categories_list.dart';
import 'package:news_app/features/Home/components/top_headline.dart';
import 'package:news_app/features/Home/components/trending_news.dart';
import 'package:news_app/features/Home/cubit/cubit/home_cubit.dart';

import 'package:news_app/core/repos/news_repos.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return HomeCubit(NewsRepos(ApiService()));
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [TrendingNews(), CategoriesList(), TopHeadline()],
        ),
      ),
    );
  }
}
