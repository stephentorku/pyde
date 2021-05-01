import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pyde/screens/home/landing.dart';

class LoadDashboard extends StatefulWidget {
  @override
  _LoadDashboardState createState() => _LoadDashboardState();
}

class _LoadDashboardState extends State<LoadDashboard> {
  @override
  void initState() {
    super.initState();
    // getTime();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Landing())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
