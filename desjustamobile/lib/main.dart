import 'package:desjustamobile/pages/home/home.dart';
import 'package:desjustamobile/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Justa Photos',
      debugShowCheckedModeBanner: false,
      theme: lightTreme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: Home(),
    );
  }
}
