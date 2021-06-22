import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vinylproject/model/brano.dart';

class BranoDBController {
  static var database;

  static init() async {

    database = openDatabase(
      join(await getDatabasesPath(), 'brani.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE brano(id INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, '
          'nome TEXT, '
          'path TEXT, '
          'url TEXT, '
          'image TEXT, '
          'channel TEXT, '
          'idPlayList INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertBrano(Brano brano) async {
    await init();
    // Get a reference to the database.
    final db = await database;

    await db.insert(
      'brano',
      brano.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.close();
  }

  static Future<List<Brano>> brani(int type) async {
    await init();
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT id, nome, channel, idPlaylist, url,path,image FROM brano WHERE idPlaylist=?',[type]);

    return List.generate(maps.length, (i) {
      return Brano(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        path: maps[i]['path'],
        url: maps[i]['url'],
        channel: maps[i]['channel'],
        idPlaylist: maps[i]['idPlaylist'],
        image: maps[i]['image'],
      );
    });
    await db.close();
  }

  static Future<void> deleteBrano(int id) async {
    await init();
    final db = await database;

    await db.delete(
      'brano',
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.close();
  }
}
