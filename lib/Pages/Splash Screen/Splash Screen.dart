// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isEmailVerified() {
    final user = _auth.currentUser;
    return user != null && user.emailVerified;
  }

  @override
  void initState() {
    super.initState();
    checkEmailVerification();
  }

  Future<void> checkEmailVerification() async {
    // final bool verified = isEmailVerified();

    if (user != null ) {
      Timer(const Duration(seconds: 1),
          () => Navigator.pushNamed(context, "homePage"));
    } else {
      Timer(const Duration(seconds: 1),
          () => Navigator.pushNamed(context, "signIn"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 213),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // !----------logo------------
            Image.asset(
              "assets/logo.png",
              height: 300.h,
            ),

            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
