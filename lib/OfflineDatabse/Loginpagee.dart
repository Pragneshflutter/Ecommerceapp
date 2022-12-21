import 'package:apicalling/Databaseclass.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'RegisterUser.dart';

class Loginpagee extends StatefulWidget {
  const Loginpagee({Key? key}) : super(key: key);

  @override
  State<Loginpagee> createState() => _LoginpageeState();
}

class _LoginpageeState extends State<Loginpagee> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  Database? databse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fordatabse();
  }

  void Fordatabse() {
    Databaseclass().GetDatabase().then((value) {
      setState(() {
        databse = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(hintText: "Enetr Your Name"),
                controller: email,
              )),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(hintText: "Enetr Your Name"),
                controller: pass,
              )),
          ElevatedButton(
              onPressed: () {
                Databaseclass()
                    .LoginUser(email.text, pass.text, databse!)
                    .then((value) {
                  if (value.length == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login SuccessFully")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User Not Fount")));
                  }
                });
              },
              child: Text("Login")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return RegisterUser();
                  },
                ));
              },
              child: Text("Register"))
        ],
      ),
    );
  }
}
