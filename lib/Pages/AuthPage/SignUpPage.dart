// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_element, avoid_unnecessary_containers

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/utils/routes/route.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../controllers/text_field_controller.dart';
import '../../Widget/violetButton.dart';
import '../../data/auth.dart';
import '../../main.dart';
import '../../styles/styles.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // !--------------textfield------------------
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // !-------------------auth controller----------------
  final authController = Get.put(AuthController());
  final _controller = Get.put(TextFieldController());

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  // !------------------validation----------------
  bool _validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  bool _validatePhoneNumber(String phoneNumber) {
    return phoneNumber.isNotEmpty && phoneNumber.length >= 11;
  }

  bool _validateAddress(String address) {
    return address.isNotEmpty && address.isNotEmpty;
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox("", "");
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 35.sp,
                      color: const Color(0xFF21899C),
                      letterSpacing: 2.000000061035156,
                    ),
                    children: const [
                      TextSpan(
                        text: 'SIGNUP',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: 'PAGE',
                        style: TextStyle(
                          color: Color(0xFFFE9879),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Let’s signup for explore continues',
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    color: const Color(0xFF969AA8),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),

                   // !----------------------Name Field------------------------
                TextFormField(
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                     color: themeManager.themeMode == ThemeMode.light
                        ? const Color(0xFF151624)
                        : Colors.white,
                  ),
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      AppStyle().textFieldDecoration("Name", Icons.person),
                ),
                SizedBox(
                  height: 15.h,
                ),

                // !----------------------Email Field------------------------
                TextFormField(
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: themeManager.themeMode == ThemeMode.light
                        ? const Color(0xFF151624)
                        : Colors.white,
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppStyle()
                      .textFieldDecoration("Enter your email", Icons.mail),
                ),
                SizedBox(
                  height: 15.h,
                ),

                // !----------------------Password Field------------------------
                Obx(() {
                  return TextFormField(
                    style: GoogleFonts.inter(
                      fontSize: 18.0,
                      color: themeManager.themeMode == ThemeMode.light
                          ? const Color(0xFF151624)
                          : Colors.white,
                    ),
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themeManager.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeManager.themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      hintText: "Password",
                      hintStyle: GoogleFonts.inter(
                        fontSize: 16.0,
                        color: const Color(0xFFABB3BB),
                        height: 1.0,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.isPasswordHiden.value
                             ? Icons.visibility_off
                              : Icons.visibility,
                           color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black45
                              : Colors.white,
                        ),
                        onPressed: () {
                          _controller.isPasswordHiden.value =
                              !_controller.isPasswordHiden.value;
                        },
                      ),
                    ),
                    obscureText: _controller.isPasswordHiden.value,
                    validator: (value) {
                      if (!_validatePassword(value ?? '')) {
                        return 'Invalid password';
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black45
                            : Colors.white,),
                ),
                SizedBox(
                  height: 20.h,
                ),

                // !----------------------Create Buttom------------------------
                Obx(() {
                  return VioletButton(
                    isLoading: authController.isLoading.value,
                    title: 'Create Account',
                    onAction: () async {
                      if (_nameController.text.isEmpty) {
                        Get.snackbar('Error', 'Name is required');
                        return;
                      }

                      if (_emailController.text.isEmpty) {
                        Get.snackbar('Error', 'Email is required');
                        return;
                      }

                      if (_passwordController.text.isEmpty) {
                        Get.snackbar('Error', 'Password is required');
                        return;
                      }

                      authController.isLoading(true);

                      await authController.registration(
                        context: context,
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      authController.isLoading(false);
                    },
                  );
                }),
                SizedBox(height: 20.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already an account? ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        color: themeManager.themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      children: [
                        TextSpan(
                            text: "Sign In Here",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFFFF7248),
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(signIn)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDialogBox(String title, String message) => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
