import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flutter/material.dart';
import 'package:news_app/features/Home/components/categories.dart';
import 'package:news_app/features/Home/components/trending_news.dart';
import 'package:news_app/features/Home/components/view_all%20_comoponent.dart';

import 'package:news_app/features/Home/models/home_provider.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext _) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider controller, Widget? child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                TrendingNews(),
                SliverToBoxAdapter(
                  child: ViewAllComoponent(title: 'Categories', titleColor: Color(0xFF141414), onTap: () {}),
                ),
                Categories(),
                SliverList.builder(
                  itemCount: controller.newsTopHeadLine.take(20).length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = controller.newsTopHeadLine[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              model.urlToImage ?? '',
                              width: 130,
                              height: 90,
                              fit: BoxFit.cover, // لتعديل شكل عرض الصورة داخل الأبعاد المحددة
                              errorBuilder: (context, error, stackTrace) {
                                // سيتم تنفيذ هذا الكود إذا كان الرابط فارغاً أو حدث خطأ في التحميل
                                return Container(
                                  width: 120,
                                  height: 48,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image, color: Colors.grey),
                                );
                              },
                            ),
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
                                    CircleAvatar(backgroundImage: NetworkImage(model.urlToImage ?? '')),

                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        (model.author ?? "There Is No Thing").substring(
                                          0,
                                          min(model.author!.length, 0),
                                        ),
                                        style: Theme.of(context).textTheme.titleLarge,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
