// ignore_for_file: file_names
import 'dart:developer';

import 'package:bet_mobile/models/MatchesResponse.dart';
import 'package:bet_mobile/models/OddsModel.dart';
import 'package:bet_mobile/providers/basenotifire.dart';
import 'package:bet_mobile/providers/config.dart';
import 'package:dio/dio.dart';

class OddsProvider extends Basenotifier {
  List<ScroreModel> scoreList = [];

  Future getScore({required String tabelName}) async {
    log("fkmdkfmkl " + tabelName);
    Response res = await dioclient.getRequest(
        apiEnd: oddsApi,
        queryParameters: {
          "readdb": 'yes',
          "tablename": tabelName,
          "json": 'yes'
        });
    if (res.statusCode == 200) {
      scoreList = List.from(res.data as List)
          .map((e) => ScroreModel.fromJson(e))
          .toList();
    } else {}

    notifyListeners();
  }
}
