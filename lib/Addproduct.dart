import 'dart:convert';
import 'dart:io';
import 'package:apicalling/SplashCreen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({Key? key}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String img = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Column(
      children: [
        InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            Navigator.pop(context);
                            final ImagePicker _picker = ImagePicker();
                            // Capture a photo
                            final XFile? photo = await _picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              img = photo!.path;
                            });
                          },
                          icon: Icon(Icons.camera),
                          label: Text("Camera")),
                      ElevatedButton.icon(
                          onPressed: () async {
                            Navigator.pop(context);
                            final ImagePicker _picker = ImagePicker();
                            // Pick an image
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);

                            setState(() {
                              img = image!.path;
                            });
                          },
                          icon: Icon(Icons.photo),
                          label: Text("Gallary"))
                    ],
                  );
                },
              );
            },
            child: CircleAvatar(
              maxRadius: 50,
              backgroundImage: FileImage(File(img)),
            )),
        ElevatedButton(
            onPressed: () async {
              //        image   > byte array > string

              List<int> baray = File(img).readAsBytesSync();
              String productimage = base64Encode(baray);
              String pname = "android";
              String prize = "90000";
              String des = "hello1";

              Map productmap = {
                "pname": pname,
                "pprize": prize,
                "pdes": des,
                "userid": SplashCreen.prefrs!.getString("id")??"",
                "productimage": productimage,
              };

              var url = Uri.parse(
                  'https://pragneshzone.000webhostapp.com/Ecommer/addproduct.php');
              var response = await http.post(url, body: productmap);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

            },
            child: Text("Register Data")),
      ],
    ),);
  }
}
