import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite_handler {
  Future<Database> getDB() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'datos.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  void _onCreate(Database db, int version) async{
    await db.execute('''
    create table usuarios(
      usuario text prymary key,
      pass text,
      nombre text,
      correo text
    )
    ''');
  }
}