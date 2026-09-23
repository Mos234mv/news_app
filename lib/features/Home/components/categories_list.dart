import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/features/Home/categories_Screen.dart';
import 'package:news_app/features/Home/components/view_all%20_comoponent.dart';
import 'package:news_app/features/Home/cubit/cubit/home_cubit.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});
  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              ViewAllComoponent(
                title: 'Categories',
                titleColor: Color(0xFF141414),
                onTap: () {
                  final homeCubit = context.read<HomeCubit>();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return BlocProvider.value(
                          value: homeCubit,
                          child: CategoriesScreen(),
                        );
                      },
                    ),
                  );
                },
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: AppSizes.pw16,
                  top: AppSizes.ph16,
                  bottom: AppSizes.ph16,
                ),
                child: SizedBox(
                  height: AppSizes.h35,
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
                              Text(
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
            ],
          ),
        );
      },
    );
  }
}
