// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 231, 231, 213),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: Offset(0, 3)),
            ]),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 60,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Text(
                "Total:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "\$80",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(CupertinoIcons.cart),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add To Cart",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                backgroundColor: MaterialStateProperty.all(Colors.red)),
          )
        ]),
      ),
    );
  }
}