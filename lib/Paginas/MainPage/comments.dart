import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  // constructor con el dato de la receta escogida
  const Comments({Key key, this.comentarios}) : super(key: key);
  final List<String> comentarios;
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final db = Firestore.instance;
  String comentario, username, iduser;
  DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Comentarios'),
      ),
      // se mantiene la estructura dentro de la pantalla
      body: SafeArea(
        // se hace la pantalla scrollable
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              devuelveComentarios(),
            ],
          ),
        ),
      ),
    );
  }

  Widget devuelveComentarios() {
    if (widget.comentarios[0] != "") {
      for (var i = 0; i < widget.comentarios.length; i++) {
        compruebaDBRecetasComment(widget.comentarios[i].toString())
            .then((String resultado) {
          setState(() {
            comentario = resultado;
          });
        });
        compruebaDBRecetasUsername(widget.comentarios[i].toString())
            .then((String resultado) {
          setState(() {
            username = resultado;
          });
        });
        compruebaDBRecetasTimeStamp(widget.comentarios[i].toString())
            .then((DateTime resultado) {
          setState(() {
            timestamp = resultado;
          });
        });
        return Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[400])),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('images/entrantestock.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 40.0,
                    height: 40.0,
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                  ),
                  Container(
                    child: Text(
                      username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(top: 10.0),
                child: Text(comentario),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 5.0),
                alignment: Alignment.bottomLeft,
                child: Text(timestamp.toString().substring(0, 10)),
              ),
            ],
          ),
        );
      } // fin bucle itereacion sobre id comentarios
    } else {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 330),
          child: Text(
              'El post no tiene comentarios ¡Sé el primero en decir algo!'),
        ),
      );
    }
  }

  Future<String> compruebaDBRecetasComment(String idcomentario) async {
    // se realiza una consulta a la BBDD para sacar el comentario
    DocumentSnapshot _miDocComm =
        await db.collection('comentarios').document(idcomentario).get();
    return _miDocComm.data['comment'].toString();
  }

  Future<String> compruebaDBRecetasUsername(String idcomentario) async {
    // se realiza una consulta a la BBDD para sacar el nombre de usuario
    DocumentSnapshot _miDocComm =
        await db.collection('comentarios').document(idcomentario).get();

    return _miDocComm.data['username'].toString();
  }

  Future<DateTime> compruebaDBRecetasTimeStamp(String idcomentario) async {
    // se realiza una consulta a la BBDD para sacar la fecha
    DocumentSnapshot _miDocComm =
        await db.collection('comentarios').document(idcomentario).get();
    return DateTime.parse(_miDocComm.data['fecha_post'].toDate().toString());
  } // fin metodo compruebaDBRecetas()
}
