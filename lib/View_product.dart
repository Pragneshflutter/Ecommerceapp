import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SplashCreen.dart';

class View_product extends StatefulWidget {
  const View_product({Key? key}) : super(key: key);

  @override
  State<View_product> createState() => _View_productState();
}

class _View_productState extends State<View_product> {
  Viewwwproducttt? mm;

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

            title: Text("${mm!.productdata![index].pname}"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://pragneshzone.000webhostapp.com/Ecommer/${mm!.productdata![index].productimagepath}"),
            ),
          );
        },
      ),
    ) : Center(child: CircularProgressIndicator());
  }

  Future<void> ForViewProducty() async {
    Map productmap = {
      "userid": SplashCreen.prefrs!.getString("id") ?? "",
    };

    var url = Uri.parse(
        'https://pragneshzone.000webhostapp.com/Ecommer/Viewproduct.php');
    var response = await http.post(url, body: productmap);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var mmm = jsonDecode(response.body);

    setState(() {
      mm = Viewwwproducttt.fromJson(mmm);
      statsu = true;

    });
  }
}

class Viewwwproducttt {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  Viewwwproducttt({this.connection, this.result, this.productdata});

  Viewwwproducttt.fromJson(Map<String, dynamic> json) {
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
  String? productid;
  String? pname;
  String? pprize;
  String? pdes;
  String? userid;
  String? productimagepath;

  Productdata(
      {this.productid,
      this.pname,
      this.pprize,
      this.pdes,
      this.userid,
      this.productimagepath});

  Productdata.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    pname = json['pname'];
    pprize = json['pprize'];
    pdes = json['pdes'];
    userid = json['userid'];
    productimagepath = json['productimagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['pname'] = this.pname;
    data['pprize'] = this.pprize;
    data['pdes'] = this.pdes;
    data['userid'] = this.userid;
    data['productimagepath'] = this.productimagepath;
    return data;
  }
}
