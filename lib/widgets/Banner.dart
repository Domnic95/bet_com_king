// ignore_for_file: file_names

import 'dart:io';

import 'package:bet_mobile/providers/providers.dart';
import 'package:bet_mobile/widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BannerView extends ConsumerStatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final void Function()? leadingonTap;

  BannerView({Key? key, this.leadingonTap})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  ConsumerState<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends ConsumerState<BannerView> {
  bool isloading = true;

  fetchBanner() async {
    setState(() {
      isloading = true;
    });
    if (Platform.isAndroid) {
      await ref.read(bannerProvider).getBannerAndroid();
    } else {
      await ref.read(bannerProvider).getBannerIos();
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBanner();
  }

  @override
  Widget build(BuildContext context) {
    final bannerData = ref.read(bannerProvider);
    return isloading
        ? Container(
            height: 45,
            color: Appcolor.primaryColor,
            width: MediaQuery.of(context).size.width,
          )
        : GestureDetector(
            onTap: () {
              launchUrl(Uri.parse(
                      //bannerData.bannerModel.clickurl.toString().isEmpty
                      //     ? 'https://www.google.com/'
                      //     :
                      bannerData.bannerModel.clickurl.toString()),
                  mode: LaunchMode.externalApplication);
            },
            child: Container(
                height: 45,
                decoration: const BoxDecoration(
                  color: Appcolor.primaryColor,
                ),
                width: MediaQuery.of(context).size.width,
                child:
                    // Platform.isIOS
                    //     ?
                    Image.network(bannerData.bannerModel.imageurl.toString())
                // :
                // const WebView(
                //     initialUrl:
                //         'https://www.gamings1.com/mk/android/365sports/',
                //     javascriptMode: JavascriptMode.unrestricted,
                //     backgroundColor: Color(0xff13805e),
                //   ),
                ),
          );
  }
}
