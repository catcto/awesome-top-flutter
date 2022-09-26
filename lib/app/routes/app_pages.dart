import 'package:get/get.dart';
import '../pages/splashscreen_page.dart';
import '../pages/webview_page.dart';
import '../pages/github_topic_page.dart';
import '../pages/github_repo_page.dart';
import '../pages/github_repo_readme_page.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.WEBVIEW,
      page: () => const WebviewPage(),
      binding: WebviewBinding(),
    ),
    GetPage(
      name: AppRoutes.GITHUB_TOPIC,
      page: () => const GithubTopicPage(),
      binding: GithubTopicBinding(),
    ),
    GetPage(
      name: AppRoutes.GITHUB_REPO,
      page: () => const GithubRepoPage(),
      binding: GithubRepoBinding(),
    ),
    GetPage(
      name: AppRoutes.GITHUB_REPO_README,
      page: () => const GithubRepoReadmePage(),
      binding: GithubRepoReadmeBinding(),
    ),
  ];
}