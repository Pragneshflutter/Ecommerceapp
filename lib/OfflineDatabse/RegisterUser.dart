import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'Databaseclass.dart';
import 'Loginpagee.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ForDatabase();
  }

  void ForDatabase() {
    Databaseclass().GetDatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enetr Your Name"),
              controller: name,
            )),
        Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enetr Your number"),
              controller: number,
            )),
        Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enetr Your pass"),
              controller: password,
            )),
        Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enetr Your email"),
              controller: email,
            )),
        ElevatedButton(
            onPressed: () {
              Databaseclass()
                  .InsertuserData(
                      name.text, number.text, password.text, email.text, db!)
                  .then((value) {
                if (value.length == 0) {
                  Databaseclass()
                      .InsertValiduser(name.text, number.text, password.text,
                          email.text, db!)
                      .then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return Loginpagee();
                      },
                    ));
                  });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Aleredy Exist")));
                }
              });
            },
            child: Text("Register Data"))
      ]),
    );
  }
}
