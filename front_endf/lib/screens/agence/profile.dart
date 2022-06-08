import 'dart:io';

import 'package:blogapp/constant.dart';
import 'package:blogapp/models/agence.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/route.dart';

import 'package:blogapp/services/agence_service.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Agence? user;
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _imageFile;
  final _picker = ImagePicker();

  // get user detail
  void getUser() async {
    ApiResponse response = await Api.getAgenceDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as Agence;
        loading = false;
        //txtNameController.text = user!.name ?? '';
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _deletetoken() async {
    ApiResponse response = await Api.deletetoken();
    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const route()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor : b,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: C_3,
        centerTitle: true,
        title: Text(
          "Account",
          style: TextStyle(color: C_4),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
                radius: 65,
                backgroundImage:
                    const AssetImage('assets/images/agence2.webp')),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${user?.name}',
              style: TextStyle(fontSize: 35, color: C_3),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: C_3,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    SizedBox(height: 5),
                    Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 15.0,
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.teal[600],
                          size: 28.0,
                        ),
                        title: Text(
                          '${user?.email}',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: _deletetoken,
                      height: 45,
                      minWidth: 240,
                      shape: const StadiumBorder(),
                      color: C_3,
                      child: const Text(
                        "Lagout",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
