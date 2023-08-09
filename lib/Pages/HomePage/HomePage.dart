// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors, unused_element
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Widget/AppBarWidget.dart';
import '../../Widget/CategoriesWidget.dart';
import '../../main.dart';
import '../DrawerWidget/DrawerWidget.dart';
import '../../Widget/NewestItemsWidget.dart';
import '../../Widget/PopularItemWidget.dart';
import '../PopularItemPage.dart';
import 'carouselImages.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  late TextEditingController _searchController;
  QuerySnapshot? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchResults = null;
  }

  _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = null;
      });
      return;
    }

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('popular_food')
        .where('name', isGreaterThanOrEqualTo: query)
        .get();

    setState(() {
      _searchResults = snapshot;
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

            //!------------- Searchbar widget------------
            Container(
              width: double.infinity,
              height: 2000.h,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      height: 50, // Adjust the height as desired
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: themeManager.themeMode == ThemeMode.light
                              ? Colors.white
                              : Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10),
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
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                            hintText: 'Search for popular food...',
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.search,
                              color: Colors.red,
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _searchResults != null
                        ? Padding(
                         padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: ListView.builder(
                              itemCount: _searchResults!.docs.length,
                              itemBuilder: (context, index) {
                                final data = _searchResults!.docs[index];
                                var name = data['name'];
                                var rating = data['rating'];
                                var price = data['price'];
                                var details = data['details'];
                                var subtitle = data['subtitle'];
                                var img = data['img'];
                                          
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
                                                subtitle: subtitle,
                                                imageUrl: data['img'])));
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(name),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          img,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        )
                        : Column(
                            children: [
                              // !---------------carouselImages-----------
                              SizedBox(height: 10.h,),
                              CarouselImages(),
                  
                              //! ---------------category-----------------
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Categories",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                  
                              CategoriesWidget(),
                  
                              // ---------popular Items Widget----------
                              Padding(
                                 padding: EdgeInsets.only(
                                    left: 10, top: 5, bottom: 10),
                                child:  Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Popular",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              PopularItemWidget(),
                  
                              SizedBox(
                                height: 10.h,
                              ),
                  
                              // --------------Newest Item-------------
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5),
                                child:  Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Newest",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              NewestItemsWidget(),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: DrawerWidget(),
        // floatingActionButton: Container(
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(20),
        //       boxShadow: [
        //         BoxShadow(
        //             color: Colors.grey.withOpacity(0.5),
        //             spreadRadius: 2,
        //             blurRadius: 10,
        //             offset: Offset(0, 3))
        //       ]),
        //   child: FloatingActionButton(
        //     onPressed: () {
        //        Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (_) => CartPage()));
        //     },
        //     backgroundColor:Colors.white,
        //     child: Icon(
        //       CupertinoIcons.cart,
        //        color: themeManager.themeMode == ThemeMode.light
        //                       ? Colors.red
        //                       : Colors.black,
        //       size: 30,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
