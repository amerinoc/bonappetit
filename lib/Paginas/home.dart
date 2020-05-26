import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:like_button/like_button.dart';

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
  int index;
  Future _data, _usuarios;

  @override
  Widget build(BuildContext context) {
    sacaDocumentos();
    return Scaffold(
      floatingActionButton: Container(
        width: 60,
        height: 60,
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
                                    child: Image.network(
                                        snap.data[index].data['img']),
                                    margin: const EdgeInsets.only(top: 10.0),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              child: LikeButton(
                                                onTap: (bool isLiked) {
                                                  return onLikeButtonTapped(
                                                      isLiked,
                                                      index,
                                                      int.parse(snap.data[index]
                                                          .data['likes']
                                                          .toString()));
                                                },
                                                likeCount: int.parse(snap
                                                    .data[index].data['likes']
                                                    .toString()),
                                                size: 35.0,
                                                circleColor: CircleColor(
                                                    start: Color(0xffCC0000),
                                                    end: Color(0xffFFA500)),
                                                bubblesColor: BubblesColor(
                                                  dotPrimaryColor:
                                                      Color(0xffFFC04C),
                                                  dotSecondaryColor:
                                                      Color(0xffC97F7F),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 90.0, right: 84.0),
                                              child: Text(snap
                                                  .data[index].data['nombre']),
                                            ),
                                            Container(
                                              child: IconButton(
                                                iconSize: 32.0,
                                                icon: Icon(
                                                    Icons.chat_bubble_outline),
                                              ),
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
    await Firestore.instance
        .collection('collection')
        .where('ref', isEqualTo: idUser)
        .getDocuments()
        .then((doc) {
      username = doc.documents[1]['ref'];
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked, int index, int likes) async {
    /// send your request here
    // final bool success= await sendRequest();
    String doc = (index + 1).toString();
    int likestot = likes + 1;

    db.collection('recetas').document(doc).updateData({'likes': likestot});

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
} // fin de la clase _HomeState
