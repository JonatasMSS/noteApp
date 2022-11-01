import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:notesapp/pages/homePage/homePage.dart';
import 'package:notesapp/pages/homePage/homePageBindings.dart';

Future<void> main() async {
  runApp(const Main());
  WidgetsFlutterBinding.ensureInitialized();
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
          binding: HomePageBindings(),
        )
      ],
    );
  }
}
