import 'dart:convert';
import 'dart:io';
import 'package:apicalling/Homepage.dart';
import 'package:http/http.dart' as http;

import 'package:apicalling/View_product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateItem extends StatefulWidget {
  Productdata productdata;

  UpdateItem(this.productdata);

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  String img = "";
  int a = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    a = 1;
                  });

                  showDialog(
                    context: context,
                    builder: (context) {

                      return Container();
                      // return Column(
                      //   children: [
                      //     ElevatedButton.icon(
                      //         onPressed: () async {
                      //           Navigator.pop(context);
                      //           final ImagePicker _picker = ImagePicker();
                      //           // Capture a photo
                      //           final XFile? photo = await _picker.pickImage(
                      //               source: ImageSource.camera);
                      //           setState(() {
                      //             img = photo!.path;
                      //           });
                      //         },
                      //         icon: Icon(Icons.camera),
                      //         label: Text("Camera")),
                      //     ElevatedButton.icon(
                      //         onPressed: () async {
                      //           Navigator.pop(context);
                      //           final ImagePicker _picker = ImagePicker();
                      //           // Pick an image
                      //           final XFile? image = await _picker.pickImage(
                      //               source: ImageSource.gallery);
                      //
                      //           setState(() {
                      //             img = image!.path;
                      //           });
                      //         },
                      //         icon: Icon(Icons.photo),
                      //         label: Text("Gallary"))
                      //   ],
                      // );
                    },
                  );
                },
                child: a == 1
                    ? CircleAvatar(
                        maxRadius: 50,
                        backgroundImage: FileImage(File(img)),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://dishazone.000webhostapp.com/MyEcom/${widget.productdata.proimage}"))),
            ElevatedButton(
                onPressed: () async {
                  //        image   > byte array > string

                  List<int>  gg = File(img).readAsBytesSync();
                  String updateimage = base64Encode(gg);


                  Map updateproduct = {
                    "proupid":widget.productdata.id,
                    "newname" : "UpdateProduct",
                    "imagename":widget.productdata.proimage,
                    "updateimagedata":updateimage

                  };


                  var url = Uri.parse(
                      'https://dishazone.000webhostapp.com/MyEcom/UpdatePro.php');
                  var response = await http.post(url, body: updateproduct);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body.toString()}');
                  var mmm = jsonDecode(response.body.toString());
                  UpdateProduxct mm = UpdateProduxct.fromJson(mmm);
                  setState(() {
                    if(mm.connection==1)
                      {
                        if(mm.result==1)
                          {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return View_product();
                            },));
                          }
                      }
                  });

                },
                child: Text("Register Data")),
          ],
        ),
      ),
    );
  }
}
class UpdateProduxct {
  int? connection;
  int? result;

  UpdateProduxct({this.connection, this.result});

  UpdateProduxct.fromJson(Map<String, dynamic> json) {
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
