// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/AuthPage/reset_password.dart';
import 'package:food_delivery_app/res/app_string.dart';
import 'package:food_delivery_app/res/color.dart';
import 'package:food_delivery_app/utils/routes/route.dart';

import 'Pages/AuthPage/SignInPage.dart';
import 'Pages/AuthPage/SignUpPage.dart';
import 'Pages/CardPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/ItemPage.dart';
import 'Pages/Splash Screen/Splash Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppString.app_title,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.scaffold_background_color,
            ),
            // getPages: getPages,
            routes: {
              "/": (context) => SplashScreen(),
              "signIn": (context) => SignInPage(),
              "signUp": (context) => SignUpPage(),
              "resetPassword": (context) => ResetPassword(),
              "homePage": (context) => HomePage(),
              "cartPage": (context) => CartPage(),
            },
          );
        });
  }
}
