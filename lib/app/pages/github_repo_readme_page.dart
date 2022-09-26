import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../model/model.dart';
import '../services/services.dart';

class GithubRepoReadmeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GithubRepoReadmeController>(() => GithubRepoReadmeController());
  }
}

class GithubRepoReadmeController extends GetxController with StateMixin<RepoReadmeModel> {
  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try {
      RepoReadmeModel readme = await RepoService.getRepoReadme(Get.arguments);
      if (readme.success! && readme.result != null) {
        change(readme, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on DioError catch (e) {
      change(null, status: RxStatus.error('Internal Server Error'.tr));
    }
  }
}

class GithubRepoReadmePage extends GetView<GithubRepoReadmeController> {
  const GithubRepoReadmePage({Key? key}) : super(key: key);

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
          child:  Markdown(
            imageDirectory: 'https://raw.githubusercontent.com',
            selectable: true,
            data: state!.result!.readme!.content!,
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
