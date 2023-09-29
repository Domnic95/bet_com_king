// ignore_for_file: file_names

import 'dart:developer';

import 'package:bet_mobile/models/OddsModel.dart';
import 'package:bet_mobile/providers/providers.dart';
import 'package:bet_mobile/widgets/Colors.dart';
import 'package:bet_mobile/widgets/LoadingWidget.dart';
import 'package:bet_mobile/widgets/OddsCard.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class OddsScreen extends ConsumerStatefulWidget {
  final String field;
  const OddsScreen({super.key, required this.field});

  @override
  ConsumerState<OddsScreen> createState() => _OddsScreenState();
}

class _OddsScreenState extends ConsumerState<OddsScreen> {
  bool isLoading = false;
  List<List<ScroreModel>> soccerFixturesList = [];
  DateFormat dateFormat = DateFormat('EEEE d MMMM');
  List<List<Bookmaker>> bookmaker = [];
  List<DateTime> dates = [];
  fetchData() async {
    setState(() {
      isLoading = true;
    });
    await ref.read(oddsProvider).getScore(tabelName: widget.field);
    for (var i = 0; i < ref.read(oddsProvider).scoreList.length; i++) {
      for (var j = 0;
          j < ref.read(oddsProvider).scoreList[i].bookmakers!.length;
          j++) {
        if (ref.read(oddsProvider).scoreList[i].bookmakers![j].key ==
            "betonlineag") {
          int index =
              dates.indexOf(ref.read(oddsProvider).scoreList[i].commenceTime!);

          if (index != -1) {
            bookmaker[index]
                .add(ref.read(oddsProvider).scoreList[i].bookmakers![j]);
            soccerFixturesList[index].add(ref.read(oddsProvider).scoreList[i]);
          } else {
            dates.add(ref.read(oddsProvider).scoreList[i].commenceTime!);
            bookmaker.add([ref.read(oddsProvider).scoreList[i].bookmakers![j]]);
            soccerFixturesList.add([ref.read(oddsProvider).scoreList[i]]);
          }
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
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // SizedBox(
          //   height: 0,
          // ),
          // Card(
          //   margin: EdgeInsets.symmetric(horizontal: 10),
          //   color: Appcolor.primaryColor.withOpacity(0.3),
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           height: 20,
          //           margin: EdgeInsets.symmetric(horizontal: 5),
          //           // width: 80,
          //           child: Center(
          //             child: Text(
          //               'MatchUp',
          //               style: TextStyle(
          //                 color: Appcolor.whitecolor,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 14,
          //                 letterSpacing: 0.5,
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           height: 20,
          //           margin: EdgeInsets.symmetric(horizontal: 5),
          //           // width: 80,
          //           child: Center(
          //             child: Text(
          //               'Spreads',
          //               style: TextStyle(
          //                 color: Appcolor.whitecolor,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 14,
          //                 letterSpacing: 0.5,
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           margin: EdgeInsets.symmetric(horizontal: 5),
          //           height: 20,
          //           // width: 80,
          //           child: Center(
          //             child: Text(
          //               'Totals',
          //               style: TextStyle(
          //                 color: Appcolor.whitecolor,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 14,
          //                 letterSpacing: 0.5,
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           margin: EdgeInsets.symmetric(horizontal: 5),
          //           height: 20,
          //           // width: 80,
          //           child: Center(
          //             child: Text(
          //               'H2H',
          //               style: TextStyle(
          //                 color: Appcolor.whitecolor,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 14,
          //                 letterSpacing: 0.5,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          isLoading
              ? const Expanded(child: LoadingWidget())
              : Expanded(
                  child: soccerFixturesList.isEmpty || bookmaker.isEmpty
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
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
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: soccerFixturesList.length,
                          itemBuilder: (context, index) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: soccerFixturesList[index].length + 1,
                              itemBuilder: (context, subIndex) {
                                if (subIndex == 0) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 15),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Appcolor.betNavy),
                                        child: Center(
                                          child: Text(
                                              DateFormat('EEEE, MMM d, yyyy')
                                                  .format(dates[index]),
                                              style: TextStyle(
                                                  color: Appcolor.whitecolor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Appcolor.blackcolor),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                // height: 20,
                                                // margin: EdgeInsets.symmetric(horizontal: 5),
                                                // width: 80,
                                                child: Center(
                                                  child: Text(
                                                    'MatchUp',
                                                    style: TextStyle(
                                                      color:
                                                          Appcolor.whitecolor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        // width: 80,
                                                        child: Center(
                                                          child: Text(
                                                            'Spreads',
                                                            style: TextStyle(
                                                              color: Appcolor
                                                                  .whitecolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        // width: 80,
                                                        child: Center(
                                                          child: Text(
                                                            'Totals',
                                                            style: TextStyle(
                                                              color: Appcolor
                                                                  .whitecolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        // width: 80,
                                                        child: Center(
                                                          child: Text(
                                                            'H2H',
                                                            style: TextStyle(
                                                              color: Appcolor
                                                                  .whitecolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return OddsCard(
                                  data: soccerFixturesList[index][subIndex - 1],
                                  bookmaker: bookmaker[index][subIndex - 1],
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
