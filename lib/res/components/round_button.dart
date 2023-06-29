// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading; 

  RoundButton(this.title, this.loading, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
         padding:
                    const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColors.roundButtomColor, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: loading
                ? CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  )
                : Text(title,
                    style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}