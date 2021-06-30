import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:newsportal_app/LatestPostDetails.dart';
import 'package:newsportal_app/View/InternationalNews/InternationalAllNews.dart';
import 'package:newsportal_app/View/JobsSection/JobsSection.dart';
import 'package:newsportal_app/View/LocalNews/LocalAllNews.dart';
import 'package:newsportal_app/View/SportsNews/CovidUpdates.dart';
import 'package:newsportal_app/carousel.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;

  CollectionReference collectionReference =
      Firestore.instance.collection("LatestPost");

  @override
  void initState() {
    subscription = collectionReference.snapshots().listen((datasnap) {
      setState(() {
        snapshot = datasnap.documents;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(40, 40),
              bottomRight: Radius.elliptical(40, 40)),
        ),
        elevation: 10,
        title: Center(
          child: Text(
            "News Portal",
            style: TextStyle(
              fontFamily: "Playfair Display",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      // c
      //backgroundColor: Colors.blueGrey[900],
      body: ListView(
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Card(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.height / 100),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: Colors.black54,
                            width: MediaQuery.of(context).size.height / 400)),
                    color: Colors.white,

                    //margin: EdgeInsets.only(left: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 33),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                snapshot[index].data()["image"],
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 2.6,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LatestPostDetails(
                                        snapshot: snapshot[index],
                                      )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          50),
                                  // child: InkWell(
                                  //   onTap: (){
                                  //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LatestPostDetails(snapshot[index])));
                                  //   },

                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.height /
                                                150),
                                    child: Text(
                                      snapshot[index].data()["title"],
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                //),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        400),

                                Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          MediaQuery.of(context).size.height /
                                              50),
                                  child: Text(
                                    snapshot[index].data()["content"],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                65,
                                        color: Colors.black),
                                  ),
                                ),

                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        100),
                                Container(
                                  //margin: EdgeInsets.only(top: 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100),
                                      Text(
                                        "View",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //SizedBox(height: 0),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 100),
            child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blueGrey[900]),
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 100),
                height: MediaQuery.of(context).size.height / 3.5,
                child: Container(
                  width: MediaQuery.of(context).size.width / 100,
                  child: Advertisment(),
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 400),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LocalAllNews()));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 30,
                  right: MediaQuery.of(context).size.height / 30),
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.height / 400)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Mumbai Breaking News",
                      style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontSize: MediaQuery.of(context).size.height / 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 400),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CovidUpdates()));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 30,
                  right: MediaQuery.of(context).size.height / 30),
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.height / 400)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Covid-19 Updates",
                      style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontSize: MediaQuery.of(context).size.height / 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 100),

          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InternationalAllNews()));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 30,
                  right: MediaQuery.of(context).size.height / 30),
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.height / 400)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "National/International News",
                      style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontSize: MediaQuery.of(context).size.height / 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 400),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => JobsSection()));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 30,
                  right: MediaQuery.of(context).size.height / 30),
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.height / 400)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Jobs in Town",
                      style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontSize: MediaQuery.of(context).size.height / 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 40),
        ],
      ),
    );
  }
}
