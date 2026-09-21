import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/extentions/date_time_extention.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key, required this.model});
  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
            child: BookmarkButton(article: model),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Column(
            children: [
              SizedBox(height: AppSizes.ph8),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r4),
                child: CustomCachedNetworkImage(
                  path: model.urlToImage ?? "",
                  height: AppSizes.h200,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: AppSizes.ph16),
              Text(
                model.title,
                style: Theme.of(context).textTheme.titleLarge!
                    .copyWith(fontSize: AppSizes.sp20),
              ),
              SizedBox(height: AppSizes.ph16),
              Row(
                children: [
                  if (model.urlToImage != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(model.urlToImage!),
                      radius: AppSizes.r16,
                    ),
                  SizedBox(width: AppSizes.pw6),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          (model.author ?? "").substring(
                            0,
                            min((model.author ?? "").length, 10),
                          ),
                          style: TextStyle(
                            color: const Color(0xFF141414),
                            fontSize: AppSizes.sp14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: AppSizes.pw8),
                        Expanded(
                          child: Text(
                            model.publishedAt.formatDateTime(),
                            style: TextStyle(
                              color: const Color(0xFF141414),
                              fontSize: AppSizes.sp14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        BookmarkButton(article: model),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.ph16),
              Text(
                model.description ?? "",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
