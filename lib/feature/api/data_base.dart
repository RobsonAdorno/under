import 'package:sqflite/sqflite.dart';
import 'package:under/feature/entities/entities.dart';

class DataBase {
  static Database? _database;
  static const _pathDatabase = 'under.db';
  static const _version = 1;

  static Future<void> initDatabase() async {
    _database ??= await openDatabase(_pathDatabase, version: _version,
        onCreate: (Database db, int version) {
      db.execute(_createTableQuery());
    });
  }

  static String _createTableQuery() {
    return 'CREATE TABLE user (id INTEGER PRIMARY KEY, token TEXT)';
  }

  static void inserInto(UserModel client) {
    _database?.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO user(id, token) VALUES(${client.clientId}, ${client.token})');
      print('inserted1: $id1');
    });
  }

  static void closeConnection() {
    _database?.close();
  }
}
