import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  final FirebaseUser usuario;
  const Home(this.usuario);

  @override
  _HomeState createState() => _HomeState();
} // fin clase Home

class _HomeState extends State<Home> {
  final db = Firestore.instance;
  String userid, username;
  int ndocs = 0;
  Future _data, _usuarios;

  @override
  Widget build(BuildContext context) {
    sacaDocumentos();
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
          FutureBuilder(
              future: _data = actualizaPosts(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(child: RefreshProgressIndicator());
                } else {
                  return Container(
                    child: Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: ndocs,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/entrantestock.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width: 40.0,
                                        height: 40.0,
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                      ),
                                      Container(
                                        child: Text(
                                          snap.data[index].data['username']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //alignment: Alignment(-1.0, 0.0),
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    child:
                                        Image.asset('images/postrestock.jpg'),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.live_tv),
                                            ),
                                            Text(snap
                                                .data[index].data['nombre']),
                                            IconButton(
                                              icon: Icon(Icons.fastfood),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                }
              })
        ],
      ),
    );
  } // fin itemBuilder

  void sacaDocumentos() async {
    QuerySnapshot _miDoc = await db.collection('recetas').getDocuments();
    List<DocumentSnapshot> _miDocCount = _miDoc.documents;
    ndocs = _miDocCount.length;
  } // fin metodo sacaDocumentos()

  Future actualizaPosts() async {
    QuerySnapshot snap = await db.collection('recetas').getDocuments();
    return snap.documents;
  } // fin metodo actualizaPosts()

  Future sacaUsername(String idUser) async {
    print(idUser);
    /*QuerySnapshot snap = await db.collection('users').getDocuments();
    print(snap.toString());
    return snap.documents;*/
    await Firestore.instance
        .collection('collection')
        .where('ref', isEqualTo: idUser)
        .getDocuments()
        .then((doc) {
      username = doc.documents[1]['ref'];
    });
  } // fin metodo pintaPosts()

  /* Container pintaPosts(AsyncSnapshot snap, int index) {
    return Container(
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
                  snap.data[index].data['nombre'],
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
              'Patata',
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
          ),
        ],
      ),
    );
  }

  */

  /* Container pintaPosts(AsyncSnapshot snap) {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
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
                widget.usuario.uid,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
        Divider(
          thickness: 0.1,
          color: Colors.black,
        );
        Container(
          child: Text(
            'Patata',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //alignment: Alignment(-1.0, 0.0),
          margin: const EdgeInsets.only(left: 10.0),
        );
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Image.asset('images/postrestock.jpg'),
        );
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
        ));
      }),
    );
  }*/
} // fin de la clase _HomeState
