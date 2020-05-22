import 'package:flutter/material.dart';
import 'package:pelis_app/pages/detalle_page.dart';
import 'package:pelis_app/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PelisApp',
      initialRoute: '/',
      routes:{
        '/'       :     (BuildContext context) => HomePage(),
        'detalle' :     (BuildContext context) => DetallePage()
      },
    );
  }
}
