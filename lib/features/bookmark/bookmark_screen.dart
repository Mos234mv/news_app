import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/features/Home/components/news_item.dart';
import 'package:news_app/features/bookmark/controllers/bookmark_controller.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showClearAllDialog(BuildContext context, BookmarkController controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Bookmarks?'),
        content: const Text(
          'Are you sure you want to remove all saved articles? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: LightColor.primaryColor,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await controller.clearAllBookmarks();
              if (context.mounted) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All bookmarks cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Mark'),
        centerTitle: true,
        actions: [
          Consumer<BookmarkController>(
            builder: (context, controller, child) {
              if (controller.bookmarkCount == 0) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Clear all bookmarks',
                icon: const Icon(Icons.delete_sweep_outlined),
                onPressed: () => _showClearAllDialog(context, controller),
              );
            },
          ),
        ],
      ),
      body: Consumer<BookmarkController>(
        builder: (context, controller, child) {
          if (controller.status == RequestStytasEnum.loding &&
              controller.bookmarks.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final articles = controller.bookmarkedArticles;

          return Column(
            children: [
              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.pw16,
                  vertical: AppSizes.ph8,
                ),
                child: TextField(
                  controller: _searchController,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    controller.searchBookmarks(value);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.pw16,
                      vertical: AppSizes.ph10,
                    ),
                    hintText: "Search bookmarks...",
                    hintStyle: TextStyle(
                      color: const Color(0xFFA0A0A0),
                      fontSize: AppSizes.sp14,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFFA0A0A0)),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              controller.searchBookmarks('');
                              setState(() {});
                            },
                          )
                        : null,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                      borderSide: const BorderSide(color: Color(0xFFD1DAD6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                      borderSide: const BorderSide(color: Color(0xFFD1DAD6)),
                    ),
                  ),
                ),
              ),

              // Content Area
              Expanded(
                child: articles.isEmpty
                    ? _buildEmptyState(
                        context,
                        isSearching: _searchController.text.trim().isNotEmpty,
                      )
                    : ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return Dismissible(
                            key: Key(article.url),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: AppSizes.pw20),
                              color: LightColor.primaryColor,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.delete_outline, color: Colors.white),
                                  SizedBox(width: 6),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (direction) async {
                              await controller.removeBookmark(article.url);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      Constants.bookmarkRemovedMessage,
                                    ),
                                    duration: const Duration(seconds: 3),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      textColor: Colors.white,
                                      onPressed: () {
                                        controller.addBookmark(article);
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                            child: NewsItem(model: article),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, {required bool isSearching}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pw32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.pw20),
              decoration: BoxDecoration(
                color: LightColor.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearching ? Icons.search_off : Icons.bookmark_border,
                size: AppSizes.h56,
                color: LightColor.primaryColor,
              ),
            ),
            SizedBox(height: AppSizes.ph16),
            Text(
              isSearching ? 'No Results Found' : 'No Bookmarks Yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.ph8),
            Text(
              isSearching
                  ? 'Try searching with a different keyword'
                  : 'Articles you bookmark will appear here so you can easily read them later offline.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
