// En: handlers/Sqlite_handler.dart

import 'package:afoooooo/common/Usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite_handler {
  // Abre la base de datos (o la crea si no existe)
  Future<Database> getDB() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'datos.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Se ejecuta solo la primera vez para crear la tabla
  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios(
        usuario TEXT PRIMARY KEY,
        pass TEXT NOT NULL,
        nombre TEXT,
        correo TEXT NOT NULL
      )
    ''');
  }

  // --- FUNCIÓN PARA INSERTAR USUARIOS DE FORMA SEGURA ---
  Future<void> insertarUsuario(Usuario usuario) async {
    final db = await getDB();
    try {
      await db.insert(
        'usuarios',
        usuario.toMap(),
        // Lanza una excepción si el usuario (PRIMARY KEY) ya existe.
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
    } catch (e) {
      // Re-lanza el error para que la UI pueda capturarlo y mostrar un mensaje.
      throw Exception('El nombre de usuario ya existe.');
    }
  }

  // --- FUNCIÓN NUEVA PARA VALIDAR USUARIO Y CONTRASEÑA ---
  Future<Usuario?> getUsuario(String username, String password) async {
    final db = await getDB();
    final List<Map<String, Object?>> maps = await db.query(
      'usuarios',
      where: 'usuario = ? AND pass = ?', // Consulta segura
      whereArgs: [username, password],   // Evita inyección SQL
    );

    if (maps.isNotEmpty) {
      // Si se encontró un usuario, lo devuelve como un objeto.
      return Usuario.fromMap(maps.first);
    }
    // Si no se encontró, devuelve null.
    return null;
  }
}
