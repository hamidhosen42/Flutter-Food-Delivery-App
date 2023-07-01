// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_final_fields, prefer_const_constructors, unused_local_variable, unused_element

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../Widget/violetButton.dart';
import '../../data/auth.dart';
import '../../styles/styles.dart';
import '../../controllers/text_field_controller.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // ! ------------- TextEditingController---------------
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // ! ------------- authController---------------
  final authController = Get.put(AuthController());
  final _controller = Get.put(TextFieldController());

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

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
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // !------------validation--------------
  bool _validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

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
                      fontSize: 35.0,
                      color: const Color(0xFF21899C),
                      letterSpacing: 2.000000061035156,
                    ),
                    children: const [
                      TextSpan(
                        text: 'LOGIN',
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
                  'Let’s login for explore continues',
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    color: const Color(0xFF969AA8),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),

                // !------------Email Text Field--------------
                TextFormField(
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: const Color(0xFF151624),
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppStyle()
                      .textFieldDecoration("Enter your email", Icons.mail),
                ),
                SizedBox(
                  height: 20.h,
                ),

                // !------------Password Text Field--------------
                Obx(() {
                  return TextFormField(
                    style: GoogleFonts.inter(
                      fontSize: 18.0,
                      color: const Color(0xFF151624),
                    ),
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
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
                          color: Colors.black45,
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
                // !------------Forgot Password--------------
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "resetPassword");
                        },
                        child: Text("Forgot Password?",
                            style:
                                TextStyle(color: Colors.red, fontSize: 15.sp))),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                // !----------------Sign In Buttom-------------
                Obx(() {
                  return VioletButton(
                    isLoading: authController.isLoading.value,
                    title: "Sign In",
                    onAction: () async {
                      if (_emailController.text.isEmpty) {
                        // Show an error message for invalid email
                        Get.snackbar('Error', 'Email is required');
                        return;
                      }

                      if (_passwordController.text.isEmpty) {
                        // Show an error message for invalid password
                        Get.snackbar('Error', 'Password is required');
                        return;
                      }

                      if ((_emailController.text == 'admin@gmail.com') &&
                          (_passwordController.text == 'admin')) {
                        // Get.toNamed(adminHome);
                      } else {
                        authController.isLoading(true);
                        await authController.userLogin(
                          context: context,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        authController.isLoading(false);
                      }
                    },
                  );
                }),
                SizedBox(height: 20.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don’t have an account? ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: "Sign Up Here",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFFFF7248),
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>Navigator.pushNamed(context, "signUp")),
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
