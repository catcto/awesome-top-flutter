import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

enum Menu { openInBrowser, refresh, copyLink }

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebviewController>(() => WebviewController());
  }
}

class WebviewController extends GetxController {
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
        title: Obx(() => Text("${controller.title.isEmpty ? Get.arguments['title'] : controller.title}")),
        actions: <Widget>[
          // This button presents popup menu items.
          PopupMenuButton<Menu>(
              // Callback that sets the selected popup menu item.
              onSelected: (Menu item) async {
                switch (item) {
                  case Menu.copyLink:
                    {
                      var url = await controller.webViewController?.currentUrl();
                      ClipboardData data = ClipboardData(text: url);
                      await Clipboard.setData(data);
                    }
                    break;
                  case Menu.refresh:
                    {
                      controller.webViewController?.reload();
                    }
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                     PopupMenuItem<Menu>(
                      value: Menu.refresh,
                      child: Text('Refresh'.tr),
                    ),
                     PopupMenuItem<Menu>(
                      value: Menu.copyLink,
                      child: Text('Copy Link to Clipboard'.tr),
                    ),
                  ]),
        ],
      ),
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
