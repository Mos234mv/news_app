import 'package:flutter/material.dart';


import 'package:shimmer/shimmer.dart';

import '../../../core/constant/app_sizes.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Shimmer.fromColors(
            // ignore: sort_child_properties_last
            child: Container(height: AppSizes.h80, color: Color(0xFFFFFFFF)),
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
          ),
        );
      },
    );
  }
}