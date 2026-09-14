import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
