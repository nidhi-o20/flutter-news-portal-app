import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsportal_app/View/JobsSection/JobsSectionDetails.dart';
import 'dart:async';

class JobsSection extends StatefulWidget {
  JobsSection({Key key}) : super(key: key);

  @override
  _JobsSectionState createState() => _JobsSectionState();
}

class _JobsSectionState extends State<JobsSection> {
  Future getAllPost() async {
    var firestore = Firestore.instance;

    QuerySnapshot snap =
        await firestore.collection("JobsSection").getDocuments();
    return snap.documents;
  }

  Future<Null> onRefresh() async {
    await Future.delayed(Duration(seconds: 3));

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
        title: Text("Jobs Section"),
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
                    child: Card(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.height / 100),
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                              color: Colors.black54,
                              width: MediaQuery.of(context).size.height / 400)),

                      //margin: EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                snapshot.data[index].data()["image"],
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 2.4,
                              ),
                            ),
                          ),
                          // SizedBox(width: MediaQuery.of(context).size.width / 50),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => JobsSectionDetails(
                                          snapshot: snapshot.data[index],
                                        )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.width /
                                                20),
                                    child: Text(
                                      snapshot.data[index].data()["title"],
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              55,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  //),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.height /
                                                20),
                                    child: Text(
                                      snapshot.data[index].data()["content"],
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              70,
                                          color: Colors.black),
                                    ),
                                  ),

                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100),
                                  Container(
                                    //margin: EdgeInsets.only(top: 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
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
                                            color: Colors.white,
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
                itemCount: snapshot.data.length,
              ),
            );
          }
        },
      ),
    );
  }
}
