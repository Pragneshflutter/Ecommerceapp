import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SplashCreen.dart';
import 'UpdateItem.dart';

class View_product extends StatefulWidget {
  const View_product({Key? key}) : super(key: key);

  @override
  State<View_product> createState() => _View_productState();
}

class _View_productState extends State<View_product> {
  VIEWPRODUCT? mm;


  bool statsu = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ForViewProducty();
  }

  @override
  Widget build(BuildContext context) {
    return   statsu ?Scaffold(
      body: ListView.builder(
        itemCount: mm!.productdata!.length,

        itemBuilder: (context, index) {
          return ListTile(

            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdateItem(mm!.productdata![index]);
              },));
            },
            title: Text("${mm!.productdata![index].productname}"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://dishazone.000webhostapp.com/MyEcom/${mm!.productdata![index].proimage}"),
            ),
          );
        },
      ),
    ) : Center(child: CircularProgressIndicator());
  }

  Future<void> ForViewProducty() async {
    Map productmap = {
      "userid": "38",
    };

    var url = Uri.parse(
        'https://dishazone.000webhostapp.com/MyEcom/ViewProducts.php');
    var response = await http.post(url, body: productmap);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var mmm = jsonDecode(response.body);

    setState(() {
      mm = VIEWPRODUCT.fromJson(mmm);
      statsu = true;

    });
  }
}

class VIEWPRODUCT {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  VIEWPRODUCT({this.connection, this.result, this.productdata});

  VIEWPRODUCT.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? productname;
  String? saleprice;
  String? productprice;
  String? desctription;
  String? proimage;
  String? userid;

  Productdata(
      {this.id,
        this.productname,
        this.saleprice,
        this.productprice,
        this.desctription,
        this.proimage,
        this.userid});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productname = json['Productname'];
    saleprice = json['saleprice'];
    productprice = json['Productprice'];
    desctription = json['desctription'];
    proimage = json['proimage'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Productname'] = this.productname;
    data['saleprice'] = this.saleprice;
    data['Productprice'] = this.productprice;
    data['desctription'] = this.desctription;
    data['proimage'] = this.proimage;
    data['userid'] = this.userid;
    return data;
  }
}
