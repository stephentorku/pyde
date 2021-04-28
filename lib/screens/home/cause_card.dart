import 'package:flutter/material.dart';

import 'package:pyde/models/cause.dart';
import 'package:pyde/screens/cause/cause_details.dart';
import 'package:pyde/shared/button.dart';

class CauseCard extends StatelessWidget {
  final Cause cause;

  CauseCard({this.cause});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.black45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.payment,
                color: Colors.white70,
              ),
              title: Text(
                'Title: ' + '${cause.title}',
                style: TextStyle(color: Colors.white70),
              ),
              subtitle: Text(
                'Started by: ${cause.starter} on ${cause.created}',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton.icon(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CauseDetails(searchID: cause.searchID)));
                    },
                    label: Text(
                      'More Details',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
