import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({super.key, required this.path, this.withColor = true, this.height, this.width});
  final String path;
  final bool withColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: withColor == true
          ? ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn)
          : null,
    );
  }
}
