// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
    BannerModel({
        this.clickurl,
        this.imageurl,
    });

    String? clickurl;
    String? imageurl;

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        clickurl: json["clickurl"],
        imageurl: json["imageurl"],
    );

    Map<String, dynamic> toJson() => {
        "clickurl": clickurl,
        "imageurl": imageurl,
    };
}
