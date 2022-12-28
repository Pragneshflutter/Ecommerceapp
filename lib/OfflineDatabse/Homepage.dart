import 'package:apicalling/OfflineDatabse/addcontact.dart';
import 'package:flutter/material.dart';

import 'Loginpagee.dart';

class HHH extends StatefulWidget {
  const HHH({Key? key}) : super(key: key);

  @override
  State<HHH> createState() => _HHHState();
}

class _HHHState extends State<HHH> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          children: [
            ElevatedButton(onPressed: () {
              Loginpagee.preferences!.setBool("loginstatus", false);

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Loginpagee();
              },));
            }, child: Text("log out"))
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return addcontact();
          },));
        },child: Icon(Icons.add)),
      ),
    );
  }
}
