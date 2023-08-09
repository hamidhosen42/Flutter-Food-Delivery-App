// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Pages/PopularItemPage.dart';
import '../main.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        width: double.infinity,
        height: 500.h,
        child: Column(
          children: [
            Container(
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
            Expanded(
              child: _searchResults != null
                  ? ListView.builder(
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
                    )
                  : Center(
                      child: Text(''),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}