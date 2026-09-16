// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.pw16),
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.ph48,
              child: TextField(
                maxLines: 1,
                controller: searchController,
                textAlignVertical: TextAlignVertical.center, // يضبط النص والأيقونة رأسياً في المنتصف
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16), // هوامش جانبية مناسبة
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: const Color(0xFFA0A0A0),
                    fontSize: AppSizes.sp14,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIcon: const Icon(Icons.search),
                  suffixIconColor: const Color(0xFFA0A0A0),
                  fillColor: const Color(0xFFF5F5F5),
                  filled: true, // ضرورية لإظهار الـ fillColor
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none, // لإخفاء الخط الافتراضي إن كنت تريد خلفية فقط
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
