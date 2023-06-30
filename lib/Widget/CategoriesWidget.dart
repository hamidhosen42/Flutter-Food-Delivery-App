// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Pages/HomePage/CategoriesItem.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(snapshot.data!.docs.length, (index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                    var img_url = data['img_url'] != null ? data['img_url'] as List<dynamic> : [];
                    var name = data['name'] != null ? data['name'] as List<dynamic> : [];
                    var categorie_name =data['categorie_name'];
                    var rating = data['rating'] != null ? data['rating'] as List<dynamic> : [];
                    var price = data['price'] != null ? data['price'] as List<dynamic> : [];
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CategoriesItem(categorie_name:categorie_name,img_url:img_url,name:name,rating:rating,price:price)));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Container(
                      child: Image.network(
                        data['img'],
                        height: 50,
                        width: 50,
                      ),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ]),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}