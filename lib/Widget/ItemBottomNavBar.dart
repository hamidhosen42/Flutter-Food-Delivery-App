// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../payment/payment_controller.dart';

class ItemBottomNavBar extends StatefulWidget {
  final int total;

  ItemBottomNavBar({required this.total});

  @override
  State<ItemBottomNavBar> createState() => _ItemBottomNavBarState();
}

class _ItemBottomNavBarState extends State<ItemBottomNavBar> {
  var obj = PaymentController();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
          color: themeManager.themeMode == ThemeMode.light
                              ? Color.fromARGB(255, 231, 231, 213)
                              : Colors.grey.shade900,
            boxShadow: [
              BoxShadow(
                 color: themeManager.themeMode == ThemeMode.light
                              ? Colors.grey.withOpacity(0.5)
                              : Colors.grey.shade900,
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
                widget.total.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              obj.makePayment(amount: widget.total.toString(), currency: 'USD');
            },
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
