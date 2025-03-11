import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_ia_koderx/src/shared/States/Visited_App/interface/visited_table.dart';
import 'package:tasks_ia_koderx/src/shared/States/storage/storageManage.dart';

class DatabaseVisitedHelper{
  static const table = 'loggeds';
  static const dateColumn = 'datelog';
  late StorageManage storageManage;
  static final DatabaseVisitedHelper _instance = DatabaseVisitedHelper._internal();

  DatabaseVisitedHelper._internal(){
    this.storageManage = StorageManage(filedb: 'my_database.db');
    initDatabase();
  }

  static DatabaseVisitedHelper get instance => _instance;


  Future<void> initDatabase() async {
    Database db = await storageManage.database;
      db.execute('''
        CREATE TABLE IF NOT EXISTS ${table}(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          datelog TEXT
        );
      ''');
  }

  Future<int> insert(String date) async {
    Database db = await this.storageManage.database;
    return await db.insert(table, {
      "datelog": date
    });
  }

  Future<List<VisitedTable>> getData() async {
    Database db = await this.storageManage.database;
    List<Map<String, dynamic>> result = await db.query(table);
    result.map((rs) => print(rs));

    return result.map((rs) => VisitedTable.fromMap(rs)).toList();
  }

}