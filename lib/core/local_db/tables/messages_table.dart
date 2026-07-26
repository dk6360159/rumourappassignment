   import 'package:rumour/core/local_db/tables/table_names.dart';
import 'package:sqflite/sqflite.dart';




    Future<void> createMessageTable(Database db)async{
      await db.execute('''
      CREATE TABLE $messageTableName(
        id TEXT PRIMARY KEY,
        text TEXT NOT NULL,
        roomCode TEXT NOT NULL,
        senderId TEXT NOT NULL,
        senderName TEXT NOT NULL,
        createDate INTEGER NOT NULL
        
      );
    ''');


    }