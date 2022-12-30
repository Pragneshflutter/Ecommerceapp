import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'Databaseclass.dart';
import 'Homepage.dart';

class UpdateConatc extends StatefulWidget {
  Map userconatc;

  UpdateConatc(Map this.userconatc);

  @override
  State<UpdateConatc> createState() => _UpdateConatcState();
}

class _UpdateConatcState extends State<UpdateConatc> {
  TextEditingController name = TextEditingController();
  TextEditingController num = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fordatabase();
    name.text = widget.userconatc['NAME'];
    num.text = widget.userconatc['NUMBER'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: name,
            ),
            TextField(
              controller: num,
            ),
            ElevatedButton(
                onPressed: () {
                  String newnmae = name.text;
                  String newnum = num.text;

                  int iddd = widget.userconatc['ID'];

                  Databaseclass()
                      .UpdateConattcc(newnmae, newnum, iddd, db!)
                      .then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return HHH();
                      },
                    ));
                  });
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }

  Database? db;


  void fordatabase() {
    Databaseclass().GetDatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }
}
