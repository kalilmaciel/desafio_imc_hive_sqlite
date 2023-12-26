import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: ''' CREATE TABLE medicoes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          altura DECIMAL,
          peso DECIMAL
        );
      '''
};

class DatabaseSqlite {
  static Database? db;

  static Future<Database?> initDatabase() async {
    var databasePath = await getDatabasesPath();
    String caminho = path.join(databasePath, 'medicoes.db');
    db ??= await openDatabase(
      caminho,
      version: scripts.length,
      onCreate: (Database db, int version) async {
        for (var i = 1; i <= scripts.length; i++) {
          if (scripts[i] != null) {
            await db.execute(scripts[i]!);
            debugPrint(scripts[i]!);
          }
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (var i = oldVersion + 1; i <= scripts.length; i++) {
          if (scripts[i] != null) {
            await db.execute(scripts[i]!);
            debugPrint(scripts[i]);
          }
        }
      },
    );
    return db;
  }
}
