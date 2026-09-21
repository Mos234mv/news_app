import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/extentions/date_time_extention.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';
import 'package:news_app/features/deatails/news_details.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return NewsDetails(model: model);
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph8),
        child: SizedBox(
          height: AppSizes.h90,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r8),
                child: CustomCachedNetworkImage(path: model.urlToImage ?? ''),
              ),
              SizedBox(width: AppSizes.pw8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        if (model.urlToImage != null) ...[
                          CircleAvatar(
                            backgroundImage: NetworkImage(model.urlToImage!),
                            radius: AppSizes.r10,
                          ),
                          SizedBox(width: AppSizes.pw6),
                        ],
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  () {
                                    final author = model.author ?? "Unknown";
                                    return author.substring(0, min(author.length, 10));
                                  }(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: AppSizes.pw8),
                              Flexible(
                                child: Text(
                                  model.publishedAt.formatDateTime(),
                                  style: TextStyle(
                                    color: const Color(0xFF141414),
                                    fontSize: AppSizes.sp14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        BookmarkButton(article: model),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
