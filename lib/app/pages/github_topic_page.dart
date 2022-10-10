import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../components/main_drawer.dart';
import '../model/model.dart';
import '../services/services.dart';
import '../routes/app_routes.dart';

class GithubTopicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GithubTopicController>(() => GithubTopicController());
  }
}

class GithubTopicController extends GetxController with StateMixin<TopicModel> {
  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try {
      TopicModel topic = await RepoService.getTopic();
      if (topic.success! && topic.result!.isNotEmpty) {
        change(topic, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on DioError catch (e) {
      change(null, status: RxStatus.error('Internal Server Error'.tr));
    }
  }
}

class GithubTopicPage extends GetView<GithubTopicController> {
  const GithubTopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('title'.tr),
      ),
      drawer: const MainDrawer(),
      body: controller.obx(
        (state) => RefreshIndicator(
          onRefresh: () async {
            controller.getData();
          },
          child: ListView.separated(
            itemCount: state!.result!.length,
            itemBuilder: (context, index) {
              final repo = state.result![index];
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.GITHUB_REPO, arguments: {'owner': repo.owner!, 'repo': repo.repo!});
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              repo.repo!,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              repo.details!.description!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_border,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  intl.NumberFormat.decimalPattern().format(repo.details!.stargazersCount!),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.more_vert,
                        size: 16.0,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
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
