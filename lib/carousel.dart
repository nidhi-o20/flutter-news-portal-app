import 'dart:async';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Advertisment extends StatefulWidget {
  @override
  _AdvertismentState createState() => _AdvertismentState();
}

class _AdvertismentState extends State<Advertisment> {

  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;

  CollectionReference snap =
  Firestore.instance.collection("AdSection");


  @override
  void initState() {
    subscription = snap.snapshots().listen((datasnap) {
      setState(() {
        snapshot = datasnap.documents;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Carousel(
    boxFit: BoxFit.cover,
    autoplay: true,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 600),
    dotSize: 6.0,
    dotIncreasedColor: Color(0xFFFF335C),
    dotBgColor: Colors.transparent,
    dotPosition: DotPosition.bottomCenter,
    dotVerticalPadding: 10.0,
    showIndicator: true,
    borderRadius: true,
    indicatorBgPadding: 7.0,
    images: [
      Image.network(snapshot[0].data()["add"]),
      Image.network(snapshot[1].data()["add"]),
      Image.network(snapshot[2].data()["add"]),
      Image.network(snapshot[3].data()["add"]),
      Image.network(snapshot[4].data()["add"]),
      //Image.network(snapshot[1].data()["two"]),
    ],

      );
  }
}