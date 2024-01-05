import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:testtt/database/attencence.dart';


class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Attendance.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async =>
            db.execute(
                " CREATE TABLE User( id INTEGER PRIMARY KEY AUTOINCREMENT , employeeName text , employeeCode text, employeeEmail text , lastStatus text , dateTime text ,picture BLOB) ;"),
        version: _version);
  }

  static Future<int> insertUser( Attendance attendance) async {
    final db = await _getDB();
    return await db.insert("User", attendance.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(int id,Attendance attendance) async {
    final db = await _getDB();
    return await db.update("User", attendance.toJson(), where: 'id = ?', whereArgs: [id], conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<List<Map<String, Object?>>> getSingleUser(int id) async {
    final db = await _getDB();
    return db.query('User', where: "employeeCode= ?", whereArgs: [id],limit: 1,orderBy: "id DESC",);


  }



}




