import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/features/Home/models/home_provider.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  Categories({super.key});
  final List<String> categories = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technol'];
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider controller, Widget? child) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: SizedBox(
              height: 30,
              child: ListView.separated(
                padding: EdgeInsets.only(right: 20),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = categories[index] == controller.selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      controller.updatSelectedCategory(categories[index]);
                    },
                    child: IntrinsicWidth(
                      child: Column(
                        children: [
                          Text(
                            categories[index][0].toUpperCase() + categories[index].substring(1),
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          if (isSelected) ...[
                            SizedBox(height: 6),
                            Container(height: 2, color: LightColor.primaryColor),
                          ],
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 12),
              ),
            ),
          ),
        );
      },
    );
  }
}
