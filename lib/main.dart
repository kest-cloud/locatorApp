// @dart=2.9

import 'package:flutter/material.dart';
import 'package:locator/screens/map.dart';
import 'package:provider/provider.dart';

import 'controllers/mapprovider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => MapProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Storage',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Map(),
    );
  }
}
