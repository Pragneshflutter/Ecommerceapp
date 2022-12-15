// void main()
// {
//
//
// }
import 'dart:convert';
import 'dart:io';

import 'package:apicalling/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'SplashCreen.dart';

abstract class Myclass {
  gemyname(); //

  getvalue() {
    print("yes i Am Parent");
  }
}

class Mytclas2 extends Myclass {
  @override
  gemyname() {
    // TODO: implement gemyname
  }

  getvalue() {
    super.getvalue();
    print("yes i Am base");
  }
}

// import 'dart:convert';
// import 'dart:io';
//
// import 'package:apicalling/Loginpage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// import 'SplashCreen.dart';
//
// // Neumorphic
// // Card
//
void main() {
  runApp(MaterialApp(
    home: SplashCreen(),
  ));
}

class HomeApi extends StatefulWidget {
  const HomeApi({Key? key}) : super(key: key);

  @override
  State<HomeApi> createState() => _HomeApiState();
}

class _HomeApiState extends State<HomeApi> {
  String imgg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Data"),
        ),
        body: Column(
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
                  String profileimage = base64Encode(baray);
                  String name = "Today";
                  String number = "76240397044";
                  String email = "haresh@gmail.com";
                  String password = "123";

                  Map mm = {
                    "name": name,
                    "contact": number,
                    "email": email,
                    "password": password,
                    "profileimage": profileimage,
                  };

                  var url = Uri.parse(
                      'https://pragneshzone.000webhostapp.com/Ecommer/register.php');
                  var response = await http.post(url, body: mm);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');
                  var mappp = jsonDecode(response.body);
                  Registerclas mmm = Registerclas.fromJson(mappp);

                  if (mmm.connection == 1) {
                    if (mmm.result == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Register Successfully")));
                    } else if (mmm.result == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Already Exist")));
                    }
                  }
                },
                child: Text("Register Data")),
          ],
        ));
  }

  String img = "";
}

class Registerclas {
  int? connection;
  int? result;

  Registerclas({this.connection, this.result});

  Registerclas.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
