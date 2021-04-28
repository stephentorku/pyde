import 'package:flutter/material.dart';
import 'package:pyde/screens/cause/addcause_form.dart';
import 'package:pyde/screens/cause/search_cause.dart';
import 'package:pyde/screens/home/home.dart';
import 'package:pyde/screens/wrapper.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF4A4A58),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(left: 90),
                child: Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home()));
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Cause'),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SearchCause()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('Create Cause'),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Wrapper()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
