// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/Pages/AuthPage/SignInPage.dart';
import 'package:food_delivery_app/Pages/AuthPage/SignUpPage.dart';
import 'package:get/get.dart';

import '../../Pages/AuthPage/reset_password.dart';
import '../../Pages/Splash Screen/Splash Screen.dart';
const String splash = "/splash_screen";
const String signUp = "/sign-up-screen";
const String signIn = "/sign-in-screen";
const String resetPassword = "/reset_password.dart";

late User _user;
List<GetPage> getPages = [
  GetPage(name: splash, page: () =>SplashScreen()),
  GetPage(name: signUp, page: () => SignUpPage()),
  GetPage(name: signIn, page: () => SignInPage()),
  GetPage(name: resetPassword, page: () => ResetPassword()),
];