import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Details extends StatefulWidget {
  const Details(
      {Key key,
      this.imagen,
      this.descripcion,
      this.ingredientes,
      this.nombre,
      this.cantidad})
      : super(key: key);
  final String imagen;
  final String descripcion;
  final List<String> ingredientes;
  final String nombre;
  final List<String> cantidad;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.nombre),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    // margin: const EdgeInsets.only(bottom: 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        widget.imagen,
                        // width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          spreadRadius: 5,
                          blurRadius: 7,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 180.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.orange[500],
                            spreadRadius: 1,
                            blurRadius: 7,
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 2.0, color: Colors.red[900]),
                              ),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              child: Center(
                                child: Text(
                                  'INGREDIENTES',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.orange[800],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                              ),
                            ),
                          ),
                          Container(
                            child: muestraIngredientes(
                                widget.ingredientes, widget.cantidad),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(15.0),
                child: Text(widget.descripcion),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(15.0),
                child: Text(widget.descripcion),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(15.0),
                child: Text(widget.descripcion),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(15.0),
                child: Text(widget.descripcion),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget muestraIngredientes(
      List<String> ingredientes, List<String> cantidades) {
    List<Widget> lista = new List<Widget>();
    var i = 0;
    for (i; i < ingredientes.length; i++) {
      print(ingredientes[i]);
      if (i == ingredientes.length - 1) {
        print('ENTRO EN EL SEGUNDO IF');
        lista.add(
          Container(
            decoration: BoxDecoration(
              //color: Colors.red[900],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                /* border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.red[900]),
                ),*/
              ),
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Text(
                      ingredientes[i],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      cantidades[i],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        lista.add(
          Container(
            //color: Colors.red[900],
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.red[900]),
                ),
              ),
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Text(
                      ingredientes[i],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      cantidades[i],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    } // fin for loop ingredientes

    return Column(
      children: lista,
    );
  } // fin metodo muestraIngredientes()

} // fin de la clase _DetailsState
