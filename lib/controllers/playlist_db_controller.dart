import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vinylproject/model/playlist.dart';
class PlaylistDBController {
  static  var database;
  static init() async{

    database = openDatabase(

        join( await getDatabasesPath(), 'playlist.db'),

    onCreate: (db, version) {
    return db.execute(
    'CREATE TABLE playlist(id INTEGER PRIMARY KEY  AUTO_INCREMENT, '
    'nome TEXT, '
        'sottotitolo TEXT, '
    'tipo INTEGER '
    ')',
    );
    },

    version: 1,
    );

  }

    static Future<void> insertPlaylist(PlayList playlist) async {
      // Get a reference to the database.
      await init();
      final db = await database;


      await db.insert(
        'playlist',
        playlist.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.close();
    }


  static Future<List<PlayList>> Playlists(int type) async {
    await init();
      final db = await database;


      final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT id, nome, sottotitolo, tipo FROM playlist WHERE tipo=?',[type]);


      return List.generate(maps.length, (i) {
        return PlayList(
          id: maps[i]['id'],
          nome: maps[i]['nome'],
            sottotitolo: maps[i]['sottotitolo'],
          tipo: maps[i]['tipo']

        );
      });
    await db.close();
    }
    Future<void> deletePlaylist(int id) async {

      final db = await database;


      await db.delete(
        'playlist',

        where: 'id = ?',

        whereArgs: [id],
      );
    }
  }

