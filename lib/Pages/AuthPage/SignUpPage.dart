// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/auth.dart';
import '../../res/color.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/utils.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: const Text(
                  "Sign Up Page",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Cursive",
                      color: Colors.blueAccent),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Name";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.black),
                        controller: _nameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.textFormColor,
                          hintText: 'Name',
                          suffixIcon: Icon(
                            Icons.person,
                            color: AppColors.textFormIconColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Email";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.black),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.textFormColor,
                          hintText: 'Email',
                          suffixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.textFormIconColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.black),
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.textFormColor,
                          hintText: 'Password',
                          suffixIcon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColors.textFormIconColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already an User ?  ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "signIn");
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.blueAccent),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton("SIGN UP", loading, () {
                if (_formKey.currentState!.validate()) {
                  signUp();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() {
    setState(() {
      loading = true;
    });

  }
}
