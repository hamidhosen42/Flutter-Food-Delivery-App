// ignore_for_file: prefer_const_constructors, unused_import, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/utils/routes/route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/user_model.dart';

class AuthController extends GetxController {
  //for button loading indicator
  var isLoading = false.obs;

  Future registration({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Send email verification
        await userCredential.user!.sendEmailVerification();

        Fluttertoast.showToast(
            msg: 'Please check your email for verification.');

        // No redirect to home screen yet
        // After saving user info, check email verification status
        bool isEmailVerified = userCredential.user!.emailVerified;
        var authCredential = userCredential.user;

        UserModel userModel = UserModel(
          name: name,
          uid: userCredential.user!.uid,
          email: email,
          phoneNumber: "",
          address: "",
          image: "",
        );
        // Save user info in Firebase
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());

         Get.toNamed(signIn);
      } else {
        Fluttertoast.showToast(msg: 'Please enter all the fields');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Please enter a valid email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  //!--------------for user login------------
  Future<void> userLogin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // !------admin login------------
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        var authCredential = userCredential.user;

        if (authCredential!.uid.isNotEmpty) {
          if (authCredential.emailVerified) {
            Fluttertoast.showToast(msg: 'Login Successful');
            Get.toNamed(home_page);
          } else {
            Fluttertoast.showToast(
                msg: 'Email not verified. Please check your email and verify.');
          }
        } else {
          Fluttertoast.showToast(msg: 'Something went wrong!');
        }
      } else {
        Fluttertoast.showToast(msg: "Please enter all the fields");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Please enter a valid email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  //for logout
  signOut() async {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: 'Log out');
    // Get.offAll(() => SignInScreen());
  }
}