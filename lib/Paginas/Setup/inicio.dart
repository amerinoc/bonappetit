import 'package:bonappetit/Paginas/Setup/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MainPage/home.dart';
import 'signUp.dart';

// clase dedicada al inicio de sesion y creacion de cuentas
class PaginaInicio extends StatefulWidget {
  @override
  _PaginaInicioState createState() => _PaginaInicioState();
} // fin clase PaginaInicio

class _PaginaInicioState extends State<PaginaInicio> {
  String email, pass, username;
  final GlobalKey<FormState> claveform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('BonAppetit'),
      ),
      // se crea una columna con dos botones para cada funcion
      body: Form(
        key: claveform,
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: Image.asset(
                  'images/bonappetit_logo.png',
                  height: 200,
                  width: 200,
                ),
              ),

              // Campo EMAIL
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                width: 300.0,
                child: TextFormField(
                  // ignore: missing_return
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'El campo no puede quedar vacío';
                    } // fin if validacion email
                  },
                  initialValue: 'merino.alberto34@gmail.com',
                  onSaved: (input) => email = input,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange[700]),
                    ),
                  ),
                ),
              ),

              // Campo CONTRASEÑA
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: 300.0,
                child: TextFormField(
                  // ignore: missing_return
                  initialValue: '123456',
                  // ignore: missing_return
                  validator: (input) {
                    if (input.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    } // fin if validacion pass
                  },
                  onSaved: (input) => pass = input,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange[700]),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              // boton INICIO DE SESION
              Container(
                margin: const EdgeInsets.only(top: 60.0),
                child: RaisedButton(
                  padding: const EdgeInsets.only(
                      left: 80.0, right: 80.0, top: 20.0, bottom: 20.0),
                  color: Colors.white,
                  textColor: Colors.orange[900],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.brown[800]),
                  ),
                  // ejecuta metodo de inicio de sesion
                  onPressed: iniciaSesion,
                  child: Text('Inicia Sesión'),
                ),
              ),

              // DIVIDER
              Container(
                margin: const EdgeInsets.only(top: 135.0),
                //margin: const EdgeInsets.only(top: 170.0),
                child: Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 50.0),
                child: Row(
                  children: <Widget>[
                    Text('¿No tienes una cuenta?'),
                    FlatButton(
                      padding: const EdgeInsets.only(left: 25.0),
                      onPressed: () {
                        crearCuenta();
                      },
                      child: Text('Crea una cuenta'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // fin build Widget

  Future<void> iniciaSesion() async {
    // se extrae la clave del inicio de sesion y si es correcto el usuario se loguea
    // en FireBase

    final signFormulario = claveform.currentState;
    if (signFormulario.validate()) {
      signFormulario.save();
      try {
        // conexion del usuario
        AuthResult autenticador = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);
        FirebaseUser user = autenticador.user;
        if (user.isEmailVerified) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Home(autenticador.user)));
        } else {
          Container(
            child: Text('Debes verificar tu correo.'),
          );
        }
      } catch (e) {
        print(e.message());
      } // catch usuario no se ha logueado
    } // fin if validacion de usuario
  } // fin metodo iniciaSesion

  void crearCuenta() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUp(), fullscreenDialog: true));
  }
} // fin de la clase PaginaInicioState
