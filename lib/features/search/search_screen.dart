import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/repos/news_repos.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/features/deatails/news_details.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SearchCubit(NewsRepos(ApiService()));
      },
      child: Builder(
        builder: (context) {
          final cubit = context.read<SearchCubit>();
          return Scaffold(
            appBar: AppBar(title: const Text('Search'), centerTitle: true),
            body: Padding(
              padding: EdgeInsets.all(AppSizes.pw16),
              child: Column(
                children: [
                  TextField(
                    maxLines: 1,
                    controller: cubit.searchController,
                    onChanged: (value) {
                      cubit.getEveryThing(value);
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: const Color(0xFFA0A0A0),
                        fontSize: AppSizes.sp14,
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: const Icon(Icons.search),
                      suffixIconColor: const Color(0xFFA0A0A0),
                      fillColor: const Color(0xFFF5F5F5),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (BuildContext context, SearchState state) {
                        if (state.status == RequestStytasEnum.loding &&
                            state.newsEveryThing.isEmpty) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (state.status == RequestStytasEnum.error &&
                            state.errorMessage != null) {
                          return Center(
                            child: Text(
                              state.errorMessage!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (state.newsEveryThing.isEmpty) {
                          return Center(
                            child: Text(
                              cubit.searchController.text.trim().isEmpty
                                  ? 'Type something to search'
                                  : 'No articles found',
                              style: const TextStyle(color: Color(0xFFA0A0A0)),
                            ),
                          );
                        }

                        return ListView.separated(
                          itemCount: state.newsEveryThing.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final model = state.newsEveryThing[index];
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
