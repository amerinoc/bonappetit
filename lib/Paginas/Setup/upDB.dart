import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class upDB extends StatefulWidget {
  @override
  _upDBState createState() => _upDBState();
}

class _upDBState extends State<upDB> {
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          RaisedButton(
            child: Text('Sube a BBDD'),
            onPressed: subeBD,
          )
        ],
      ),
    );
  }

  void subeBD() {
    List<String> ingr = [
      "Lechuga",
      "Tomate",
      "Cebolla",
      "Maíz",
      "Aceite",
      "Vinagre"
    ];
    String prep =
        "Cortas todos los ingredientes, los echas a un bol, aderezar al gusto con aceite, vinagre y sal.";
    String fecha = '19-05-2020';
    final df = new DateFormat('dd-MM-yyyy');
    DateTime fecha_ahora = DateTime.now();
    df.format(fecha_ahora);

    uploadingData(
        2, "Ensalada Mixta", ingr, "Entrante", prep, 150, fecha_ahora, 1);
  }

  Future<void> uploadingData(
      int id_receta,
      String nombre,
      List ingredientes,
      String tipo_plato,
      String preparacion,
      int calorias,
      DateTime fecha_subida,
      int id_user) async {
    // primero se ubica la posicion en la BBDD en la que se va a realizar la insercion
    await databaseReference
        .collection("recetas")
        .document("$id_receta")
        .setData({
      'nombre': nombre,
      'ingredientes': ingredientes,
      'tipo_plato': tipo_plato,
      'preparacion': preparacion,
      'calorias': calorias,
      'fecha_subida': fecha_subida,
      'id_user': id_user
    });
    // seguidamente se añaden los datos
    // en el caso de que ya exista el documento, crea una nuevo con una ID dada por Firestore
    DocumentReference ref = await databaseReference.collection("recetas").add({
      'nombre': nombre,
      'ingredientes': ingredientes,
      'tipo_plato': tipo_plato,
      'preparacion': preparacion,
      'calorias': calorias,
      'fecha_subida': fecha_subida,
      'id_user': id_user
    });
    //print(ref.documentID);
    print(databaseReference.toString());
  } // fin metodo upladingData()

} // fin de la clase
