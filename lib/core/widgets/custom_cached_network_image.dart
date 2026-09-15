// ignore_for_file: sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class CustomCachedNetworkImage extends StatelessWidget {
  CustomCachedNetworkImage({super.key, required this.path, this.height, this.width});

  final String path;
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? 130,
      height: height ?? 90,
      fit: BoxFit.cover,
      imageUrl: path,
      placeholder: (context, url) => Shimmer.fromColors(
        child: Container(width: width ?? 130, height: height ?? 90, color: Color(0xFFFFFFFF)),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
