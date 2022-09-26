import 'dart:io';
import 'package:dio/dio.dart';
import '../config/config.dart';
import '../model/model.dart';

class RepoService {
  static Dio dio = Dio(BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: 15000,
      receiveTimeout: 100000,
      headers: {HttpHeaders.userAgentHeader: API_UA},
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json));

  static Future<TopicModel> getTopic() async {
    Response response = await dio.get('github/topic/awesome');
    return TopicModel.fromJson(response.data);
  }

  static Future<RepoModel> getRepo(Map<String, dynamic> args) async {
    var owner = args['owner'];
    var repo = args['repo'];
    Response response = await dio.get('github/repo/$owner/$repo');
    return RepoModel.fromJson(response.data);
  }

  static Future<RepoReadmeModel> getRepoReadme(Map<String, dynamic> args) async {
    var owner = args['owner'];
    var repo = args['repo'];
    Response response = await dio.get('github/repo/readme/$owner/$repo');
    return RepoReadmeModel.fromJson(response.data);
  }
}
