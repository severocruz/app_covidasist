import 'dart:io';

import 'package:app_covidasist/src/models/marcacion_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
 
  DBProvider._();

  Future<Database> get database async{
    if ( _database != null ) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentsDirectory.path, 'covidRegisterDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Marcacion('
          ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' username TEXT,'
          ' nombreEmpleado TEXT,' 
          ' fechaMarcacion TEXT,' 
          ' latitud TEXT,' 
          ' longitud TEXT,' 
          ' imagen TEXT,' 
          ' estadoSync TEXT' 
          ')'
        );
      }
    );
  }

  nuevaMarcacionRaw( Marcacion marc ) async {
    final db = await database;

    final res = await db.rawInsert(
      'INSERT Into Marcacion (username, nombreEmpleado, fechaMarcacion, latitud, longitud, imagen, estadoSync) '
      'VALUES ( ${ marc.username }, ${ marc.nombreEmpleado }, ${ marc.fechaMarcacion }, ${ marc.latitud }, ${ marc.longitud }, ${ marc.imagen }, ${ marc.estadoSync })'
    );
    return res;
  }

  nuevaMarcacion( Marcacion marc ) async {
    final db = await database;
    final res = db.insert('Marcacion', marc.toJson() );
    return res;
  }

  // SELECT - Obtener Marcacion por Usuario
  Future<Marcacion> getMarcacionUsername( String username ) async {
    final db = await database;
    final res = await db.query('Marcacion', where: 'username = ?', whereArgs: [username]);
    return res.isNotEmpty ? Marcacion.fromJson( res.first ) : null;
  }

  // Todos Las marcaciones del usuario
  Future<List<Marcacion>> getTodosMarcaciones() async {
    final db = await database;
    final res = await db.query('Marcacion');

    List<Marcacion> list = res.isNotEmpty 
                              ? res.map((s) => Marcacion.fromJson(s)).toList()
                              : [];

    return list;
    // return res.isNotEmpty ? ScanModel.fromJson( res.first ) : null;
  }

  // Todos Las marcaciones por Username
  Future<List<Marcacion>> getMarcacionesPorUsername(String username) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Marcacion WHERE username = '$username'");


    List<Marcacion> list = res.isNotEmpty 
                              ? res.map((s) => Marcacion.fromJson(s)).toList()
                              : [];

    return list;
    // return res.isNotEmpty ? ScanModel.fromJson( res.first ) : null;
  }

  // // Actualizar registros
  // Future<int> updateScan( ScanModel nuevoScan ) async {
  //   final db = await database;
  //   final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id] );
  //   return res;
  // }

  // // Eliminar registros
  // Future<int>  deleteScan( int id ) async {
  //   final db = await database;
  //   final res = db.delete('Scans', where: 'id = ?', whereArgs: [id]);
  //   return res;
  // }

  // Future<int>  deleteAll() async {
  //   final db = await database;
  //   final res = db.rawDelete('DELETE FROM Scans');
  //   return res;
  // }
}