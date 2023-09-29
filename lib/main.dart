import 'package:bet_mobile/screens/splashScreen.dart';
import 'package:bet_mobile/widgets/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BetUs',
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          primarySwatch: Appcolor.primarySwatch,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
