//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'hansel_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Hansel',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        barBackgroundColor: Colors.pink,
        primaryColor: Colors.white54,
      ),
      home: const HanselView(),
      debugShowCheckedModeBanner: false,
    );
  }
}


