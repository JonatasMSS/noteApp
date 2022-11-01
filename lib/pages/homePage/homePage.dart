import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:notesapp/Components/Widgets/listItemWidget.dart';
import 'package:notesapp/pages/homePage/homePageController.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 250, 244),
      appBar: AppBar(
        title: Text("Minhas Notas"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListItemWidget();
        },
      ),
    );
  }
}
