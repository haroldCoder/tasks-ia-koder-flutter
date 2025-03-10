import 'dart:ffi';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:tasks_ia_koderx/src/shared/States/storage/storageManage.dart';
import 'dart:io';

import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

class DatabaseTasksHelper {
  String table = 'tasks';
  static const columnId = 'id';
  static const columnTaskName = 'taskName';
  static const columnDueDate = 'dueDate';
  late StorageManage storageManage;
  static final DatabaseTasksHelper _instance = DatabaseTasksHelper._internal();

  DatabaseTasksHelper._internal(){
    this.storageManage = StorageManage(initialDatabase: this.initDatabase());
  }

  static DatabaseTasksHelper get instance => _instance;

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'my_database.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title_task TEXT,
          description TEXT,
          value_priority INTEGER,
          complete INTEGER DEFAULT 0
        );
      ''');
    });
  }

  Future<int> insert(String title, String description, int priority) async {
    Database db = await this.storageManage.database;
    return await db.insert(table, {
      "title_task": title,
      "description": description,
      "value_priority": priority
    });
  }

  Future<List<CreateTasksState>> getTasks() async {
    Database db = await this.storageManage.database;
    List<Map<String, dynamic>> result = await db.query(table);
    return result.map((map) => CreateTasksState.fromMap(map)).toList();
  }

  Future<int> update(CreateTasksState task, int id) async {
    Database db = await this.storageManage.database;
    Map<String, dynamic> taskMap = task.toMap();

    taskMap.remove(columnId);
    return await db.update(
      table,
      taskMap,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await this.storageManage.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete_several(List<int> ids) async{
    Database db = await this.storageManage.database;

    try {
      final results = await Future.wait(
        ids.map((id) async {
          return await db.delete(
            table,
            where: '$columnId = ?',
            whereArgs: [id],
          );
        }),
      );

      final allSuccessful = results.every((count) => count > 0);

      return allSuccessful ? 1 : 0;
    } catch (e) {
      print('Error al eliminar: $e');
      return 0;
    }
  }
}
