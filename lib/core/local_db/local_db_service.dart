
import 'package:rumour/core/base_service/base_service.dart';
import 'package:rumour/core/extensions/log_extensions.dart';
import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/local_db/local_db_provider.dart';
import 'package:sqflite/sqflite.dart';

// import 'local_db_provider.dart';

class LocalDbService extends BaseService {
  LocalDbService() : super(serviceMode: ServiceMode.appOnly);

  // static final LocalDbService instance = LocalDbService._(d);
 late Database _db;

  Database get appdatabase => _db;

  // ---------------------------------------------------------------------------
  // INSERT
  // ---------------------------------------------------------------------------

  Future<DataMap?> insert({
    required String table,
    required Map<String, dynamic> values,
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.abort,
  }) async {
    final db =  _db;

    await db.insert(
      table,
      values,
      conflictAlgorithm: conflictAlgorithm,
    );

    final temp=await findById(table: table,id: values['id']);
    return temp;


  }

  // ---------------------------------------------------------------------------
  // BULK INSERT
  // ---------------------------------------------------------------------------

  Future<List<DataMap>> insertMany({
    required String table,
    required List<Map<String, dynamic>> values,
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.abort,
  }) async {
    final db =  _db;

    final batch = db.batch();

    for (final value in values) {
      batch.insert(
        table,
        value,
        conflictAlgorithm: conflictAlgorithm,
      );
    }

    await batch.commit(noResult: true);

   final temp= findAll(table: table,where: "id=?",whereArgs: values.map((e)=>e['id']).toList());
   return temp;
  }

  // ---------------------------------------------------------------------------
  // UPSERT
  // ---------------------------------------------------------------------------

  Future<int> upsert({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    final db =  _db;

    return db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ---------------------------------------------------------------------------
  // FIND BY ID
  // ---------------------------------------------------------------------------

  Future<Map<String, dynamic>?> findById({
    required String table,
    required String id,
  }) async {
    final db =  _db;

    final result = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return result.first;
  }

  // ---------------------------------------------------------------------------
  // FIND ALL
  // ---------------------------------------------------------------------------

  Future<List<Map<String, dynamic>>> findAll({
    required String table,
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db =  _db;

    return db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }


  Future<int> patch({
  required String table,
  required String id,
  required Map<String, dynamic> values,
}) async {
  final db =  _db;

  return db.update(
    table,
    values,
    where: 'local_id = ?',
    whereArgs: [id],
  );
}

  // ---------------------------------------------------------------------------
  // COUNT
  // ---------------------------------------------------------------------------

  Future<int> count({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db =  _db;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as count
      FROM $table
      ${where != null ? "WHERE $where" : ""}
      ''',
      whereArgs,
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ---------------------------------------------------------------------------
  // EXISTS
  // ---------------------------------------------------------------------------

  Future<bool> exists({
    required String table,
    required String id,
  }) async {
    return (await findById(
          table: table,
          id: id,
        )) !=
        null;
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<int> update({
    required String table,
    required Map<String, dynamic> values,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db =  _db;

    return db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<int> delete({
    required String table,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db =  _db;

    return db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // ---------------------------------------------------------------------------
  // DELETE ALL
  // ---------------------------------------------------------------------------

  Future<int> clearTable(String table) async {
    final db =  _db;

    return db.delete(table);
  }

  // ---------------------------------------------------------------------------
  // RAW QUERY
  // ---------------------------------------------------------------------------

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db =  _db;

    return db.rawQuery(sql, arguments);
  }

  // ---------------------------------------------------------------------------
  // RAW INSERT
  // ---------------------------------------------------------------------------

  Future<int> rawInsert(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db =  _db;

    return db.rawInsert(sql, arguments);
  }

  // ---------------------------------------------------------------------------
  // RAW UPDATE
  // ---------------------------------------------------------------------------

  Future<int> rawUpdate(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db =  _db;

    return db.rawUpdate(sql, arguments);
  }

  // ---------------------------------------------------------------------------
  // RAW DELETE
  // ---------------------------------------------------------------------------

  Future<int> rawDelete(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db =  _db;

    return db.rawDelete(sql, arguments);
  }

  // ---------------------------------------------------------------------------
  // TRANSACTION
  // ---------------------------------------------------------------------------

  Future<T> transaction<T>(
    Future<T> Function(Transaction txn) action,
  ) async {
    final db =  _db;

    return db.transaction(action);
  }

  // ---------------------------------------------------------------------------
  // BATCH
  // ---------------------------------------------------------------------------

  Future<void> batch(
    Future<void> Function(Batch batch) action,
  ) async {
    final db =  _db;

    final batch = db.batch();

    await action(batch);

    await batch.commit();
  }
  
  @override
  Future<void> onCleanup() {
  
    throw UnimplementedError();
  }
  
  @override
  Future<void> onCloseup() {
   
    throw UnimplementedError();
  }
  
  @override
  Future<void> onInit()async {
    'Local Db service init started'.logInfo();
  _db= await LocalDbProvider.instance.database;
  }
}