// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  final user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                accountName: Text("Md.Hamid Hosen",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                    decoration: BoxDecoration(
                      color: Colors.green
                    ),
                accountEmail: user != null ? Text(user!.email ?? '') : Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                ),
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.home,color: Colors.red,),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.person,color: Colors.red,),
              title: Text(
                "My Account",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.cart_fill,color: Colors.red),
              title: Text(
                "My Orders",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.heart_fill,color: Colors.red),
              title: Text(
                "My Wish List",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.settings,color: Colors.red),
              title: Text(
                "Setting",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,color: Colors.red),
              title: InkWell(
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "signIn");
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
    );
  }
}