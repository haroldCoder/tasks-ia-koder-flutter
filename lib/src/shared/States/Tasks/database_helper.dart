import 'package:sqflite/sqflite.dart';
import 'package:tasks_ia_koderx/src/shared/States/repository/storageRepository.dart';
import 'dart:async';
import 'package:tasks_ia_koderx/src/shared/States/storage/storageManage.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';

class DatabaseTasksHelper implements StorageRepository {
  static String table = 'tasks';
  static const columnId = 'id';
  static const columnTaskName = 'taskName';
  static const columnDueDate = 'dueDate';
  late StorageManage storageManage;
  static final DatabaseTasksHelper _instance = DatabaseTasksHelper._internal();

  DatabaseTasksHelper._internal(){
    this.storageManage = StorageManage(filedb: 'my_database.db');
    initDatabase();
  }

  static DatabaseTasksHelper get instance => _instance;

  Future<void> initDatabase() async {
    Database db = await storageManage.database;
    db.execute('''
        CREATE TABLE IF NOT EXISTS tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title_task TEXT,
          description TEXT,
          value_priority INTEGER,
          complete INTEGER DEFAULT 0
        );
      ''');
  }

  @override
  Future<int> insert(String title, String description, int priority) async {
    Database db = await this.storageManage.database;
    return await db.insert(table, {
      "title_task": title,
      "description": description,
      "value_priority": priority
    });
  }

  @override
  Future<List<TasksInterface>> getTasks() async {
    Database db = await this.storageManage.database;
    List<Map<String, dynamic>> result = await db.query(table);
    return result.map((map) => TasksInterface.fromMap(map)).toList();
  }

  @override
  Future<int> update(UpdateTasksInterface task, int id) async {
    Database db = await this.storageManage.database;

    return await db.update(
      table,
      task.toMap(),
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> delete(int id) async {
    Database db = await this.storageManage.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSeveral(List<int> ids) async{
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
