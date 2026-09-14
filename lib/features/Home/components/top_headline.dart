import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/extentions/date_time_extention.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/Home/models/home_provider.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, controller, Widget? child) {
        return SliverList.builder(
          itemCount: controller.newsTopHeadLine.take(20).length,
          itemBuilder: (BuildContext context, int index) {
            final model = controller.newsTopHeadLine[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CustomCachedNetworkImage(path: model.urlToImage ?? ''),

                    //Image.network(
                    //   model.urlToImage ?? '',
                    //   width: 130,
                    //   height: 90,
                    //   fit: BoxFit.cover, // لتعديل شكل عرض الصورة داخل الأبعاد المحددة
                    //   errorBuilder: (context, error, stackTrace) {
                    //     // سيتم تنفيذ هذا الكود إذا كان الرابط فارغاً أو حدث خطأ في التحميل
                    //     return Container(
                    //       width: 120,
                    //       height: 48,
                    //       color: Colors.grey[200],
                    //       child: const Icon(Icons.broken_image, color: Colors.grey),
                    //     );
                    //   },
                    // ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.title, style: Theme.of(context).textTheme.titleLarge, maxLines: 2),
                        Row(
                          children: [
                            if (model.urlToImage != null)
                              CircleAvatar(backgroundImage: NetworkImage(model.urlToImage!), radius: 10),

                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                () {
                                  final author = model.author ?? "There Is No Thing";
                                  return author.substring(0, min(author.length, 10));
                                }(),
                                style: Theme.of(context).textTheme.titleLarge,
                                maxLines: 1,
                              ),
                            ),
                            // Expanded(
                            //   child: Text(
                            //     (model.author ?? "".substring(0 , min(model.author!.length, 10))), //.substring(0, min(model.author!.length, 10)),
                            //     style: Theme.of(context).textTheme.titleLarge,
                            //   ),
                            // ),
                            SizedBox(width: 8),
                            Text(
                              model.publishedAt.formatDateTime(),
                              style: TextStyle(color: Color(0xFF141414), fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Expanded(child: Row(children: [
                                          
                                        ],
                                      
                                      )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
