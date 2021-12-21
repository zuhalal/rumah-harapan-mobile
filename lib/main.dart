import 'package:donasi/screens/donasi_add_form.dart';
import 'package:donasi/screens/donasi_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DonasiHome(),
      routes: <String, WidgetBuilder>{
        '/donasi': (context) => DonasiHome(),
        '/add-donasi': (context) => AddDonasiForm(),
      },
    );
  }
}
