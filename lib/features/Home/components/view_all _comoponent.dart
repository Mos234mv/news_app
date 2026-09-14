import 'package:flutter/material.dart';

class ViewAllComoponent extends StatelessWidget {
  const ViewAllComoponent({super.key, required this.title, this.titleColor, required this.onTap});
  final String title;
  final Color? titleColor;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: titleColor ?? Color(0xFFFFFCFC), fontSize: 16, fontWeight: FontWeight.w700),
          ), //Theme.of(context).textTheme.bodyMedium
          InkWell(
            onTap: () => onTap,
            child: Text(
              'View all',
              style: TextStyle(
                color: titleColor ?? Color(0xFFFFFCFC),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                decorationColor: titleColor ?? Color(0xFFFFFCFC),
              ),
            ),
          ), //Theme.of(context).textTheme.bodySmall
        ],
      ),
    );
  }
}
