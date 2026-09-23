import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/features/Home/home_screen.dart';
import 'package:news_app/features/bookmark/bookmark_screen.dart';
import 'package:news_app/features/bookmark/cubit/book_mark_cubit.dart';
import 'package:news_app/features/profile/profile_screen.dart';
import 'package:news_app/features/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BookMarkCubit, BookMarkState>(
        builder: (context, state) {
          final int count = state.bookmarkCount;
          return BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              const BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                icon: Badge(
                  isLabelVisible: count > 0,
                  label: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: LightColor.primaryColor,
                  child: const Icon(Icons.bookmark_outline),
                ),
                activeIcon: Badge(
                  isLabelVisible: count > 0,
                  label: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: LightColor.primaryColor,
                  child: const Icon(Icons.bookmark),
                ),
                label: "Bookmark",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          );
        },
      ),
      body: IndexedStack(index: _currentIndex, children: _screen),
    );
  }
}
