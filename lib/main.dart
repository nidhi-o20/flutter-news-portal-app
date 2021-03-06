import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsportal_app/Home.dart';
import 'package:flutter/services.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) =>
      Center(child: Container(height: 100, child: CircularProgressIndicator()));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(new MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));
  });
}
