// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, must_be_immutable, import_of_legacy_library_into_null_safe, unused_import, avoid_print, unused_local_variable, equal_keys_in_map, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/Widget/AppBarWidget.dart';
import 'package:food_delivery_app/Pages/DrawerWidget/DrawerWidget.dart';
import '../Widget/ItemBottomNavBar.dart';
import '../res/color.dart';
// import 'package:clippy_flutter/clippy_flutter.dart';

class ItemPage extends StatefulWidget {
  final String name;
  final int rating;
  final int price;
  final String subText;
  final String imageUrl;
  final String details;

  ItemPage({
    required this.name,
    required this.rating,
    required this.price,
    required this.subText,
    required this.imageUrl,
    required this.details,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int? quantity = 1;
  int? total = 0;

  @override
  void initState() {
    super.initState();
  }

  Future addToFavourite() async {
    var ref = FirebaseFirestore.instance
        .collection("users-favourite-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("place")
        .doc();

    String id = DateTime.now().microsecondsSinceEpoch.toString();

    ref.set({
      'name': widget.name,
      'rating': widget.rating,
      'price': widget.price,
      'name': widget.name,
      'imageUrl': widget.imageUrl,
      'details': widget.details,
    }).then(
      (value) => Fluttertoast.showToast(
        msg: "Added to favourite place",
        backgroundColor: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    total = (quantity! * widget.price);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 50.h,
              width: 50.w,
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(25)),
              //   color: Colors.black26,
              // ),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users-favourite-items')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection("place")
                      .where("name", isEqualTo: widget.name)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data == null) {
                      return Center(child: Text('Place is Empty'));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return IconButton(
                      icon: snapshot.data!.docs.length == 0
                          ? Icon(
                              Icons.favorite_border,
                              size: 30,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.favorite_border,
                              size: 30,
                              color: Colors.red,
                            ),
                      onPressed: () => snapshot.data!.docs.length == 0
                          ? addToFavourite()
                          : Fluttertoast.showToast(
                              msg: "Already Added",
                              backgroundColor: Colors.black87,
                            ),
                    );
                  }),
            ),
          ),
        ],
        backgroundColor: AppColors.scaffold_background_color,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 20.sp, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              height: 250.h,
              width: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 10,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            itemSize: 22,
                            initialRating: widget.rating.toDouble(),
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
                                  text: widget.price.toString(), // Price value
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 35.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 183, 111, 105),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (quantity! >= 1) {
                                          quantity = (quantity! - 1);
                                          total = (total! -
                                              quantity! * widget.price);
                                        }
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        CupertinoIcons.minus,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        quantity = (quantity! + 1);
                                        // total=(total!+quantity!*widget.price);
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        CupertinoIcons.add,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.details,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delievrey Time",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.clock,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("30 Minutes",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ItemBottomNavBar(total: total!.toInt()),
    );
  }
}