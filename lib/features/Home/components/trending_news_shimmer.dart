// ignore_for_file: file_names, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/constant/app_sizes.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => SizedBox(width: AppSizes.pw12),
      padding: EdgeInsets.only(left: AppSizes.pw16),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        // ignore: sized_box_for_whitespace
        return Shimmer.fromColors(
          child: Container(
            decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(AppSizes.r8)),
            width: AppSizes.w240,
            height: AppSizes.h140,
          ),
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        );
      },
    );
  }
}