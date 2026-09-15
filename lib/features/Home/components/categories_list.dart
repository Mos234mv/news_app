import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/features/Home/categories_Screen.dart';
import 'package:news_app/features/Home/components/view_all%20_comoponent.dart';
import 'package:news_app/features/Home/models/home_provider.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});
  final List<String> categories = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology'];
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider controller, Widget? child) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              ViewAllComoponent(
                title: 'Categories',
                titleColor: Color(0xFF141414),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ChangeNotifierProvider.value(value: controller, child: CategoriesScreen());
                      },
                    ),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: SizedBox(
                  height: 35,
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
                                style: TextStyle(
                                  color: isSelected ? LightColor.primaryColor : Color(0xFF363636),
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                ),
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
            ],
          ),
        );
      },
    );
  }
}
