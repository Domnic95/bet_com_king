// ignore_for_file: file_names

import 'dart:async';
import 'package:bet_mobile/screens/HomeScreen.dart';
import 'package:bet_mobile/widgets/Colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      },
    );
    return Scaffold(
        backgroundColor: Appcolor.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/image/applogo.png',
                height: 200,
              ),
            )
          ],
        ));
  }
}
