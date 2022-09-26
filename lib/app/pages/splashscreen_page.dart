import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}

class SplashScreenController extends GetxController {
  double imageSize = 100.0;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() => Get.offNamed(AppRoutes.GITHUB_TOPIC));
  }
}

class SplashScreenPage extends GetView<SplashScreenController> {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color(0xffff79ff),
      body: Center(
        child: Image.asset(
          'assets/images/icon.png',
          width: controller.imageSize,
        ),
      ),
    );
  }
}
