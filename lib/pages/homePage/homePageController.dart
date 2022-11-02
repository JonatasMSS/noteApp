import 'package:get/get.dart';
import 'package:notesapp/Components/models/notesModel.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class HomePageController extends GetxController {
  late Database DB;
  final int a = 1;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final NotesModel Note =
        NotesModel(id: 1, title: "A", description: "Descript");

    DB = await openDatabase(
      p.join(await getDatabasesPath(), "notesapp/database/myNotes.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE notas(id integer not null ,title varchar(30), description varchar(350),PRIMARY KEY(id));");
      },
      version: 1,
    );
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    //insertNote(Note);
    //closeDB();
  }

  Future<List<NotesModel>> listAllNotes() async {
    final _myDb = DB;
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
