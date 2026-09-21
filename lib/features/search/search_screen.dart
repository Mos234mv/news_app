import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/core/repos/news_repos.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/features/deatails/news_details.dart';
import 'package:news_app/features/search/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchScreenController>(
      create: (BuildContext context) {
        return SearchScreenController(NewsRepos(ApiService()));
      },

      child: Scaffold(
        appBar: AppBar(title: const Text('Search'), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Consumer<SearchScreenController>(
            builder:
                (BuildContext context, SearchScreenController controller, Widget? child) {
                  return Column(
                    children: [
                      TextField(
                        maxLines: 1,
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.getEveryThing();
                        },
                        textAlignVertical: TextAlignVertical
                            .center, // يضبط النص والأيقونة رأسياً في المنتصف
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ), // هوامش جانبية مناسبة
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
                            borderSide: BorderSide
                                .none, // لإخفاء الخط الافتراضي إن كنت تريد خلفية فقط
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.newsEveryThing.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final model = controller.newsEveryThing[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppSizes.pw8),
                              child: ListTile(
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
                                leading: Icon(
                                  Icons.search,
                                  size: AppSizes.r20,
                                  color: const Color(0xFFA0A0A0),
                                ),
                                title: Text(
                                  model.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: BookmarkButton(article: model),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(color: Color(0xFFA0A0A0));
                          },
                        ),
                      ),
                    ],
                  );
                },
          ),
        ),
      ),
    );
  }
}
