// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:food_delivery_app/res/app_string.dart';
import 'package:food_delivery_app/res/color.dart';
import 'package:food_delivery_app/utils/routes/route.dart';
import 'Pages/Splash Screen/Splash Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'theme/theme.dart';
import 'theme/theme_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

    Stripe.publishableKey =
      'pk_test_51L27YbK8JICyYw6jEoE5r8yiYV1s6mdUamcHJ9FJfvSe8EhRJzhRtGDwxdLLsZ4sbuCXms7heljCmPXfOnbJzwUQ00GchfnRDq';
      
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeManager themeManager = ThemeManager(ThemeMode.light);

class _MyAppState extends State<MyApp> {

    @override
  void dispose() {
    themeManager.removeListener(themelistener);

    super.dispose();
  }

  @override
  void initState() {
    themeManager.loadTheme();
    themeManager.addListener(themelistener);

    super.initState();
  }

    themelistener() {
    if (mounted) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
                          // theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeManager.themeMode,
            debugShowCheckedModeBanner: false,
            title: AppString.app_title,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.scaffold_background_color,
            ),
            initialRoute: splash,
            getPages: getPages,
            home: SplashScreen(),
          );
        });
  }
}
