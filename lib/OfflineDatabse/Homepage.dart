import 'package:apicalling/OfflineDatabse/Databaseclass.dart';
import 'package:apicalling/OfflineDatabse/UpdateConatc.dart';
import 'package:apicalling/OfflineDatabse/addcontact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
          searchlist = sdfszdfs;
        });
      });
    });
  }

  Database? ddddb;
  List<Map> userconatc = [];
  List<Map> searchlist = [];

  bool Issearch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Issearch
            ? AppBar(
                title: TextField(
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        searchlist = [];

                        for (int i = 0; i < userconatc.length; i++) {
                          if (userconatc[i]["NAME"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              userconatc[i]["NUMBER"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase())) {
                            searchlist.add(userconatc[i]);
                          }
                        }
                      } else {
                        searchlist = userconatc;
                      }
                    });
                  },
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Issearch = false;
                          searchlist = userconatc;
                        });
                      },
                      icon: Icon(Icons.close))
                ],
              )
            : AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Issearch = true;
                        });
                      },
                      icon: Icon(Icons.search)),
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
        body: AnimationLimiter(
          key: ValueKey("${userconatc.length}"),
          child: ListView.builder(
            itemCount: Issearch ? searchlist.length : userconatc.length,
            itemBuilder: (context, index) {
              Map map = Issearch ? searchlist[index] : userconatc[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  delay: Duration(seconds: 1),
                  duration: Duration(seconds: 1),
                  child: FlipAnimation(
                    delay: Duration(seconds: 3),
                    duration: Duration(seconds: 3),
                    child: Card(
                      margin: EdgeInsets.all(15),
                      elevation: 20,
                      child: ListTile(
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 2) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
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
                        subtitle: Text("${map["NUMBER"]}"),
                        title: Text("${map["NAME"]}"),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
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
