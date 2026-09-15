import 'package:flutter/material.dart';
import 'package:news_app/features/Home/components/categories_list.dart';
import 'package:news_app/features/Home/components/top_headline.dart';
import 'package:news_app/features/Home/components/trending_news.dart';

import 'package:news_app/features/Home/models/home_provider.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return HomeProvider();
      },
      child: Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider controller, Widget? child) {
          return Scaffold(body: CustomScrollView(slivers: [TrendingNews(), CategoriesList(), TopHeadline()]));
        },
      ),
    );
  }
}
