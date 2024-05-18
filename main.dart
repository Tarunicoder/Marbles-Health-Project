// import 'package:flutter/material.dart';
//
// import 'addhospital_screen.dart';
// import 'login_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//       // home: SignUpScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'assigment.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

void setupLocator() {
  GetIt.I.registerSingleton<FormData>(FormData());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
