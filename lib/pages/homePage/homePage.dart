import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:notesapp/Components/Widgets/listItemWidget.dart';
import 'package:notesapp/Components/models/notesModel.dart';
import 'package:notesapp/pages/homePage/homePageController.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 250, 244),
      appBar: AppBar(
        title: Text("Minhas Notas"),
      ),
      body: FutureBuilder(
        future: controller.listAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListItemWidget(
                  titleW: "A",
                );
              },
            );
          }
          return Center(
            child: Text("NO DATA"),
          );
        },
      ),
    );
  }
}
