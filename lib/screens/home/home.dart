import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyde/screens/home/cause_list.dart';
import 'package:pyde/services/database.dart';
import 'package:pyde/shared/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseService().causes,
      child: Scaffold(
        backgroundColor: Color(0xff21254A),
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xff21254A),
          elevation: 0.0,
          title: Text(
            'Public Causes',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        body: Container(
          child: CauseList(),
        ),
      ),
    );
  }
}
