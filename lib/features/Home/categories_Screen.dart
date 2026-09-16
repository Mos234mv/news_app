// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';

import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/features/Home/components/categories_shimmer.dart';

import 'package:news_app/features/Home/components/news_item.dart';
import 'package:news_app/features/Home/models/home_provider.dart';
import 'package:provider/provider.dart';

import '../../core/constant/app_sizes.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final List<String> categories = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technolgy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories'), centerTitle: true),
      body: Consumer<HomeProvider>(
        builder: (BuildContext context, controller, Widget? child) {
          switch (controller.categoriesstutas) {
            case RequestStytasEnum.loding:
              return CategoriesShimmer();
            case RequestStytasEnum.error:
              return Center(child: Text(controller.errorMessage!, style: Theme.of(context).textTheme.titleSmall));
            case RequestStytasEnum.loded:
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: AppSizes.pw16, top: AppSizes.ph16, bottom: AppSizes.ph16),
                    child: SizedBox(
                      height: AppSizes.ph35,
                      child: ListView.separated(
                        padding: EdgeInsets.only(right: AppSizes.pw20),
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
                                      fontSize: AppSizes.sp16,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    SizedBox(height: AppSizes.ph6),
                                    Container(height: AppSizes.h2, color: LightColor.primaryColor),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => SizedBox(width: AppSizes.pw12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.newsTopHeadLine.length,
                      itemBuilder: (BuildContext context, int index) {
                        final model = controller.newsTopHeadLine[index];
                        return NewsItem(model: model);
                      },
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}