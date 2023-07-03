// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/Pages/profile/profile_edit_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/color.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});
  static const routeName = '/profile-screen';

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffold_background_color,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "PROFILE",
          style: TextStyle(fontSize: 25.sp, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data;
                return Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                clipBehavior: Clip.hardEdge,
                                child: GestureDetector(
                                  onTap: () async {
                                    // Use Navigator to show a full-screen image page
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                          backgroundColor: Colors.grey,
                                          body: Center(
                                            child: Hero(
                                              tag: 'user-avatar',
                                              child: Container(
                                                  width: 90.w,
                                                  height: 90.h,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFfC4C4C4),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          data['image_url'],
                                                      fit: BoxFit.cover,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                      placeholder:
                                                          (context, url) =>
                                                              const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'user-avatar',
                                    child: Container(
                                        width: 90.w,
                                        height: 90.h,
                                        decoration: BoxDecoration(
                                          color: Color(0xFfC4C4C4),
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: data!['image_url'],
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.red,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -12,
                                right: -15,
                                child: IconButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ProfileEditScreen()));
                                  },
                                  icon: Icon(
                                    Icons.mode_edit_outline,
                                    color: Colors.black,
                                    size: 30.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            data['name'],
                            style: GoogleFonts.lato(fontSize: 25),
                          ),
                          SizedBox(height: 5.h),
                          Text(data['email']),
                          SizedBox(height: 5.h),
                          Text(data['phone_number']),
                          SizedBox(height: 5.h),
                          Text(data['address']),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    ));
  }
}