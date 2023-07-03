// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls, invalid_return_type_for_catch_error, unused_import, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/color.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.scaffold_background_color,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Favorite",
            style: TextStyle(fontSize: 25.sp, color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users-favourite-items')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("place")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      child: Card(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.r),
                                    topRight: Radius.circular(5.r),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: data['imageUrl'],
                                    height: 120.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    placeholder: (context, url) =>
                                        const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            color: Colors.black26),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                            size: 30.sp,
                                          ),
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection(
                                                    'users-favourite-items')
                                                .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                .collection('place')
                                                .where('name',
                                                    isEqualTo: data['name'])
                                                .get()
                                                .then((querySnapshot) {
                                              querySnapshot.docs
                                                  .forEach((doc) {
                                                doc.reference.delete();
                                              });

                                              Fluttertoast.showToast(
                                                msg:
                                                    "Place deleted successfully",
                                                backgroundColor:
                                                    Colors.black87,
                                              );
                                            }).catchError((error) =>
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          " Failed to delete place: $error",
                                                      backgroundColor:
                                                          Colors.black87,
                                                    ));
                                          },
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                          data['name'].toString(),
                                          style: TextStyle(
                                              fontSize: 18.sp,fontWeight: FontWeight.bold),
                                        ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$"+data['price'].toString(), // Price value
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ),
                                       Icon(
                                    CupertinoIcons.cart,
                                    color: Colors.red,
                                  ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
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
            }));
  }
}