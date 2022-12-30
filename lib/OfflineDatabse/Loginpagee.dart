import 'package:apicalling/Homepage.dart';
import 'package:apicalling/OfflineDatabse/Databaseclass.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'Homepage.dart';
import 'RegisterUser.dart';

class Loginpagee extends StatefulWidget {
  static SharedPreferences? preferences;

  @override
  State<Loginpagee> createState() => _LoginpageeState();
}

class _LoginpageeState extends State<Loginpagee> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  Database? databse;

  bool Islogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fordatabse();
  }

  Future<void> Fordatabse() async {
// Obtain shared preferences.
    Loginpagee.preferences = await SharedPreferences.getInstance();

    setState(() {
      Islogin = Loginpagee.preferences!.getBool("loginstatus") ?? false;
    });


    print("==$Islogin");
    if (Islogin) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HHH();
        },
      ));
    } else {


    }

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
                    Loginpagee.preferences!.setBool("loginstatus", true);


                    String name = value[0]['NAME'];
                    String number = value[0]['NUMBER'];
                    String pass = value[0]['PASSWORD'];
                    int id = value[0]['ID'];
                    Loginpagee.preferences!.setInt("loginid", id);
                    print("##==$name==$id==$number=====$pass");



                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login SuccessFully")));

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return  HHH();
                    },));

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
