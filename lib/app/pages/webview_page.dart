import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebviewController>(() => WebviewController());
  }
}

class WebviewController extends GetxController{
  var progress = 0.obs;
  var title = ''.obs;
  WebViewController? webViewController;
}

class WebviewPage extends GetView<WebviewController> {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Obx(() => Text("${controller.title.isEmpty ? Get.arguments['title'] : controller.title}"))),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: Get.arguments['url'],
            onProgress: (progress) {
              controller.progress.value = progress;
              if (progress == 100 && controller.webViewController != null) {
                controller.webViewController!.runJavascriptReturningResult("document.title").then((result) {
                  controller.title.value = result.trim().replaceAll('"', '');
                });
              }
            },
            onWebViewCreated: (WebViewController webViewController) {
              controller.webViewController = webViewController;
            },
          ),
          Obx(() {
            if (controller.progress.value == 100) {
              return Container();
            } else {
              return const LinearProgressIndicator();
            }
          })
        ],
      ),
    );
  }
}
