import 'package:desafiojusta1_0/pages/home/home.dart';
import 'package:desafiojusta1_0/theme/theme.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTreme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: ''),
    );
  }
}
