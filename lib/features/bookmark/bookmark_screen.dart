import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/widgets/custom_svg.dart';
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
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r16)),
        title: Text(
          'Clear All Bookmarks?',
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSizes.sp18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to remove all saved articles? This action cannot be undone.',
          style: TextStyle(
            color: const Color(0xFFD1DAD6),
            fontSize: AppSizes.sp14,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.pw16,
          vertical: AppSizes.ph12,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFA0A0A0)),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: LightColor.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.r8),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.pw16,
                vertical: AppSizes.ph10,
              ),
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
        title: const Text('Bookmark'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
              // Search bar matching Figma search input
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
                      vertical: AppSizes.ph12,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: const Color(0xFFA0A0A0),
                      fontSize: AppSizes.sp14,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              controller.searchBookmarks('');
                              setState(() {});
                            },
                          )
                        : const Icon(Icons.search, color: Color(0xFFA0A0A0)),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Content Area
              Expanded(
                child: articles.isEmpty
                    ? BookmarkEmptyState(
                        isSearching: _searchController.text.trim().isNotEmpty,
                      )
                    : ListView.builder(
                        itemCount: articles.length,
                        padding: EdgeInsets.only(bottom: AppSizes.ph16),
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
                                    content: const Text(Constants.bookmarkRemovedMessage),
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
}

class BookmarkEmptyState extends StatelessWidget {
  const BookmarkEmptyState({super.key, required this.isSearching});

  final bool isSearching;

  @override
  Widget build(BuildContext context) {
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
              child: isSearching
                  ? Icon(
                      Icons.search_off,
                      size: AppSizes.h48,
                      color: LightColor.primaryColor,
                    )
                  : CustomSvgPicture(
                      path: Constants.bookmarkIcon,
                      height: AppSizes.h40,
                      width: AppSizes.w32,
                      withColor: true,
                    ),
            ),
            SizedBox(height: AppSizes.ph16),
            Text(
              isSearching ? 'No Results Found' : Constants.noBookmarksMessage,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.ph8),
            Text(
              isSearching ? 'Try searching with a different keyword' : 'Articles you bookmark will appear here so you can easily read them later.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
