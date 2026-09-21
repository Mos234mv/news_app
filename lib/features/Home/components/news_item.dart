import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/extentions/date_time_extention.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';
import 'package:news_app/features/bookmark/controllers/bookmark_controller.dart';
import 'package:news_app/features/deatails/news_details.dart';
import 'package:provider/provider.dart';

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
        child: Row(
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
                  Text(model.title, style: Theme.of(context).textTheme.titleLarge, maxLines: 2),
                  Row(
                    children: [
                      if (model.urlToImage != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(model.urlToImage!),
                          radius: AppSizes.r10,
                        ),
                      SizedBox(width: AppSizes.pw6),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              () {
                                final author = model.author ?? "There Is No Thing";
                                return author.substring(0, min(author.length, 10));
                              }(),
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 1,
                            ),
                            SizedBox(width: AppSizes.pw8),
                            Expanded(
                              child: Text(
                                model.publishedAt.formatDateTime(),
                                style: TextStyle(
                                  color: Color(0xFF141414),
                                  fontSize: AppSizes.sp16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Consumer<BookmarkController>(
                              builder: (context, bookmarkController, child) {
                                final bool isBookmarked =
                                    bookmarkController.isBookmarked(model.url);
                                return GestureDetector(
                                  onTap: () async {
                                    final bool isAdded =
                                        await bookmarkController.toggleBookmark(model);
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          bookmarkController.getSuccessMessage(isAdded),
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                    color: isBookmarked
                                        ? LightColor.primaryColor
                                        : const Color(0xFF363636),
                                    size: AppSizes.h24,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
