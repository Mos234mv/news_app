// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/Theme/light_color.dart';

import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/features/Home/components/categories_shimmer.dart';

import 'package:news_app/features/Home/components/news_item.dart';
import 'package:news_app/features/Home/cubit/cubit/home_cubit.dart';

import '../../core/constant/app_sizes.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technolgy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories'), centerTitle: true),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          switch (state.categoriesstutas) {
            case RequestStytasEnum.loding:
              return CategoriesShimmer();
            case RequestStytasEnum.error:
              return Center(
                child: Text(
                  state.errorMessage!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              );
            case RequestStytasEnum.loded:
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppSizes.pw16,
                      top: AppSizes.ph16,
                      bottom: AppSizes.ph16,
                    ),
                    child: SizedBox(
                      height: AppSizes.ph35,
                      child: ListView.separated(
                        padding: EdgeInsets.only(right: AppSizes.pw20),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = categories[index] == state.selectedCategory;
                          return GestureDetector(
                            onTap: () {
                              context.read<HomeCubit>().updatSelectedCategory(
                                categories[index],
                              );
                            },
                            child: IntrinsicWidth(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Text(
                                      categories[index][0].toUpperCase() +
                                          categories[index].substring(1),
                                      style: TextStyle(
                                        color: isSelected
                                            ? LightColor.primaryColor
                                            : Color(0xFF363636),
                                        fontSize: AppSizes.sp16,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    SizedBox(height: AppSizes.ph6),
                                    Container(
                                      height: AppSizes.h2,
                                      color: LightColor.primaryColor,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: AppSizes.pw12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.newsTopHeadLine.length,
                      itemBuilder: (BuildContext context, int index) {
                        final model = state.newsTopHeadLine[index];
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
