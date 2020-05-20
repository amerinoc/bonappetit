import 'package:bonappetit/Paginas/Setup/inicio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, pass;
  bool _valorChk = false;
  final GlobalKey<FormState> claveform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // barra de la app
      appBar: AppBar(
        title: Text('Crear una cuenta'),
      ),
      // formulario de inicio de sesion
      body: Center(
        child: Form(
          key: claveform,
          /* se crea un formulario dentro de una columna que tendra un campo de formulario de
             texto que valide el email, indique la variable en la que se guarda y una decoracion
           */
          child: Column(
            children: <Widget>[
              // Campo EMAIL CREAR
              Container(
                width: 340.0,
                margin: const EdgeInsets.only(top: 40.0),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'El campo no puede quedar vacío';
                    } // fin if validacion email
                  },
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

              // Campo CONTRASEÑA CREAR
              Container(
                width: 340.0,
                margin: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
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

              // contenedor AVISO PARA NAVEGANTES
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Recuerda ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Container(
                      width: 300.0,
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        '''
- Debes introducir un email válido. 
                
- La contraseña debe tener 6 caracteres como mínimo 

- Verificar tu correo una vez registrado''',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),

              // contenedor CHCKBOX LICENCIAS
              Container(
                margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: _valorChk,
                      onChanged: (bool valor) {
                        setState(() {
                          _valorChk = valor;
                        });
                      },
                    ),
                    Text('He leído y acepto los términos y licencias.'),
                  ],
                ),
              ),

              Divider(
                thickness: 0.5,
                indent: 50.0,
                endIndent: 50.0,
                color: Colors.brown[800],
              ),

              // boton CREAR CUENTA
              Container(
                margin: const EdgeInsets.only(top: 15.0),
                child: botonCrearAcc(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: Image.asset(
                  'images/bonappetit_logo.png',
                  height: 100,
                  width: 130,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child:
                    Text('© BonAppetit, 2020. Todos los derechos reservados.'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> crearUsuario() async {
    // se extrae la clave del inicio de sesion y si es correcto el usuario se loguea
    // en FireBase

    final signFormulario = claveform.currentState;
    if (signFormulario.validate()) {
      signFormulario.save();
      try {
        // conexion del usuario
        AuthResult autenticador = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
        FirebaseUser usuario = autenticador.user;
        usuario.sendEmailVerification();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PaginaInicio()));
      } catch (e) {
        print(e.message());
      } // catch usuario no se ha logueado
    } // fin if validacion de usuario
  } // fin metodo crearUsuario()

  Widget botonCrearAcc() {
    return RaisedButton(
      padding: const EdgeInsets.only(
          left: 80.0, right: 80.0, top: 20.0, bottom: 20.0),
      color: Colors.orange[900],
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.brown[800]),
      ),
      child: Text('Crear Cuenta'),
      onPressed: () {
        if (_valorChk) {
          crearUsuario();
        } else {}
      },
    );
  } // fin metodo boton()
} // fin de la clase
