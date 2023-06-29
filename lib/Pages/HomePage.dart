// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widget/AppBarWidget.dart';
import '../Widget/CategoriesWidget.dart';
import '../Widget/DrawerWidget.dart';
import '../Widget/NewestItemsWidget.dart';
import '../Widget/PopularItemWidget.dart';
import '../Widget/SearchBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Custom app Bar widget
          AppBarWidget(),

          // --------search bar-----------
          SearchBar(),

          // ---------category----------
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          CategoriesWidget(),

          // ---------popular Items Widget----------
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
            child: Text(
              "Popular",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          PopularItemWidget(),

          SizedBox(
            height: 10.h,
          ),

          // --------------Newest Item-------------
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5,bottom: 5),
            child: Text(
              "Newest",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          NewestItemsWidget(),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
      drawer: DrawerWidget(),
      floatingActionButton: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3))
        ]),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "cartPage");
          },
          backgroundColor: Colors.white,
          child: Icon(
            CupertinoIcons.cart,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
    );
  }
}