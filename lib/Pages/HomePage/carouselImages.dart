// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../main.dart';

class CarouselImages extends StatefulWidget {
  const CarouselImages({super.key});

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  final RxInt _currentIndex = 0.obs;

  final List _carouselImages = [
    'assets/carouseimage/img1.jpg',
    'assets/carouseimage/img2.jpg',
    'assets/carouseimage/img3.jpg',
    'assets/carouseimage/img4.jpg',
    'assets/carouseimage/img5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          // !-----------------CarouselSlider---------------------
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 150.h,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 1,
                  onPageChanged: (val, carouselPageChangedReason) {
                    setState(() {
                      _currentIndex.value = val;
                    });
                  },
                ),
                items: _carouselImages.map((image) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          SizedBox(
            height: 5.h,
          ),
          Obx(
            () => DotsIndicator(
              decorator: DotsDecorator(
                color: themeManager.themeMode == ThemeMode.light
                ? Colors.grey.shade500
                : Colors.grey.shade300, // Inactive color
                activeColor: themeManager.themeMode == ThemeMode.light
                ? Colors.blue
                : Colors.red,
              ),
              dotsCount:
                  _carouselImages.length == 0 ? 1 : _carouselImages.length,
              position: _currentIndex.value.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}
