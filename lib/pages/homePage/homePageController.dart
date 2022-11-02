import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:notesapp/Components/models/notesModel.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class HomePageController extends GetxController {
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

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

  Widget dialogNote(
    TextEditingController? title,
    TextEditingController? description,
    BuildContext context,
    Database DB,
  ) {
    return AlertDialog(
      title: const Text("Adicionar nova nota"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Titulo da nota",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              controller: title,
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Comece por aqui...",
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  )),
              controller: description,
              autocorrect: true,
              maxLines: 10,
            )
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              dynamic tempId = 0;
              await listAllNotes(DB)
                  .then((value) => tempId = value.isEmpty ? 0 : value.length);
              print("Temp Id Value:$tempId");

              NotesModel tempNote = NotesModel(
                  id: tempId,
                  title: title!.text,
                  description: description!.text);
              await insertNote(tempNote, DB).then(
                (value) {
                  refresh();
                  title.clear();
                  description.clear();
                  Navigator.pop(context);
                },
              );
            },
            icon: const Icon(Icons.check)),
        IconButton(
            onPressed: () {
              title?.clear();
              description?.clear();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close_sharp))
      ],
    );
  }
}
