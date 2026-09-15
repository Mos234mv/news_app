import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class TopHeadLineShimmer extends StatelessWidget {
  const TopHeadLineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Shimmer.fromColors(
            // ignore: sort_child_properties_last
            child: Container(height: 80, color: Color(0xFFFFFFFF)),
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
          ),
        );
      },
    );
  }
}
