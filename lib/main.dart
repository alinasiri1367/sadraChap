import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadra2/pages/home.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'چاپ صدرا',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Vazir',
          primarySwatch: Colors.red,
          primaryColor: Color(0xff1f315c),
          accentColor: Colors.white),
      home: new Directionality(
          textDirection: TextDirection.rtl,
          child: new Home()
      ),
    );
  }
}
