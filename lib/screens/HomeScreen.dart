// ignore_for_file: file_names

import 'dart:developer';
import 'package:bet_mobile/models/MatchesResponse.dart';
import 'package:bet_mobile/models/OddsModel.dart';
import 'package:bet_mobile/models/StringModel.dart';
import 'package:bet_mobile/providers/config.dart';
import 'package:bet_mobile/providers/providers.dart';
import 'package:bet_mobile/screens/FixtureScreen.dart';
import 'package:bet_mobile/screens/NewsScreen.dart';
import 'package:bet_mobile/screens/OddsScree.dart';
import 'package:bet_mobile/screens/ResultsScreen.dart';
import 'package:bet_mobile/screens/SettingScreen.dart';
import 'package:bet_mobile/screens/TermsOfUse.dart';
import 'package:bet_mobile/screens/contact_us_page.dart';
import 'package:bet_mobile/widgets/Banner.dart';
import 'package:bet_mobile/widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PrivacyPolicy.dart';

int _currentIndex = 0;
int _selectedIndex = 1;
String title = "Fixture";
ScrollController scrollController = ScrollController();

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  List<List<MatchesResponseModel>> soccerFixturesList = [];
  DateFormat dateFormat = DateFormat('EEEE d MMMM');
  List<DateTime> dates = [];
  List<MatchesResponseModel> soccerResultsList = [];
  List<List<ScroreModel>> soccerOddsList = [];
  List<List<Bookmaker>> bookmaker = [];

  bool fixtureBreakCode = true;
  bool resultsBreakCode = true;
  bool oddsBreakCode = true;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  fetchDataForFixture(String value) async {
    soccerFixturesList.clear();
    await ref.read(fixtureProvider).getScore(tabelName: value);
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
    }
    log('njsdkbnfvcsuivsbhvuisv57 $selectedFeild');
    log('njsdkbnfvcsuivsbhvuisv57 $_currentIndex');

    setState(() {});
  }

  fetchDataResults(String value) async {
    soccerResultsList.clear();
    await ref.read(fixtureProvider).getScore(tabelName: value);
    for (var i = 0; i < ref.read(fixtureProvider).scoreList.length; i++) {
      ref.read(fixtureProvider).scoreList[i].completed == "True"
          ? soccerResultsList.add(ref.read(fixtureProvider).scoreList[i])
          : null;
    }
    setState(() {});
  }

  fetchDataOdds(String value) async {
    bookmaker.clear();
    soccerOddsList.clear();

    await ref.read(oddsProvider).getScore(tabelName: value);
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
            soccerOddsList[index].add(ref.read(oddsProvider).scoreList[i]);
          } else {
            dates.add(ref.read(oddsProvider).scoreList[i].commenceTime!);
            bookmaker.add([ref.read(oddsProvider).scoreList[i].bookmakers![j]]);
            soccerOddsList.add([ref.read(oddsProvider).scoreList[i]]);
          }
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkIndexForFixture(true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      key: drawerKey,
      body:
          // _selectedIndex == 4 || _selectedIndex == 5
          //     ? _selectedIndex == 4
          //         ? const PrivacyPolicy()
          //         : const TermsOfUse()
          //     :
          SafeArea(
        child: Column(children: [
          BannerView(),
          _selectedIndex == 0 ||
                  _selectedIndex == 4 ||
                  _selectedIndex == 5 ||
                  _selectedIndex == 6
              ? Container()
              : Container(
                  decoration: BoxDecoration(color: Appcolor.whitecolor),
                  margin: const EdgeInsets.only(top: 10),
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    // controller: scrollController,
                    itemCount: stringList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => setState(() {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const HomeScreen(),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                                selectedFeild = stringList[index].apiend;
                                _currentIndex = index;
                                log('kkdfdjf' + _currentIndex.toString());
                                log('dsghdfghg ' + selectedFeild.toString());
                                // _currentIndex >= 2
                                //     ? scrollController.jumpTo(
                                //         200 + (_currentIndex / 2) * 10)
                                //     : scrollController.jumpTo(0);
                                // _currentIndex >= 2
                                //     ? scrollController = ScrollController(
                                //         initialScrollOffset: 105)
                                //     : scrollController = ScrollController(
                                //         initialScrollOffset: 0);
                              }),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                    ),
                                    // padding: const EdgeInsets.symmetric(
                                    //     horizontal: 18),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          child: ClipRRect(
                                            child: SvgPicture.asset(
                                              stringList[index].assets,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                          child: Text(
                                            stringList[index].title,
                                            style: const TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w400,
                                                color: Appcolor.blackcolor,
                                                letterSpacing: 0.5),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  index != stringList.length - 1
                                      ? const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: SizedBox(
                                              height: double.infinity,
                                              child: VerticalDivider(
                                                width: 1,
                                                thickness: 1,
                                                color: Appcolor.betSoftGrey,
                                              )),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              _currentIndex == index
                                  ? Positioned(
                                      bottom: -18,
                                      child: Transform.rotate(
                                        angle: 3.14159 / 4,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          color: Appcolor.betNavy,
                                        ),
                                      ))
                                  : SizedBox()
                            ],
                          )
                          //  Container(
                          //   margin: EdgeInsets.only(
                          //       bottom: 2, left: 10, right: index == 3 ? 10 : 0),
                          //   height: 45,
                          //   padding: const EdgeInsets.symmetric(horizontal: 15),
                          //   decoration: BoxDecoration(
                          //       border: Border.all(
                          //           width: 2,
                          //           color: _currentIndex == index
                          //               ? Appcolor.secondarycolor
                          //               : Appcolor.whitecolor),
                          //       color: _currentIndex == index
                          //           ? Appcolor.secondarycolor
                          //           : Appcolor.primaryColor,
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: Center(
                          //       child: Text(
                          //     stringList[index].title,
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         color: Appcolor.whitecolor,
                          //         letterSpacing: 0.5),
                          //   )),
                          // ),
                          );
                    },
                  ),
                ),
          // Card(
          //   margin: EdgeInsets.zero,
          //   elevation: 1,
          //   child: ListTile(
          //     tileColor: Color(0xff505050),
          //     horizontalTitleGap: 5,
          //     leading: GestureDetector(
          //         onTap: () {
          //           drawerKey.currentState!.openDrawer();
          //         },
          //         child: SvgPicture.asset(
          //           'assets/svg/menu.svg',
          //           color: Colors.white,
          //         )),
          //     title: Text(
          //       selectedFeild,
          //       style: const TextStyle(
          //         fontFamily: 'semibold',
          //         fontSize: 17,
          //         color: Colors.white,
          //       ),
          //     ),
          //     trailing: Text(
          //       selectedFeild.split("_").last.toUpperCase(),
          //       style: const TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),

          if (_selectedIndex == 1) FixtureScreen(field: selectedFeild),
          if (_selectedIndex == 2)
            ResultScreen(
              field: selectedFeild,
              title: stringList[_currentIndex].title,
            ),
          if (_selectedIndex == 3) OddsScreen(field: selectedFeild),
          if (_selectedIndex == 0) const NewsScreen(),
          if (_selectedIndex == 4) const ContactUsPage(),
          if (_selectedIndex == 5) const PrivacyPolicy(),
          if (_selectedIndex == 6) const TermsOfUse(),

          // if (_selectedIndex == 4) const SettingScreen(),
        ]),
      ),
      drawer: Drawer(
        backgroundColor: Appcolor.primaryColor,
        elevation: 4,
        width: size.width * 0.5,
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: ListTile(
            //     onTap: () {
            //       _selectedIndex = 0;
            //       title = 'News';
            //       setState(() {});
            //       drawerKey.currentState!.closeDrawer();
            //     },
            //     selected: _selectedIndex == 0 ? true : false,
            //     selectedColor: Appcolor.greycolor,
            //     shape: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: BorderSide(
            //             color: _selectedIndex == 0
            //                 ? Appcolor.secondarycolor
            //                 : Appcolor.transparentcolor)),
            //     title: Text(
            //       'News',
            //       style: TextStyle(
            //           color: _selectedIndex == 0
            //               ? Appcolor.secondarycolor
            //               : Appcolor.greycolor),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                onTap: () {
                  checkIndexForFixture(fixtureBreakCode);
                  _selectedIndex = 1;
                  title = "Fixtures";
                  setState(() {});
                  drawerKey.currentState!.closeDrawer();
                },
                selected: _selectedIndex == 1 ? true : false,
                selectedColor: Appcolor.greycolor,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: _selectedIndex == 1
                            ? Appcolor.secondarycolor
                            : Appcolor.transparentcolor)),
                title: Text(
                  'Fixtures',
                  style: TextStyle(
                      color: _selectedIndex == 1
                          ? Appcolor.whitecolor
                          : Appcolor.greycolor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                onTap: () {
                  checkIndexForResults(resultsBreakCode);
                  _selectedIndex = 2;
                  title = 'Results';
                  setState(() {});
                  drawerKey.currentState!.closeDrawer();
                },
                selected: _selectedIndex == 2 ? true : false,
                selectedColor: Appcolor.greycolor,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: _selectedIndex == 2
                            ? Appcolor.secondarycolor
                            : Appcolor.transparentcolor)),
                title: Text(
                  'Results',
                  style: TextStyle(
                      color: _selectedIndex == 2
                          ? Appcolor.secondarycolor
                          : Appcolor.greycolor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                onTap: () {
                  checkIndexForOdds(oddsBreakCode);

                  _selectedIndex = 3;
                  title = 'Odds';
                  setState(() {});
                  drawerKey.currentState!.closeDrawer();
                },
                selected: _selectedIndex == 3 ? true : false,
                selectedColor: Appcolor.greycolor,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: _selectedIndex == 3
                            ? Appcolor.secondarycolor
                            : Appcolor.transparentcolor)),
                title: Text(
                  'Odds',
                  style: TextStyle(
                      color: _selectedIndex == 3
                          ? Appcolor.secondarycolor
                          : Appcolor.greycolor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                onTap: () {
                  _selectedIndex = 4;
                  title = 'Contact Us';
                  setState(() {});
                  Navigator.pop(context);

                  drawerKey.currentState!.closeDrawer();
                },
                selected: _selectedIndex == 4 ? true : false,
                selectedColor: Appcolor.greycolor,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: _selectedIndex == 4
                            ? Appcolor.secondarycolor
                            : Appcolor.transparentcolor)),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                      color: _selectedIndex == 4
                          ? Appcolor.secondarycolor
                          : Appcolor.greycolor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                onTap: () {
                  _selectedIndex = 5;
                  title = 'Privacy Policy';
                  setState(() {});
                  // _launchUrl(
                  //     "https://help.betonline.ag/knowledge-base/privacy-policy/");
                  Navigator.pop(context);

                  drawerKey.currentState!.closeDrawer();
                },
                selected: _selectedIndex == 5 ? true : false,
                selectedColor: Appcolor.greycolor,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: _selectedIndex == 5
                            ? Appcolor.secondarycolor
                            : Appcolor.transparentcolor)),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(
                      color: _selectedIndex == 5
                          ? Appcolor.secondarycolor
                          : Appcolor.greycolor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                onTap: () {
                  _selectedIndex = 6;
                  title = 'Terms Of Use';
                  setState(() {});
                  Navigator.pop(context);
                  drawerKey.currentState!.closeDrawer();
                },
                selected: _selectedIndex == 6 ? true : false,
                selectedColor: Appcolor.greycolor,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: _selectedIndex == 6
                            ? Appcolor.secondarycolor
                            : Appcolor.transparentcolor)),
                title: Text(
                  'Terms Of Use',
                  style: TextStyle(
                      color: _selectedIndex == 6
                          ? Appcolor.secondarycolor
                          : Appcolor.greycolor),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: FlashyTabBar(
      //   backgroundColor: Appcolor.primaryColor,
      //   selectedIndex: _selectedIndex,
      //   showElevation: true,
      //   onItemSelected: (index) => setState(() {
      //     _selectedIndex = index;
      //   }),
      //   items: [
      //     FlashyTabBarItem(
      //       activeColor: Appcolor.whitecolor,
      //       inactiveColor: Appcolor.greycolor,
      //       icon: Text(
      //         'Fixtures',
      //         style: TextStyle(color: Appcolor.greycolor),
      //       ),
      //       title: Text(
      //         'Fixtures',
      //         style: TextStyle(color: Appcolor.whitecolor),
      //       ),
      //     ),
      //     FlashyTabBarItem(
      //       activeColor: Appcolor.whitecolor,
      //       inactiveColor: Appcolor.greycolor,
      //       icon: Text(
      //         'Results',
      //         style: TextStyle(color: Appcolor.greycolor),
      //       ),
      //       title: Text(
      //         'Results',
      //         style: TextStyle(color: Appcolor.whitecolor),
      //       ),
      //     ),
      //     FlashyTabBarItem(
      //       activeColor: Appcolor.whitecolor,
      //       inactiveColor: Appcolor.greycolor,
      //       icon: Text(
      //         'Odds',
      //         style: TextStyle(color: Appcolor.greycolor),
      //       ),
      //       title: Text(
      //         'Odds',
      //         style: TextStyle(color: Appcolor.whitecolor),
      //       ),
      //     ),
      //     FlashyTabBarItem(
      //       activeColor: Appcolor.whitecolor,
      //       inactiveColor: Appcolor.greycolor,
      //       icon: Text(
      //         'News',
      //         style: TextStyle(color: Appcolor.greycolor),
      //       ),
      //       title: Text(
      //         'News',
      //         style: TextStyle(color: Appcolor.whitecolor),
      //       ),
      //     ),
      //     FlashyTabBarItem(
      //       activeColor: Appcolor.whitecolor,
      //       inactiveColor: Appcolor.greycolor,
      //       icon: Text(
      //         'Setting',
      //         style: TextStyle(color: Appcolor.greycolor),
      //       ),
      //       title: Text(
      //         'Setting',
      //         style: TextStyle(color: Appcolor.whitecolor),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  //
  checkIndexForFixture(bool valueOfScreen) async {
    _currentIndex = 0;
    selectedFeild = stringList[0].apiend;

    valueOfScreen
        ? {
            await fetchDataForFixture(stringList[0].apiend),
            if (soccerFixturesList.isEmpty)
              {
                log('njsdkbnfvcsuivsbhvuisv1 ' + soccerFixturesList.toString()),
                // _currentIndex = 1,
                selectedFeild = stringList[1].apiend,
                await fetchDataForFixture(stringList[1].apiend),
                log('njsdkbnfvcsuivsbhvuisv122 ' +
                    soccerFixturesList.toString()),
                log('njsdkbnfvcsuivsbhvuisv2'),
                if (soccerFixturesList.isEmpty)
                  {
                    log('njsdkbnfvcsuivsbhvuisv3 ' +
                        soccerFixturesList.toString()),
                    _currentIndex = 2,
                    selectedFeild = stringList[2].apiend,
                    await fetchDataForFixture(stringList[2].apiend),
                    if (soccerFixturesList.isEmpty)
                      {
                        log('njsdkbnfvcsuivsbhvuisv4 ' +
                            soccerFixturesList.toString()),
                        _currentIndex = 3,
                        selectedFeild = stringList[3].apiend,
                        log('njsdkbnfvcsuivsbhvuisv5 ' +
                            soccerFixturesList.toString()),
                        await fetchDataForFixture(stringList[3].apiend),
                        if (soccerFixturesList.isEmpty)
                          {
                            _currentIndex = 1,
                            selectedFeild = stringList[1].apiend,
                          },
                      }
                    else
                      {
                        log('njsdkbnfvcsuivsbhvuisv6'),
                        _currentIndex = 2,
                        selectedFeild = stringList[2].apiend,
                        setState(() {}),
                      },
                  }
                else
                  {
                    log('njsdkbnfvcsuivsbhvuisv7 '),
                    _currentIndex = 1,
                    selectedFeild = stringList[1].apiend,
                    setState(() {}),
                  },
              }
            else
              {
                log('njsdkbnfvcsuivsbhvuisv8'),
                log('njsdkbnfvcsuivsbhvuisv9 ' + soccerFixturesList.toString()),
                _currentIndex = 0,
                selectedFeild = stringList[0].apiend,
                setState(() {}),
              },
          }
        : {};

    log('foiughsduifbgdsuifbui $selectedFeild');
    log('foiughsduifbgdsuifbui $_currentIndex');
  }

  checkIndexForResults(bool valueOfScreen) async {
    _currentIndex = 0;
    selectedFeild = stringList[0].apiend;

    // soccerFixturesList = [];
    valueOfScreen
        ? {
            await fetchDataResults(stringList[0].apiend),
            if (soccerResultsList.isEmpty)
              {
                log('ghcghcvghcghh1 ' + soccerResultsList.toString()),
                _currentIndex = 1,
                selectedFeild = stringList[1].apiend,
                await fetchDataResults(stringList[1].apiend),
                log('uhfuidbhsfuijh'),
                if (soccerResultsList.isEmpty)
                  {
                    log('ghcghcvghcghh2 ' + soccerResultsList.toString()),
                    _currentIndex = 2,
                    selectedFeild = stringList[2].apiend,
                    await fetchDataResults(stringList[2].apiend),
                    if (soccerResultsList.isEmpty)
                      {
                        log('ghcghcvghcghh3 ' + soccerResultsList.toString()),
                        _currentIndex = 3,
                        selectedFeild = stringList[3].apiend,
                        log('ghcghcvghcghh 4' + soccerResultsList.toString()),
                        await fetchDataResults(stringList[3].apiend),
                        if (soccerResultsList.isEmpty)
                          {
                            _currentIndex = 1,
                            selectedFeild = stringList[1].apiend,
                          },
                      }
                    else
                      {
                        log('ujfikdsfbghjsfbgui1'),
                        _currentIndex = 2,
                        selectedFeild = stringList[2].apiend,
                      },
                  }
                else
                  {
                    log('ujfikdsfbghjsfbgui2'),
                    _currentIndex = 1,
                    selectedFeild = stringList[1].apiend,
                  },
              }
            else
              {
                log('ujfikdsfbghjsfbgui3'),
                log('ghcghcvghcghh-1 ' + soccerResultsList.toString()),
                _currentIndex = 0,
                selectedFeild = stringList[0].apiend,
                // setState(() {}),
              },
          }
        : {};
  }

  checkIndexForOdds(bool valueOfScreen) async {
    _currentIndex = 0;
    selectedFeild = stringList[0].apiend;

    valueOfScreen
        ? {
            await fetchDataOdds(stringList[0].apiend),
            if (soccerOddsList.isEmpty)
              {
                log('ghcghcvghcghh1 ' + soccerOddsList.toString()),
                _currentIndex = 1,
                selectedFeild = stringList[1].apiend,
                await fetchDataOdds(stringList[1].apiend),
                log('uhfuidbhsfuijh'),
                if (soccerOddsList.isEmpty)
                  {
                    log('ghcghcvghcghh2 ' + soccerOddsList.toString()),
                    _currentIndex = 2,
                    selectedFeild = stringList[2].apiend,
                    await fetchDataOdds(stringList[2].apiend),
                    if (soccerOddsList.isEmpty)
                      {
                        log('ghcghcvghcghh3 ' + soccerOddsList.toString()),
                        _currentIndex = 3,
                        selectedFeild = stringList[3].apiend,
                        log('ghcghcvghcghh 4' + soccerOddsList.toString()),
                        await fetchDataOdds(stringList[3].apiend),
                        if (soccerOddsList.isEmpty)
                          {
                            _currentIndex = 1,
                            selectedFeild = stringList[1].apiend,
                          },
                      }
                    else
                      {
                        log('ujfikdsfbghjsfbgui1'),
                        _currentIndex = 2,
                        selectedFeild = stringList[2].apiend,
                      },
                  }
                else
                  {
                    log('ujfikdsfbghjsfbgui2'),
                    _currentIndex = 1,
                    selectedFeild = stringList[1].apiend,
                  },
              }
            else
              {
                log('ujfikdsfbghjsfbgui3'),
                log('ghcghcvghcghh-1 ' + soccerOddsList.toString()),
                _currentIndex = 0,
                selectedFeild = stringList[0].apiend,
                // setState(() {}),
              },
          }
        : {};
  }
}
