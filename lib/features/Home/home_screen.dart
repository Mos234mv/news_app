import 'package:flutter/material.dart';

import 'package:news_app/features/Home/models/home_provider.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext _) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder:
            (BuildContext context, HomeProvider controller, Widget? child) {
              return Scaffold(
                body: (controller.errorMessage?.isNotEmpty ?? false)
                    ? Center(child: Text(controller.errorMessage!))
                    : controller.everyThingLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.newsTopHeadLine.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  controller.newsTopHeadLine[index].title,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              );
            },
      ),
    );
  }
}
