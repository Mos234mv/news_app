import 'package:flutter/material.dart';
import 'package:news_app/features/Home/models/home_provider.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,

            child: Image.asset('assets/images/home_background.png', fit: BoxFit.cover),
          ),

          Positioned.fill(
            top: 70,
            child: Column(
              children: [
                Text('NEWST', style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trending News', style: Theme.of(context).textTheme.bodyMedium),
                      Text('View all', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),

                SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: Consumer<HomeProvider>(
                    builder: (BuildContext context, HomeProvider controller, Widget? child) {
                      return (controller.errorMessage?.isNotEmpty ?? false)
                          ? Center(child: Text(controller.errorMessage!))
                          : controller.everyThingLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.newsEveryThing.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      children: [
                                        if (controller.newsEveryThing[index].urlToImage != null)
                                          Image.network(controller.newsEveryThing[index].urlToImage!),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
