import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databaseclass {
// Get a location using getDatabasesPath

  Future<Database> GetDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo1.db');
// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table RegisterUser (ID integer primary key Autoincrement , NAME text,NUMBER text , EMAIL TEXT,PASSWORD text)');
      await db.execute(
          'create table contactbook (ID integer primary key Autoincrement , NAME text,NUMBER text ,USERID integer)');
    });
    return database;
  }

  Future<List<Map>> InsertuserData(String name, String number, String pass,
      String email, Database db) async {
    String cheaksql =
        "select * from RegisterUser where EMAIL ='$email'  or  NUMBER  = '$number'";

    List<Map> list = await db.rawQuery(cheaksql);

    return list;
    // print("===$aa");
  }

  Future<List<Map>> LoginUser(
      String email, String password, Database databseeee) async {
    String loginuser =
        "select * From RegisterUser where EMAIL = '$email' and  PASSWORD = '$password' ";
    List<Map> list = await databseeee.rawQuery(loginuser);

    print("==$list");
    return list;
  }

  Future<void> InsertValiduser(String text, String text2, String text3,
      String text4, Database database) async {
    String insert =
        "insert into RegisterUser (NAME,NUMBER,EMAIL,PASSWORD)  values('$text','$text2','$text3','$text4')";
    int aa = await database.rawInsert(insert);
  }

  Future<void> insertcontact(
      String text, String text2, String s, Database db) async {
    String insertcontact =
        "insert into contactbook (NAME,NUMBER,USERID) values ('$text','$text2','$s')";
    int res = await db.rawInsert(insertcontact);
    print("====$res");
  }

  Future<List<Map>> ViewConatct(int useridd, Database ddddb) async {
    String viewconatct = "select * from contactbook where USERID = '$useridd'";

    List<Map> listconat = await ddddb.rawQuery(viewconatct);

    print("===$listconat");
    return listconat;
  }

  Future<void> DeleteConartc(Database database, int idd) async {
    String Dd = "Delete from contactbook where ID = '$idd'";
    int aa = await database.rawDelete(Dd);
  }

  Future<void> UpdateConattcc(
      String newnmae, String newnum, int iddd, Database database) async {
    String dd =
        "update contactbook set NAME = '$newnmae',NUMBER = '$newnum'   where ID = '$iddd'";

 int aaa = await   database.rawUpdate(dd);
  }
}
