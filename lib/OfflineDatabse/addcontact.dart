import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'Databaseclass.dart';
import 'Homepage.dart';
import 'Loginpagee.dart';

class addcontact extends StatefulWidget {
  const addcontact({Key? key}) : super(key: key);

  @override
  State<addcontact> createState() => _addcontactState();
}

class _addcontactState extends State<addcontact> {
  TextEditingController name = TextEditingController();
  TextEditingController num = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fordatabase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Column(
          children: [
            TextField(controller: name,),
            TextField(controller: num,),
            ElevatedButton(onPressed: () {
              int userid = Loginpagee.preferences!.getInt("loginid")??0;

              Databaseclass().insertcontact(name.text,num.text,"$userid",db!).then((value) {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return HHH();
                },));
              });

            }, child: Text("Add Button"))
          ],
        ) ,
      ),
    );
  }
  Database? db;
  void fordatabase() {
    Databaseclass().GetDatabase().then((value){
        setState(() {
          db = value;
        });
    });
  }
}
