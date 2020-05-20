import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home extends StatefulWidget {
  final FirebaseUser usuario;
  const Home({Key key, this.usuario}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
} // fin clase Home

class _HomeState extends State<Home> {
  final databaseReference = Firestore.instance;
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
        children: <Widget>[],
      ),
    );
  } // fin Widget build()
} // fin de la clase _HomeState
