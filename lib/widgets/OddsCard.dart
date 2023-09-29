// ignore_for_file: file_names

import 'dart:developer';

import 'package:bet_mobile/models/OddsModel.dart';
import 'package:bet_mobile/widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OddsCard extends StatefulWidget {
  final ScroreModel data;
  final Bookmaker bookmaker;

  OddsCard({super.key, required this.data, required this.bookmaker});

  @override
  State<OddsCard> createState() => _OddsCardState();
}

class _OddsCardState extends State<OddsCard> {
  final DateFormat dateFormat = DateFormat('EEEE, d MMMM');
  int spreadsindex = 0;
  int totalindex = 0;
  int h2hsindex = 0;

  @override
  void initState() {
    spreadsindex = widget.bookmaker.markets!
        .indexWhere((element) => element.key == "spreads");
    totalindex = widget.bookmaker.markets!
        .indexWhere((element) => element.key == "totals");
    h2hsindex =
        widget.bookmaker.markets!.indexWhere((element) => element.key == "h2h");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("fdszfdsf  " + widget.bookmaker.lastUpdate.toString());
    log("fdszfdsf  " + widget.bookmaker.key.toString());
    int timelength = widget.data.commenceTime
            .toString()
            .split(' ')
            .last
            .split(":")
            .first
            .characters
            .length +
        widget.data.commenceTime
            .toString()
            .split(' ')
            .last
            .split(":")[1]
            .characters
            .length;

    return Card(
      margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10),
      // ),
      elevation: 0,
      color: Appcolor.transparentcolor,
      child: Card(
        color: Appcolor.betSoftGrey,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 5,
            // ),

            // Padding(
            //     padding: EdgeInsets.only(top: 10, bottom: 10),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: Divider(
            //             // height: 50,
            //             color: Appcolor.greycolor,
            //             thickness: 1,
            //           ),
            //         ),
            //         Text(
            //           dateFormat.format(widget.data.commenceTime!),
            //           style: TextStyle(
            //             color: Appcolor.whitecolor,
            //             fontWeight: FontWeight.bold,
            //             fontSize: 14,
            //             // letterSpacing: 0.5,
            //           ),
            //         ),
            //         Expanded(
            //           child: Divider(
            //             // height: 50,
            //             color: Appcolor.greycolor,
            //             thickness: 1,
            //           ),
            //         ),
            //       ],
            //     )),
            // SizedBox(
            //   height: 8,
            // ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: Container(
            //         // height: 20,
            //         // margin: EdgeInsets.symmetric(horizontal: 5),
            //         // width: 80,
            //         child: Center(
            //           child: Text(
            //             'MatchUp',
            //             style: TextStyle(
            //               color: Appcolor.whitecolor,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 14,
            //               letterSpacing: 0.5,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //         flex: 2,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Expanded(
            //               child: Container(
            //                 // width: 80,
            //                 child: Center(
            //                   child: Text(
            //                     'Spreads',
            //                     style: TextStyle(
            //                       color: Appcolor.whitecolor,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 14,
            //                       letterSpacing: 0.5,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Expanded(
            //               child: Container(
            //                 // width: 80,
            //                 child: Center(
            //                   child: Text(
            //                     'Totals',
            //                     style: TextStyle(
            //                       color: Appcolor.whitecolor,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 14,
            //                       letterSpacing: 0.5,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Expanded(
            //               child: Container(
            //                 // width: 80,
            //                 child: Center(
            //                   child: Text(
            //                     'H2H',
            //                     style: TextStyle(
            //                       color: Appcolor.whitecolor,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 14,
            //                       letterSpacing: 0.5,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ))
            //   ],
            // ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.data.homeTeam.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Appcolor.blackcolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.all(2),
                            color: Appcolor.whitecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              height: 40,
                              // width: 80,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Center(
                                child: Text(
                                  widget.bookmaker.markets!.any(
                                          (element) => element.key == "spreads")
                                      ? widget.bookmaker.markets![spreadsindex]
                                          .outcomes![0].point
                                          .toString()
                                      : "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Appcolor.blackcolor
                                      // letterSpacing: 0.5,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.all(2),
                            color: Appcolor.whitecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              height: 40,
                              // width: 80,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.bookmaker.markets!.any((element) =>
                                            element.key == "totals")
                                        ? widget.bookmaker.markets![totalindex]
                                            .outcomes![0].point
                                            .toString()
                                        : "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Appcolor.blackcolor
                                        // letterSpacing: 0.5,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    widget.bookmaker.markets!.any((element) =>
                                            element.key == "totals")
                                        ? widget.bookmaker.markets![totalindex]
                                            .outcomes![0].price
                                            .toString()
                                        : "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Appcolor.secondarycolor,
                                      fontSize: 12,
                                      // letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.all(2),
                            color: Appcolor.whitecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              height: 40,
                              // width: 80,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 13),
                              child: Center(
                                child: Text(
                                  widget.bookmaker.markets!.any(
                                          (element) => element.key == "h2h")
                                      ? widget.bookmaker.markets![h2hsindex]
                                          .outcomes![0].price
                                          .toString()
                                      : "".toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Appcolor.blackcolor
                                      // letterSpacing: 0.5,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Divider(
                      color: Appcolor.whitecolor,
                      height: 1,
                      thickness: 1,
                    ),
                  ),
                  const Expanded(flex: 2, child: SizedBox())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.data.awayTeam.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Appcolor.blackcolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        // letterSpacing: 0.5
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.all(2),
                            color: Appcolor.whitecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Center(
                                child: Text(
                                  widget.bookmaker.markets!.any(
                                          (element) => element.key == "spreads")
                                      ? widget.bookmaker.markets![spreadsindex]
                                          .outcomes![1].point
                                          .toString()
                                      : "".toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Appcolor.blackcolor
                                      // letterSpacing: 0.5,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Appcolor.whitecolor,
                            margin: const EdgeInsets.all(2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              height: 40,

                              // width: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.bookmaker.markets!.any((element) =>
                                            element.key == "totals")
                                        ? widget.bookmaker.markets![totalindex]
                                            .outcomes![1].point
                                            .toString()
                                        : "".toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Appcolor.blackcolor
                                        // letterSpacing: 0.5,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    widget.bookmaker.markets!.any((element) =>
                                            element.key == "totals")
                                        ? widget.bookmaker.markets![totalindex]
                                            .outcomes![1].price
                                            .toString()
                                        : "".toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Appcolor.secondarycolor
                                        // letterSpacing: 0.5,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Appcolor.whitecolor,
                            margin: const EdgeInsets.all(2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              height: 40,
                              // width: 80,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Center(
                                child: Text(
                                  widget.bookmaker.markets!.any(
                                          (element) => element.key == "h2h")
                                      ? widget.bookmaker.markets![h2hsindex]
                                          .outcomes![1].price
                                          .toString()
                                      : "".toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Appcolor.blackcolor
                                      // letterSpacing: 0.5,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
          ],
        ),
      ),
    );

