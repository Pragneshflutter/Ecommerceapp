import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databaseclass {
// Get a location using getDatabasesPath

  Future<Database> GetDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table RegisterUser (ID integer primary key Autoincrement , NAME text,NUMBER text , EMAIL TEXT,PASSWORD text)');
    });
    return database;
  }

  Future<void> InsertuserData(String name, String number, String pass,
      String email, Database db) async {
    String insert =
        "insert into RegisterUser (NAME,NUMBER,EMAIL,PASSWORD)  values('$name','$number','$email','$pass')";
    int aa = await db.rawInsert(insert);

    print("===$aa");
  }

  Future<List<Map>> LoginUser(
      String email, String password, Database databseeee) async {
    String loginuser =
        "select * From RegisterUser where EMAIL = '$email' and  PASSWORD = '$password' ";
    List<Map> list = await databseeee.rawQuery(loginuser);
    return list;
    print("==$list");
  }
}
