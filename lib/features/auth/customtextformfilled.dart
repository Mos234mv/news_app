import 'package:flutter/material.dart';

class CustomTextFormFilled extends StatelessWidget {
  CustomTextFormFilled({
    super.key,

    required this.controller,
    this.maxlines,
    required this.hintText,
    required this.validator,
    required this.title,
    this.suffix,
  });
  final TextEditingController controller;
  final int? maxlines;
  final String hintText;
  final String? Function(String?)? validator;
  final String title;
  final Widget? suffix;

  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Newts',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium,
          ),

          SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxlines,
            validator: validator,
            style: Theme.of(context).textTheme.displayLarge,
            decoration: InputDecoration(hintText: hintText, suffix: suffix),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
