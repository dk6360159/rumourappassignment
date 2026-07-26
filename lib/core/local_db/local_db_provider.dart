import 'package:path/path.dart' as p;
import 'package:rumour/core/local_db/tables/messages_table.dart';
import 'package:rumour/core/local_db/tables/my_rooms_table.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbProvider {
  LocalDbProvider._();

  static final LocalDbProvider instance = LocalDbProvider._();

  static const String _dbName = 'car_booking.db';
  static const int _dbVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _openDatabase();

    return _database!;
  }

  Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      p.join(dbPath, _dbName),
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _onConfigure(Database db) async {
    // Enable foreign key constraints
    await db.execute('PRAGMA foreign_keys = ON;');
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // Migration for version 2
    }

    if (oldVersion < 3) {
      // Migration for version 3
    }
  }

  Future<void> _createTables(Database db) async {

   await createMessageTable(db);
   await createMyRoomsTable(db);
 


  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}