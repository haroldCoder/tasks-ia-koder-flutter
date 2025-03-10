import 'package:sqflite/sqflite.dart';

class StorageManage{
  const StorageManage({required this.initialDatabase});
  final Future<Database> initialDatabase;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await this.initialDatabase;
    return _database!;
  }
}