import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ptracker/pages/index_page.dart';
import 'package:ptracker/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 10)),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const IndexPage();
            }
            return const SplashPage();
          })),
    );
  }
}
