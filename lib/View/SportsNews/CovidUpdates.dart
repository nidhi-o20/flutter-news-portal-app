import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CovidUpdates extends StatefulWidget {
  @override
  _CovidUpdatesState createState() => _CovidUpdatesState();
}

class _CovidUpdatesState extends State<CovidUpdates> {
  Future getAllPost() async {
    var firestore = Firestore.instance;

    QuerySnapshot snap =
        await firestore.collection("CovidUpdates").getDocuments();
    return snap.documents;
  }

  Future<Null> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      getAllPost();
    });
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
        title: Text("Covid-19 Updates"),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: FutureBuilder(
        future: getAllPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                "Data Loading..",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 120,
                        right: MediaQuery.of(context).size.height / 120,
                        top: MediaQuery.of(context).size.height / 70,
                      ),
                      child: Card(
                        shadowColor: Colors.cyan[400],
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: Colors.black,
                                width:
                                    MediaQuery.of(context).size.height / 400)),
                        color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.all(
                              MediaQuery.of(context).size.height / 100),
                          // height: MediaQuery.of(context).size.height / 2.5,
                          child: Column(
                            children: [
                              Card(
                                  shadowColor: Colors.cyan[400],
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Colors.black,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              400)),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height /
                                            100),
                                    child: Text(
                                      snapshot.data[index].data()["city"],
                                      style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                    ),
                                  )),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 70),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Card(
                                        shadowColor: Colors.cyan[400],
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                                color: Colors.black,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    400)),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Total Cases",
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          45,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'Playfair Display',
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    .data()["totalcases"],
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          22,
                                                  fontFamily:
                                                      'Playfair Display',
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.red,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        30,
                                                  ),
                                                  Text(
                                                    snapshot.data[index].data()[
                                                        "totalcasesgrowth"],
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Playfair Display',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              30,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height /
                                              50,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Card(
                                        shadowColor: Colors.cyan[400],
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                                color: Colors.black,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    400)),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Recovered",
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          45,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'Playfair Display',
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    .data()["totalrecovered"],
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          22,
                                                  fontFamily:
                                                      'Playfair Display',
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.green,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        30,
                                                  ),
                                                  Text(
                                                    snapshot.data[index].data()[
                                                        "totalrecoveredgrowth"],
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Playfair Display',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              30,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.height / 50,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Card(
                                        shadowColor: Colors.cyan[400],
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                                color: Colors.black,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    400)),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Deaths",
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          45,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'Playfair Display',
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    .data()["totaldeaths"],
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          22,
                                                  fontFamily:
                                                      'Playfair Display',
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.grey,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        30,
                                                  ),
                                                  Text(
                                                    snapshot.data[index].data()[
                                                        "totaldeathgrowth"],
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Playfair Display',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              30,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height /
                                              50,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Card(
                                        shadowColor: Colors.cyan[400],
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                                color: Colors.black,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    400)),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Active Cases",
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          45,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'Playfair Display',
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    .data()["totalactive"],
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          22,
                                                  fontFamily:
                                                      'Playfair Display',
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.white,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        30,
                                                  ),
                                                  Text(
                                                    "10",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            30),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              ),
            );
          }
        },
      ),
    );
  }
}
