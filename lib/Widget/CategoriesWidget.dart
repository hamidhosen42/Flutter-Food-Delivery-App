// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: StreamBuilder(
        // stream: c.isState.value==0?FirebaseFirestore.instance.collection('home-screen').snapshots():FirebaseFirestore.instance.collection('home-screen').where('categories',isEqualTo: c.productName.value).snapshots(),
        stream: FirebaseFirestore.instance.collection('newest_ttems').snapshots(),
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
                var name = data['name'];
                var id = data['id'];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "itemPage");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
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
