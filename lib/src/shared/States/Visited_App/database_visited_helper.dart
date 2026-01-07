import 'package:sqflite/sqflite.dart';
import 'package:tasks_ia_koderx/src/domain/models/visited_table_model.dart';
import 'package:tasks_ia_koderx/src/infrastructure/adapters/storage_manage_adapter.dart';

class DatabaseVisitedHelper{
  static const table = 'loggeds';
  static const dateColumn = 'datelog';
  late StorageManageAdapter storageManage;
  static final DatabaseVisitedHelper _instance = DatabaseVisitedHelper._internal();

  DatabaseVisitedHelper._internal(){
    this.storageManage = StorageManageAdapter(filedb: 'my_database.db');
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

  Future<List<IVisitedTableModel>> getData() async {
    Database db = await this.storageManage.database;
    List<Map<String, dynamic>> result = await db.query(table);
    result.map((rs) => print(rs));

    return result.map((rs) => IVisitedTableModel.fromMap(rs)).toList();
  }

}