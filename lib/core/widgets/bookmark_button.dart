import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';
import 'package:news_app/features/bookmark/cubit/book_mark_cubit.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    super.key,
    required this.article,
    this.size,
    this.activeColor,
    this.inactiveColor,
    this.showSnackBar = true,
    this.padding,
    this.onToggle,
  });

  final NewsArticleModel article;
  final double? size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showSnackBar;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<bool>? onToggle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookMarkCubit, BookMarkState>(
      builder: (context, state) {
        final cubit = context.read<BookMarkCubit>();
        final bool isBookmarked = state.isBookmarked(article.url);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            final bool isAdded = await cubit.toggleBookmark(article);
            if (onToggle != null) {
              onToggle!(isAdded);
            }
            if (showSnackBar && context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(cubit.getSuccessMessage(isAdded)),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked
                  ? (activeColor ?? LightColor.primaryColor)
                  : (inactiveColor ?? const Color(0xFF363636)),
              size: size ?? AppSizes.h24,
            ),
          ),
        );
      },
    );
  }
}
