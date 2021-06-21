import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vinylproject/model/brano.dart';
class BranoDBController {
  var database;
  init() async{

    database = openDatabase(

        join( await getDatabasesPath(), 'brani.db'),

    onCreate: (db, version) {
    return db.execute(
    'CREATE TABLE brano(id INTEGER PRIMARY KEY, '
    'nome TEXT, '
    'path TEXT, '
    'url TEXT, '
    'id_playList INTEGER)',
    );
    },

    version: 1,
    );
  }

    Future<void> insertBrano(Brano brano) async {
      // Get a reference to the database.
      final db = await database;


      await db.insert(
        'brano',
        brano.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }


    Future<List<Brano>> brani() async {

      final db = await database;


      final List<Map<String, dynamic>> maps = await db.query('brano');


      return List.generate(maps.length, (i) {
        return Brano(
          id: maps[i]['id'],
          nome: maps[i]['nome'],
          path: maps[i]['path'],
          url: maps[i]['url'].toString(),
        );
      });
    }
    Future<void> deleteBrano(int id) async {

      final db = await database;


      await db.delete(
        'brano',

        where: 'id = ?',

        whereArgs: [id],
      );
    }
  }

