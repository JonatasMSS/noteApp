import 'package:get/get.dart';
import 'package:notesapp/Components/models/notesModel.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class HomePageController extends GetxController {
  Future<List<NotesModel>> listAllNotes(Database DB) async {
    final _myDb = DB;
    final List<Map<String, dynamic>> _notesMap = await _myDb.query('notas');
    return List.generate(_notesMap.length, (i) {
      return NotesModel(
          id: _notesMap[i]['id'],
          title: _notesMap[i]['title'],
          description: _notesMap[i]['description']);
    });
  }

  Future<void> insertNote(NotesModel nota, Database DB) async {
    final _myDb = DB;
    _myDb.insert('notas', nota.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeNote(int id, Database DB) async {
    final _myDb = DB;
    _myDb.delete(
      'notas',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> editNote(NotesModel note, Database DB) async {
    final _myDB = DB;
    DB.update('notas', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> closeDB(Database DB) async {
    DB.close();
  }
}
