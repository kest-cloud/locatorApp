// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator/screens/map.dart';
import 'cubit/location_cubit.dart';

void main() {
  runApp(BlocProvider(
    create: (BuildContext context) => LocationCubit(),
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
