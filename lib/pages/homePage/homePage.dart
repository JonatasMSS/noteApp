import 'dart:math';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:notesapp/Components/Widgets/listItemWidget.dart';
import 'package:notesapp/Components/models/notesModel.dart';
import 'package:notesapp/pages/homePage/homePageController.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late Database db;

  late Database db;
  HomePageController controller = HomePageController();
  List<NotesModel> notesList = [];

  openDB() async {
    db = await openDatabase(
      p.join(await getDatabasesPath(), "notesapp/database/myNotes.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE notas(id integer not null ,title varchar(30), description varchar(350),PRIMARY KEY(id));");
      },
      version: 1,
    );

    await controller.listAllNotes(db).then((value) {
      setState(() {
        notesList = value;
      });
    });
  }

  refreshNotes() async {
    await controller.listAllNotes(db).then((value) {
      setState(() {
        notesList = value;
      });
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    openDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          splashColor: Colors.blue.shade300,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => controller.dialogNote(
                controller.titleController.value,
                controller.descriptionController.value,
                context,
                db,
              ),
            ).whenComplete(() => refreshNotes());
          },
          icon: const Icon(Icons.add),
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 253, 250, 244),
      appBar: AppBar(
        title: Text("Minhas Notas"),
      ),
      body: Builder(
        builder: (context) {
          if (notesList.isNotEmpty) {
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final NotesModel myNote = notesList[index];
                excludeNote() async {
                  await controller
                      .removeNote(myNote.id, db)
                      .then((value) => refreshNotes());
                }

                return ListItemWidget(
                  titleW: myNote.title,
                  description: myNote.description,
                  excludeFuntion: excludeNote,
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "Nenhum nota, adicione uma!",
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
