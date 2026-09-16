import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';

class CustomTextFormFilled extends StatefulWidget {
  CustomTextFormFilled({
    super.key,

    required this.controller,
    this.maxlines = 1,
    required this.hintText,
    required this.validator,
    required this.title,
    this.suffix,
    this.obscureText = true,
  });
  final TextEditingController controller;
  final int? maxlines;
  final String hintText;
  final String? Function(String?)? validator;
  final String title;
  final Widget? suffix;
  final bool obscureText;

  @override
  State<CustomTextFormFilled> createState() => _CustomTextFormFilledState();
}

class _CustomTextFormFilledState extends State<CustomTextFormFilled> {
  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Newts',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleMedium,
        ),

        SizedBox(height: AppSizes.ph16),
        Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height:AppSizes.ph8),
        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxlines,
          validator: widget.validator,
          style: Theme.of(context).textTheme.displayLarge,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: isPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  )
                : null,
          ),
          obscureText: widget.obscureText && !isPassword,
        ),
        SizedBox(height: AppSizes.ph12),
      ],
    );
  }
}
