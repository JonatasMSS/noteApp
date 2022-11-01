import 'dart:developer';

import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class HomePageController extends GetxController {
  late Database DB;
  @override
  Future<void> onReady() async {
    super.onReady();

    DB = await openDatabase(
      p.join(await getDatabasesPath(), "notesapp/database/notesData.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE IF NOT EXISTS notas(id INTERGER PRIMARY KEY,title varchar(30), description varchar(350));");
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> listAllNotes() async {
    final _myDb = await DB.query('notas');

    return List.generate(_myDb.length, (i) {
      return {
        'id': _myDb[i]['id'],
        'title': _myDb[i]['title'],
        'description': _myDb[i]['description'],
      };
    });
  }
}
