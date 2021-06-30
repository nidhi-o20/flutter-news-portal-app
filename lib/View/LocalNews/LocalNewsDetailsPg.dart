import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LocalNewsDetails extends StatefulWidget {
  DocumentSnapshot snapshot;

  LocalNewsDetails({this.snapshot});

  @override
  _LocalNewsDetailsState createState() => _LocalNewsDetailsState();
}

class _LocalNewsDetailsState extends State<LocalNewsDetails> {
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
        title: Text("Mumbai Breaking News"),
        backgroundColor: Colors.blueGrey[700],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 100),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Colors.black54,
                    // width: 4,
                  )),
              elevation: 5,
              child: Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 100),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.snapshot.data()["image"],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),

          //SizedBox(height:MediaQuery.of(context).size.height),
          Card(
            elevation: 5,
            color: Colors.white,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 70),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.black54,
                  // width: MediaQuery.of(context).size.height/200
                )),
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Text(
                          widget.snapshot.data()["title"][0],
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        backgroundColor: Colors.lightBlueAccent[400],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 30),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          widget.snapshot.data()["title"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width / 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height / 30,
                      right: MediaQuery.of(context).size.height / 30,
                      bottom: MediaQuery.of(context).size.height / 30),
                  child: Text(
                    widget.snapshot.data()["content"],
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 22,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
