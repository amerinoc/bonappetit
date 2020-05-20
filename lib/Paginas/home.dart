import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  final FirebaseUser usuario;
  const Home({Key key, this.usuario}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
} // fin clase Home

class _HomeState extends State<Home> {
  final databaseReference = Firestore.instance;
  int _indexActual = 0;
  /* List cardList = [
    Item1(),
    Item2(),
    Item3(),
    Item4(),
  ];*/
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          width: 75,
          height: 75,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
            splashColor: Colors.orange[900],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.album),
          ),
          title: Text('BonAppetit'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.phone),
            )
          ],
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            // widget BARRA BUSQUEDA
            /* Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBar(),
              ),
            ),*/
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/entrantestock.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 75.0,
                      height: 75.0,
                      child: Center(
                        child: Text("Entrantes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold)),
                      )),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('images/comidastock.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 75.0,
                    height: 75.0,
                    child: Center(
                      child: Text("Primeros",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('images/segundostock.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 75.0,
                    height: 75.0,
                    child: Center(
                      child: Text("Segundos",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('images/postrestock.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 75.0,
                    height: 75.0,
                    child: Center(
                      child: Text("Postres",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.black,
            )
          ],
        ));
  } // fin Widget build()
} // fin de la clase _HomeState
