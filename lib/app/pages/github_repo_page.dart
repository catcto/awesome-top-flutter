import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../model/model.dart';
import '../routes/app_routes.dart';
import '../services/services.dart';

class GithubRepoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GithubRepoController>(() => GithubRepoController());
  }
}

class GithubRepoController extends GetxController with StateMixin<RepoModel> {
  var homePage = ''.obs;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try {
      RepoModel repo = await RepoService.getRepo(Get.arguments);
      if (repo.success! && repo.result != null) {
        if (repo.result!.details!.homepage != null) {
          homePage.value = repo.result!.details!.homepage!;
        }
        change(repo, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on DioError catch (e) {
      change(null, status: RxStatus.error('Internal Server Error'.tr));
    }
  }
}

class GithubRepoPage extends GetView<GithubRepoController> {
  const GithubRepoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Get.arguments['repo']),
      ),
      body: controller.obx(
        (state) => Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 22.0,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      state!.result!.owner!,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  state.result!.repo!,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      size: 16.0,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${intl.NumberFormat.decimalPattern().format(state.result!.details!.stargazersCount!)} ${'stars'.tr}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0)),
                    const Icon(
                      Icons.copy_all,
                      size: 16.0,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${intl.NumberFormat.decimalPattern().format(state.result!.details!.forksCount!)} ${'forks'.tr}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  state.result!.details!.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // const Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
                // Text(
                //   intl.DateFormat.yMMMd().format(DateTime.parse(state.result!.details!.updatedAt!)),
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.toNamed(AppRoutes.WEBVIEW,
                              arguments: {'title': state.result!.repo!, 'url': state.result!.url!});
                        },
                        icon: const Icon(
                          // <-- Icon
                          Icons.open_in_new,
                          size: 24.0,
                        ),
                        label: Text('More'.tr), // <-- Text
                      ),
                    ),
                    Obx(() {
                      if (controller.homePage.isEmpty) {
                        return Container();
                      } else {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Get.toNamed(AppRoutes.WEBVIEW,
                                  arguments: {'title': state.result!.repo!, 'url': state.result!.details!.homepage!});
                            },
                            child: Text('Home Page'.tr), // <-- Text
                          ),
                        );
                      }
                    }),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.toNamed(AppRoutes.GITHUB_REPO_README,
                              arguments: {'owner': state.result!.owner!, 'repo': state.result!.repo!});
                        },
                        child: Text('Readme.md'.tr), // <-- Text
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: Theme.of(context).dividerTheme.color,
                  endIndent: 12.5,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List<Widget>.generate(
                    state.result!.details!.topics!.length,
                    (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: Text(state.result!.details!.topics![index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onEmpty: Center(
          child: Text('Not found'.tr),
        ),
        onError: (error) => Center(
          child: Text(error!),
        ),
      ),
    );
  }
}
