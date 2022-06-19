import 'package:matrimony_final_2022/model/userMeta.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../model/Meta.dart';

abstract class DataBasehelper {
  static Database? database;
  static int get _version => 1;

  static Future init() async {
    if (database != null) {
      return;
    }

    try {
      var databasePath = await getDatabasesPath();
      String _path = p.join(databasePath, 'Matrimony.db');
      database = await openDatabase(_path,
          version: _version, onCreate: _onCreate, onUpgrade: _onUpgrade);
    } catch (ex) {
      print(ex);
    }
  }

  static Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const textTypeN = 'TEXT';
    await db.execute(
      "CREATE TABLE $userTable (${UserFields.id} $idType,${UserFields.UserName} $textType,${UserFields.DOB} $textType,${UserFields.Age} $intType,${UserFields.Gender} $intType,${UserFields.MobileNumber} $textTypeN,${UserFields.Email} $textTypeN,${UserFields.IsFavorite} $intType,${UserFields.CountryName} $textType,${UserFields.StateName} $textType,${UserFields.CityName} $textType);",
    );
  }

  static Future _onUpgrade(Database db, int oldVersion, int version) async {
    if (oldVersion > version) {}
  }

  static Future<List<Map<String, dynamic>>> query(String a) async {
    String search = '\'%' + a + '%\'';
    return database!
        .rawQuery('SELECT * FROM userTable where UserName LIKE $search');
  }

  static Future<int> insert(String userTable, Meta meta) async {
    return await database!.insert(userTable, meta.toJson());
  }

  static Future<int> update(String userTable, Meta meta) async {
    return await database!
        .update(userTable, meta.toJson(), where: 'id=?', whereArgs: [meta.id]);
  }

  static Future<int> delete(String userTable, Meta meta) async {
    return await database!
        .delete(userTable, where: 'id=?', whereArgs: [meta.id]);
  }

  static Future<List<Map<String, dynamic>>> getfav() async {
    return database!.rawQuery("SELECT * from userTable where IsFavorite = 1");
  }

  static Future<int> setfav(int n, int id) async {
    return await database!
        .rawUpdate("UPDATE userTable SET IsFavorite = $n WHERE id= $id");
  }

  static Future<List<Map<String, dynamic>>> details(String userTable) async {
    return database!.query(userTable);
  }
}
