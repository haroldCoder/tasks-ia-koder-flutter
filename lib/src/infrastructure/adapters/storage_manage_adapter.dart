import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StorageManageAdapter{
  const StorageManageAdapter({required this.filedb});
  final String filedb;

  static Database? _database;

  Future<Database> get database async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, filedb);
    if (_database != null) return _database!;
    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
    });
    return _database!;
  }
}