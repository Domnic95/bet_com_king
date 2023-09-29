// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:bet_mobile/models/MatchesResponse.dart';
import 'package:bet_mobile/providers/providers.dart';
import 'package:bet_mobile/widgets/Colors.dart';
import 'package:bet_mobile/widgets/FixtureCard.dart';
import 'package:bet_mobile/widgets/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class FixtureScreen extends ConsumerStatefulWidget {
  final String field;
  const FixtureScreen({super.key, required this.field});

  @override
  ConsumerState<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends ConsumerState<FixtureScreen> {
  bool isLoading = false;
  List<List<MatchesResponseModel>> soccerFixturesList = [];
  DateFormat dateFormat = DateFormat('EEEE d MMMM');
  List<DateTime> dates = [];

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    await ref.read(fixtureProvider).getScore(tabelName: widget.field);
    for (var i = 0; i < ref.read(fixtureProvider).scoreList.length; i++) {
      if (ref.read(fixtureProvider).scoreList[i].completed == "False") {
        int index =
            dates.indexOf(ref.read(fixtureProvider).scoreList[i].commenceTime!);
        if (index != -1) {
          soccerFixturesList[index].add(ref.read(fixtureProvider).scoreList[i]);
        } else {
          dates.add(ref.read(fixtureProvider).scoreList[i].commenceTime!);
          soccerFixturesList.add([ref.read(fixtureProvider).scoreList[i]]);
        }
      }
      setState(() {});
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    data();
    fetchData();
  }
data(){
  log("tablename are -=-=-${widget.field.toString()}");

}
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          isLoading
              ? const Expanded(child: LoadingWidget())
              : Expanded(
                  child: soccerFixturesList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Lottie.asset(
                              //   "assets/image/nodata.json",
                              //   height: 140,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "No games have been played today",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      // Image.asset('assets/image/nodatafound.png')
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          padding: EdgeInsets.zero,
                          itemCount: soccerFixturesList.length,
                          itemBuilder: (context, index) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: soccerFixturesList[index].length + 1,
                              itemBuilder: (context, subIndex) {
                                if (subIndex == 0) {
                                  return Container(
                                    padding: EdgeInsets.all(8),
                                    decoration:
                                        BoxDecoration(color: Appcolor.betNavy),
                                    child: Center(
                                      child: Text(
                                          DateFormat('EEEE, MMM d, yyyy')
                                              .format(dates[index]),
                                          style: TextStyle(
                                              color: Appcolor.whitecolor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12)),
                                    ),
                                  );
                                }
                                return FixtureCard(
                                  data: soccerFixturesList[index][subIndex - 1],
                                );
                              },
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }
}
