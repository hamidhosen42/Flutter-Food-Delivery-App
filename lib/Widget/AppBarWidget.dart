// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widget/search_bar_widget.dart';

import '../main.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // -------------drawer icon-------------
          InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(CupertinoIcons.bars),
              decoration: BoxDecoration(
                  color: themeManager.themeMode == ThemeMode.light
                      ? Colors.white
                      : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: themeManager.themeMode == ThemeMode.light
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.grey.shade900,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ]),
            ),
          ),

          // ------------notifications-----------------
          // InkWell(
          //   onTap: () {},
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     child: Icon(Icons.notifications),
          //     decoration: BoxDecoration(
          //         color: themeManager.themeMode == ThemeMode.light
          //             ? Colors.white
          //             : Colors.grey.shade900,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //             color: themeManager.themeMode == ThemeMode.light
          //                 ? Colors.grey.withOpacity(0.5)
          //                 : Colors.grey.shade900,
          //             spreadRadius: 2,
          //             blurRadius: 10,
          //             offset: Offset(0, 3),
          //           )
          //         ]),
          //   ),
          // ),
        ],
      ),
    );
  }
}