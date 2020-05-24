import 'package:bonappetit/Paginas/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
} // fin de la clase LoginPage

class _SignInState extends State<SignIn> {
  String email, pass;
  final GlobalKey<FormState> claveform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // barra de la app
      appBar: AppBar(),
      // formulario de inicio de sesion
      body: Form(
        key: claveform,
        /* se crea un formulario dentro de una columna que tendra un campo de formulario de
           texto que valide el email, indique la variable en la que se guarda y una decoracion
         */
        child: Column(
          children: <Widget>[
            // email
            TextFormField(
              // ignore: missing_return
              validator: (input) {
                if (input.isEmpty) {
                  return 'El campo no puede quedar vacío';
                } // fin if validacion email
              },
              onSaved: (input) => email = input,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            // password
            TextFormField(
              // ignore: missing_return
              validator: (input) {
                if (input.length < 6) {
                  return 'La contraseña debe tener al menos 6 caracteres';
                } // fin if validacion pass
              },
              onSaved: (input) => pass = input,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: iniciaSesion,
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }

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

        //TODO: Enviar a la pagina de inicio
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home(autenticador.user)));
      } catch (e) {
        print(e.message());
      } // catch usuario no se ha logueado
    } // fin if validacion de usuario
  } // fin metodo iniciaSesion
} // fin de la clase _LoginPageState
