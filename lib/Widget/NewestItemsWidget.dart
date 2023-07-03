// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Pages/PopularItemPage.dart';
import '../main.dart';

class NewestItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('popular_food').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                var name = data['name'];
                var rating = data['rating'];
                var price = data['price'];
                var details = data['details'];
                var subtitle = data['subtitle'];
            return InkWell(
              onTap: () {
               Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => PopularItemPage(
                                name: name,
                                rating: rating,
                                price: price,
                                details: details,
                                subtitle:subtitle,
                                imageUrl: data['img'])));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  height: 130.h,
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     color: themeManager.themeMode == ThemeMode.light
                ? Colors.white
                : Colors.grey.shade900,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 100.h,
                        width: 120.w,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.r),
                              topRight: Radius.circular(7.r),
                            ),
                          child: CachedNetworkImage(
                                imageUrl: data['img'],
                                height: 100.h,
                          width: 120.w,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.redAccent,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Icon(
                                    Icons.favorite_outline,
                                    color: themeManager.themeMode == ThemeMode.light
                              ? Colors.red
                              : Colors.white,
                                    size: 25.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 180.w,
                              child: Text(
                                data['subtitle'].length > 50
                                    ? data['subtitle'].substring(0, 50)
                                    : data['subtitle'],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                 color: themeManager.themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            RatingBar.builder(
                              itemSize: 22,
                              initialRating: data['rating'].toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.red,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 200.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '\$', // Dollar sign
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                        TextSpan(
                                          text: data['price'].toString(), // Price value
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.cart,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}