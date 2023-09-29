// ignore_for_file: file_names
import 'dart:developer';

import 'package:bet_mobile/models/MatchesResponse.dart';
import 'package:bet_mobile/providers/basenotifire.dart';
import 'package:bet_mobile/providers/config.dart';
import 'package:dio/dio.dart';

class FixtureProvider extends Basenotifier {
  List<MatchesResponseModel> scoreList = [];

  Future getScore({required String tabelName}) async {
    log("vsvnhjdsf   " + tabelName);
    Response res = await dioclient.getRequest(
        apiEnd: scoreApi,
        queryParameters: {
          "readdb": 'yes',
          "tablename": tabelName,
          "json": 'yes'
        });
    log("dfbdhfvhdk " + res.toString());
    if (res.statusCode == 200) {
      scoreList = List.from(res.data as List)
          .map((e) => MatchesResponseModel.fromJson(e))
          .toList();
    } else {}

    notifyListeners();
  }
}
