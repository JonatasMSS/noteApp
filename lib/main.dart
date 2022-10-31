import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:notesapp/pages/homePage/homePage.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
        )
      ],
    );
  }
}
