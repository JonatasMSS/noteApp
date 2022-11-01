import 'dart:developer';

import 'package:get/get.dart';
import 'package:notesapp/Components/models/notesModel.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class HomePageController extends GetxController {
  late Database DB;
  @override
  Future<void> onReady() async {
    super.onReady();

    DB = await openDatabase(
      p.join(await getDatabasesPath(), "notesapp/database/notes.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE IF NOT EXISTS notas(id INTERGER PRIMARY KEY,title varchar(30), description varchar(350));");
      },
      version: 1,
    );

    final noteA =
        NotesModel(id: 1, title: 'Teste A ', description: 'Descricao de teste');

    print("Buscando Dados");
    print(await listAllNotes());
  }

  Future<List<NotesModel>> listAllNotes() async {
    final _myDb = await DB;
    final List<Map<String, dynamic>> _notesMap = await _myDb.query('notas');
    return List.generate(_notesMap.length, (i) {
      return NotesModel(
          id: _notesMap[i]['id'],
          title: _notesMap[i]['title'],
          description: _notesMap[i]['description']);
    });
  }

  Future<void> insertNote(NotesModel nota) async {
    final _myDb = await DB;
    _myDb.insert('notas', nota.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeNote(int? id) async {
    final _myDb = await DB;
    _myDb.delete(
      'notas',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> editNote(NotesModel note) async {
    final _myDB = DB;
    DB.update('notas', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> closeDB() async {
    DB.close();
  }
}
