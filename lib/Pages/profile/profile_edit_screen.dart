// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Widget/violetButton.dart';
import '../../res/color.dart';
import '../../styles/styles.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileEditScreen extends StatefulWidget {
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  File? _image;
  final _picker = ImagePicker();

  Future getImageGally() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  showUserData({required data}) {
    nameController.text = data['name'];
    emailController.text = data['email'];
    phoneController.text = data['phone_number'];
    addressController.text = data['address'];

    return SingleChildScrollView(
      child: Column(
        children: [
          formField(
            icon: Icons.person,
            controller: nameController,
            inputType: TextInputType.name,
            hint: "name",
          ),
          SizedBox(
            height: 20.h,
          ),
          formField(
              icon: Icons.email,
              controller: emailController,
              inputType: TextInputType.emailAddress,
              hint: "email",
              readOnly: true),
          SizedBox(
            height: 20.h,
          ),
          formField(
            icon: Icons.phone,
            controller: phoneController,
            inputType: TextInputType.phone,
            hint: "phone",
          ),
          SizedBox(
            height: 20.h,
          ),
          formField(
            icon: Icons.location_city_rounded,
            controller: addressController,
            inputType: TextInputType.text,
            hint: "address",
          ),
          SizedBox(height: 25.h),
          InkWell(
            onTap: () {
              getImageGally();
            },
            child: Container(
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: _image != null
                  ? Image.file(_image!)
                  : Center(
                      child: data['image_url'] != ""
                          ? Image.network(data['image_url'])
                          : Image.asset("assets/avatar.png")),
            ),
          ),
          SizedBox(height: 25.h),
          VioletButton(
            isLoading: false,
            title: "Update".tr,
            onAction: () async {
              String id = DateTime.now().microsecondsSinceEpoch.toString();
              var ref = FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid);

              if (_image != null) {
                firebase_storage.Reference ref1 = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/profile/' + id);
                firebase_storage.UploadTask uploadTask = ref1.putFile(_image!);
                await uploadTask.whenComplete(() => null);
                String downloadUrl = await ref1.getDownloadURL();

                // Update the profile image URL in the user's document
                ref.update({'image_url': downloadUrl});
              }

              try {
                // Update other user profile fields
                ref
                    .update({
                      'name': nameController.text,
                      'email': emailController.text,
                      'phone_number': phoneController.text,
                      'address': addressController.text,
                    })
                    .then(
                      (value) => Fluttertoast.showToast(
                        msg: "Updated Successfully",
                        backgroundColor: Colors.black87,
                      ),
                    )
                    .then(
                      (value) => Get.back(),
                    );
              } catch (e) {
                Fluttertoast.showToast(
                  msg: "Something is wrong",
                  backgroundColor: Colors.black87,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffold_background_color,
        centerTitle: true,
        elevation: 2,
        title: Text(
          "Profile Edit",
          style: TextStyle(fontSize: 25.sp, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
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
              return showUserData(data: data);
            }
          },
        ),
      ),
    );
  }
}

Widget formField(
    {required IconData icon, controller, inputType, hint, readOnly = false}) {
  return TextFormField(
      controller: controller,
      keyboardType: inputType,
      readOnly: readOnly,
      decoration: AppStyle().textFieldDecoration(hint, icon));
}