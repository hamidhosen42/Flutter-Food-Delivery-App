// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/Pages/ItemPage.dart';
import 'package:food_delivery_app/res/color.dart';

class CategoriesItem extends StatefulWidget {
  final String categorie_name;
  final List img_url;
  final List name;
  final List rating;
  final List price;
  final List subtitle;
  final List details;

  CategoriesItem(
      {required this.categorie_name,
      required this.img_url,
      required this.name,
      required this.rating,
      required this.price,
      required this.subtitle,
      required this.details,
      });

  @override
  State<CategoriesItem> createState() => _CategoriesItemState();
}

class _CategoriesItemState extends State<CategoriesItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffold_background_color,
        centerTitle: true,
        elevation: 2,
        title: Text(
          widget.categorie_name,
          style: TextStyle(fontSize: 25.sp, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          // scrollDirection: Axis.horizonta,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 10.0, // Spacing between columns
            mainAxisSpacing: 10.0, // Spacing between rows
          ),
          itemCount: widget.img_url.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ItemPage(name:widget.name[index], rating:widget.rating[index], price:widget.price[index], subText:widget.subtitle[index], imageUrl:widget.img_url[index],
                            details :widget.details[index]
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(
                    Radius.circular(7.r),
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7.r),
                        topRight: Radius.circular(7.r),
                      ),
                      child:  CachedNetworkImage(
                              imageUrl: widget.img_url[index],
                              height: 80.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(color: Colors.redAccent,),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        widget.name[index],
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: RatingBar.builder(
                        itemSize: 16.w,
                        initialRating: widget.rating[index].toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${widget.price[index]}",
                            style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
