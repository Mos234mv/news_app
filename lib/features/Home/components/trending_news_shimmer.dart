// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => SizedBox(width: 12),
      padding: EdgeInsets.only(left: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        // ignore: sized_box_for_whitespace
        return Shimmer.fromColors(
          child: Container(
            decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(8)),
            width: 240,
            height: 140,
          ),
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        );
      },
    );
  }
}
