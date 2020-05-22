import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  final FirebaseUser usuario;
  const Home({Key key, this.usuario}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
} // fin clase Home

class _HomeState extends State<Home> {
  final databaseReference = Firestore.instance;
  String userid, username;
  int _indexActual = 0;
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
                  ),
                ),
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
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
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
                          margin: const EdgeInsets.only(left: 10.0),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'username',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 0.1,
                      color: Colors.black,
                    ),
                    Container(
                      child: Text(
                        'Tortilla de Patatas',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //alignment: Alignment(-1.0, 0.0),
                      margin: const EdgeInsets.only(left: 10.0),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Image.asset('images/postrestock.jpg'),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.fastfood),
                              ),
                              IconButton(
                                icon: Icon(Icons.fastfood),
                              ),
                              IconButton(
                                icon: Icon(Icons.fastfood),
                              ),
                            ],
                          ),
                          Divider(),
                          Text(
                              'La mejor manera de realizar una tortilla de patatas es cortar todos los trozos de manera equitativa y dejarlos cocinar durante mucho tiempo')
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  } // fin Widget build()
} // fin de la clase _HomeState
