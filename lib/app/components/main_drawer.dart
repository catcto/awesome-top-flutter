import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'title'.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text('Privacy Policy'.tr),
            onTap: () {
              Get.toNamed(AppRoutes.WEBVIEW,
                  arguments: {'title': 'Privacy Policy'.tr, 'url': 'https://awesome.top/app/privacy-policy.html'});
            },
          ),
          ListTile(
            title: Text('Terms & Conditions'.tr),
            onTap: () {
              Get.toNamed(AppRoutes.WEBVIEW, arguments: {
                'title': 'Terms & Conditions'.tr,
                'url': 'https://awesome.top/app/terms-conditions.html'
              });
            },
          ),
        ],
      ),
    );
  }
}
