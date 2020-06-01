import 'package:bonappetit/Paginas/Setup/inicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Paginas/Setup/signIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Inicio de la aplicacion
  @override
  Widget build(BuildContext context) {
    // se indica a la aplicacion que no se pueda girar la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
      //DeviceOrientation.portraitDown
    ]);
    // color principal de la app, el naranja y se redirige a la clase principal
    return MaterialApp(
      title: 'BonAppetit',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: PaginaInicio(),
    );
  }
} // fin de la clase
