import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

class DatabaseHelper {
  static const table = 'tasks';

  static const columnId = 'id';
  static const columnTaskName = 'taskName';
  static const columnDueDate = 'dueDate';

  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
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
    Database db = await database;
    return await db.insert(table, {
      "title_task": title,
      "description": description,
      "value_priority": priority
    });
  }

  Future<List<CreateTasksState>> getTasks() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(table);
    return result.map((map) => CreateTasksState.fromMap(map)).toList();
  }

  Future<int> update(CreateTasksState task, int id) async {
    Database db = await database;
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
    Database db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete_several(List<int> ids) async{
    Database db = await database;

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
