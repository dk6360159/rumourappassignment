   import 'package:rumour/core/local_db/tables/table_names.dart';
import 'package:sqflite/sqflite.dart';




    Future<void> createMyRoomsTable(Database db)async{
      await db.execute('''
      CREATE TABLE $roomTableName(
        id TEXT PRIMARY KEY,
        roomCode TEXT NOT NULL,
        senderId TEXT NOT NULL,
        myname TEXT NOT NULL,
        createDate INT NOT NULL
       
        
      );
    ''');


    }