    // Card(
    //   margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   elevation: 2,
    //   color: Appcolor.whitecolor,
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: 8.0),
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 8,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Expanded(
    //               flex: 1,
    //               child: Container(
    //                 // width: 110,
    //                 child: Text(
    //                   data.homeTeam.toString(),
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               flex: 2,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Card(
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Container(
    //                       height: 40,
    //                       // width: 80,
    //                       padding: EdgeInsets.symmetric(
    //                           vertical: 10, horizontal: 13),
    //                       child: Center(
    //                         child: Text(
    //                           bookmaker.markets![1].outcomes![0].point
    //                               .toString(),
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 12,
    //                             // letterSpacing: 0.5,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Card(
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Container(
    //                       height: 40,
    //                       // width: 80,
    //                       padding: EdgeInsets.symmetric(horizontal: 13),
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             bookmaker.markets![2].outcomes![0].point
    //                                 .toString(),
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 12,
    //                               // letterSpacing: 0.5,
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 2,
    //                           ),
    //                           Text(
    //                             bookmaker.markets![2].outcomes![0].price
    //                                 .toString(),
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               color: Appcolor.secondaryblueColor,
    //                               fontSize: 12,
    //                               // letterSpacing: 0.5,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Card(
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Container(
    //                       height: 40,
    //                       // width: 80,
    //                       padding: EdgeInsets.symmetric(
    //                           vertical: 10, horizontal: 13),
    //                       child: Center(
    //                         child: Text(
    //                           bookmaker.markets![0].outcomes![0].price
    //                               .toString(),
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 12,
    //                             // letterSpacing: 0.5,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Expanded(
    //               flex: 1,
    //               child: Container(
    //                 child: Text(
    //                   data.awayTeam.toString(),
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 12,
    //                     // letterSpacing: 0.5
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               flex: 2,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 mainAxisSize: MainAxisSize.max,
    //                 children: [
    //                   Card(
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Container(
    //                       height: 40,
    //                       padding: EdgeInsets.symmetric(
    //                           vertical: 10, horizontal: 13),
    //                       child: Center(
    //                         child: Text(
    //                           bookmaker.markets![1].outcomes![0].point
    //                               .toString(),
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 12,
    //                             // letterSpacing: 0.5,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Card(
    //                     margin: EdgeInsets.all(5),
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Container(
    //                       height: 40,
    //                       padding: EdgeInsets.symmetric(horizontal: 13),
    //                       // width: 80,
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             bookmaker.markets![2].outcomes![1].point
    //                                 .toString(),
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 12,
    //                               // letterSpacing: 0.5,
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 2,
    //                           ),
    //                           Text(
    //                             bookmaker.markets![2].outcomes![1].price
    //                                 .toString(),
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               color: Appcolor.secondaryblueColor,
    //                               fontSize: 12,
    //                               // letterSpacing: 0.5,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Card(
    //                     margin: EdgeInsets.all(5),
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Container(
    //                       height: 40,
    //                       // width: 80,
    //                       padding: EdgeInsets.symmetric(
    //                           vertical: 10, horizontal: 13),
    //                       child: Center(
    //                         child: Text(
    //                           bookmaker.markets![0].outcomes![1].price
    //                               .toString(),
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 12,
    //                             // letterSpacing: 0.5,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           children: [
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Text(
    //               dateFormat.format(data.commenceTime!),
    //               style: TextStyle(
    //                 color: Appcolor.secondaryblueColor,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 14,
    //                 // letterSpacing: 0.5,
    //               ),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 8,
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    // Container(
    //   margin: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 5.0),
    //   decoration: BoxDecoration(
    //       border: Border.all(width: 1, color: const Color(0xff505050)),
    //       borderRadius: BorderRadius.circular(15)),
    //   child: Card(
    //     color: const Color(0xff505050),
    //     margin: EdgeInsets.zero,
    //     elevation: 0,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //     child: SizedBox(
    //       height: 100,
    //       width: MediaQuery.of(context).size.width,
    //       child: Row(
    //         children: [
    //           Container(
    //             width: MediaQuery.of(context).size.width * 0.6,
    //             padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     CircleAvatar(
    //                         radius: 18,
    //                         backgroundImage: NetworkImage(
    //                             'http://games.ioio.ca${data.homeTeamLogo}')),
    //                     const SizedBox(
    //                       width: 5,
    //                     ),
    //                     SizedBox(
    //                       width: MediaQuery.of(context).size.width * 0.45,
    //                       child: Text(
    //                         data.homeTeam!,
    //                         textAlign: TextAlign.start,
    //                         maxLines: 1,
    //                         overflow: TextOverflow.ellipsis,
    //                         style: const TextStyle(
    //                             fontSize: 14,
    //                             color: Colors.white,
    //                             fontFamily: 'semibold'),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     CircleAvatar(
    //                         radius: 18,
    //                         backgroundImage: NetworkImage(
    //                             'http://games.ioio.ca${data.awayTeamLogo}')),
    //                     const SizedBox(
    //                       width: 5,
    //                     ),
    //                     SizedBox(
    //                       width: MediaQuery.of(context).size.width * 0.45,
    //                       child: Text(
    //                         data.awayTeam!,
    //                         textAlign: TextAlign.start,
    //                         maxLines: 1,
    //                         overflow: TextOverflow.ellipsis,
    //                         style: const TextStyle(
    //                             fontSize: 14,
    //                             color: Colors.white,
    //                             fontFamily: 'semibold'),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             width: MediaQuery.of(context).size.width * 0.35,
    //             padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
    //             child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 children: [
    //                   Container(
    //                     padding: const EdgeInsets.symmetric(
    //                         horizontal: 10, vertical: 3),
    //                     decoration: BoxDecoration(
    //                         border: Border.all(width: 1, color: Colors.white),
    //                         borderRadius: BorderRadius.circular(20)),
    //                     child: Text(
    //                       "${data.commenceTime.toString().split(' ').last.split(":").first}:${data.commenceTime.toString().split(' ').last.split(":")[1]}${timelength == 4 ? '' : ":00"}",
    //                       //2023-04-13T01:51:54Z
    //                       // "${data.commenceTime.toString().split(" ").last.split(":00").first}${timelength == 5 ? '' : ":00"}",
    //                       style: const TextStyle(
    //                         fontSize: 15,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                   Text(
    //                     dateFormat.format(data.commenceTime!),
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: const TextStyle(
    //                       fontSize: 12,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ]),
    //           ),
    //         ],
    //       ),
    //       // child:
    //       //  Row(
    //       //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       //   children: [
    //       //     SizedBox(
    //       //       width: MediaQuery.of(context).size.width * 0.3,
    //       //       child: Column(
    //       //         mainAxisSize: MainAxisSize.min,
    //       //         children: [
    //       //           CircleAvatar(
    //       //             backgroundColor: Colors.white,
    //       //             radius: 25,
    //       //             backgroundImage: NetworkImage(
    //       //                 'http://games.ioio.ca${data.homeTeamLogo}'),
    //       //           ),
    //       //           Padding(
    //       //             padding: const EdgeInsets.only(top: 5),
    //       //             child: Text(
    //       //               data.homeTeam!,
    //       //               textAlign: TextAlign.center,
    //       //               maxLines: 1,
    //       //               style: TextStyle(
    //       //                   fontSize: 13,
    //       //                   color: Colors.grey.shade700,
    //       //                   fontFamily: 'semibold'),
    //       //             ),
    //       //           ),
    //       //         ],
    //       //       ),
    //       //     ),
    //       //     Container(
    //       //       padding:
    //       //           const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    //       //       decoration: BoxDecoration(
    //       //           border: Border.all(width: 1, color: Colors.grey.shade200),
    //       //           borderRadius: BorderRadius.circular(5)),
    //       //       child: Text(
    //       //         "${data.commenceTime.toString().split(" ").last.split(":00").first}${timelength == 5 ? '' : ":00"}",
    //       //         style: const TextStyle(
    //       //           fontSize: 15,
    //       //           color: Colors.grey,
    //       //         ),
    //       //       ),
    //       //     ),
    //       //     SizedBox(
    //       //       width: MediaQuery.of(context).size.width * 0.3,
    //       //       child: Column(
    //       //         mainAxisSize: MainAxisSize.min,
    //       //         children: [
    //       //           CircleAvatar(
    //       //             backgroundColor: Colors.white,
    //       //             radius: 25,
    //       //             backgroundImage: NetworkImage(
    //       //                 'http://games.ioio.ca/${data.awayTeamLogo}'),
    //       //           ),
    //       //           Padding(
    //       //             padding: const EdgeInsets.only(top: 5),
    //       //             child: Text(
    //       //               data.awayTeam!,
    //       //               textAlign: TextAlign.center,
    //       //               maxLines: 1,
    //       //               style: TextStyle(
    //       //                   fontSize: 13,
    //       //                   color: Colors.grey.shade700,
    //       //                   fontFamily: 'semibold'),
    //       //             ),
    //       //           ),
    //       //         ],
    //       //       ),
    //       //     ),
    //       //   ],
    //       // ),
    //     ),
    //   ),
    // );
  }
}
