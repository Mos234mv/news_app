import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/Theme/light_theme.dart';
import 'package:news_app/core/data_source/local_data/prefrence_manager.dart';
import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/features/bookmark/controllers/bookmark_controller.dart';
import 'package:news_app/features/bookmark/repository/bookmark_repository.dart';
import 'package:news_app/features/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await PrefrenceManager().init();
  await UserRepository().init();
  await BookmarkRepository().init();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BookmarkController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 832),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (cxt, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: light,
          home: const SplashScreen(),
        );
      },
    );
  }
}
