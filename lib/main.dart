import 'package:bonappetit/Paginas/Setup/inicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Paginas/Setup/signIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
      //DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      title: 'BonAppetit',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: PaginaInicio(),
    );
  }
} // fin de la clase
