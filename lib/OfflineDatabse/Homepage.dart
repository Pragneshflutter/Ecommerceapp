import 'package:apicalling/OfflineDatabse/Databaseclass.dart';
import 'package:apicalling/OfflineDatabse/UpdateConatc.dart';
import 'package:apicalling/OfflineDatabse/addcontact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'Loginpagee.dart';

class HHH extends StatefulWidget {
  const HHH({Key? key}) : super(key: key);

  @override
  State<HHH> createState() => _HHHState();
}

class _HHHState extends State<HHH> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ForViewDatabse();
  }

  void ForViewDatabse() {
    Databaseclass().GetDatabase().then((value) {
      setState(() {
        ddddb = value;
      });

      Databaseclass()
          .ViewConatct(Loginpagee.preferences!.getInt("loginid") ?? 0, ddddb!)
          .then((sdfszdfs) {
        setState(() {
          userconatc = sdfszdfs;
        });
      });
    });
  }

  Database? ddddb;
  List<Map> userconatc = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Loginpagee.preferences!.setBool("loginstatus", false);

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Loginpagee();
                    },
                  ));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        backgroundColor: Colors.yellow,
        body: ListView.builder(
          itemCount: userconatc.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(15),
              elevation: 20,
              child: ListTile(
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 2) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return UpdateConatc(userconatc[index]);
                        },
                      ));
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(value: 2, child: Text("Update")),
                      PopupMenuItem(
                          value: 1,
                          onTap: () {
                            int idd = userconatc[index]['ID'];
                            Databaseclass()
                                .DeleteConartc(ddddb!, idd)
                                .then((value) {
                              ForViewDatabse();
                            });
                          },
                          child: Text("Delete"))
                    ];
                  },
                ),
                subtitle: Text("${userconatc[index]['NUMBER']}"),
                title: Text("${userconatc[index]['NAME']}"),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return addcontact();
                },
              ));
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}
