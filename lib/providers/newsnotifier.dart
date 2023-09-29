// ignore_for_file: file_names
import 'package:bet_mobile/models/NewsModel.dart';
import 'package:bet_mobile/providers/basenotifire.dart';
import 'package:bet_mobile/providers/config.dart';
import 'package:dio/dio.dart';

class NewsProvider extends Basenotifier {
  List<Article> newsmodel = [];

  Future news() async {
    Response res =
        await dioclient.getRequest(apiEnd: newsApi, queryParameters: {
      "readdb": 'yes',
      "json": 'yes',
    });
    if (res.statusCode == 200) {
      newsmodel = List.from(res.data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    } else {}

    notifyListeners();
  }
}
