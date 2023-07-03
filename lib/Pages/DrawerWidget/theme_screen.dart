// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../res/color.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? AppColors.scaffold_background_color
            : Colors.grey.shade900,
        // backgroundColor: AppColors.scaffold_background_color,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Theme",
          style: TextStyle(
            fontSize: 25.sp,
            color: themeManager.themeMode == ThemeMode.light
                ? Colors.grey.shade900
                : Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: themeManager.themeMode == ThemeMode.light
              ? Colors.grey.shade900
              : Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Center(
          child: Card(
            color: themeManager.themeMode == ThemeMode.light
                ? Colors.white
                : Colors.grey.shade900,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Mode',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  Switch(
                      value: themeManager.themeMode == ThemeMode.dark,
                      onChanged: (value) async {
                        setState(() {
                          themeManager.toggleTheme(value);
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}