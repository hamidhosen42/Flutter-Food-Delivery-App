// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/Pages/CardPage.dart';
import 'package:get/get.dart';
import '../../Widget/AppBarWidget.dart';
import '../../Widget/CategoriesWidget.dart';
import '../../main.dart';
import '../DrawerWidget/DrawerWidget.dart';
import '../../Widget/NewestItemsWidget.dart';
import '../../Widget/PopularItemWidget.dart';
import 'carouselImages.dart';

class HomePage extends StatelessWidget {
  Future _exitDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure to close this app?"),
            content: Row(
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text("No"),
                ),
                SizedBox(
                  width: 20.w,
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text("Yes"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _exitDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        body: ListView(
          children: [
            //!------------- Custom app Bar widget------------
            AppBarWidget(),

            // !---------------carouselImages-----------
            CarouselImages(),

            //! ---------------category-----------------
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            
            CategoriesWidget(),

            // ---------popular Items Widget----------
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3))
              ]),
          child: FloatingActionButton(
            onPressed: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CartPage()));
            },
            backgroundColor:Colors.white,
            child: Icon(
              CupertinoIcons.cart,
               color: themeManager.themeMode == ThemeMode.light
                              ? Colors.red
                              : Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}