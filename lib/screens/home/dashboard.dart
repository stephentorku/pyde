import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyde/models/user.dart';
import 'package:pyde/screens/cause/addcause_form.dart';
import 'package:pyde/screens/cause/edit_cause_modal.dart';
import 'package:pyde/services/database.dart';
import 'package:pyde/shared/drawer.dart';
import 'package:pyde/services/auth.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Starter>(context);

    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Confirm Action"),
            content: new Text("Are you sure you want to delete this cause?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  DetailsService(searchID: user.uid).deleteCause();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _showEditPanel() {
      showModalBottomSheet(
          backgroundColor: Colors.grey,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: EditCause(),
            );
          });
    }

    return StreamBuilder<CauseData>(
        stream: DetailsService(searchID: user.uid).causeData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CauseData userData = snapshot.data;
            double percentagestring =
                (userData.currentAmount / userData.target) * 100;
            double percentage = (userData.currentAmount / userData.target);
            return Scaffold(
              backgroundColor: Color(0xff21254A),
              appBar: AppBar(
                backgroundColor: Color(0xff21254A),
                title: Text('Dashboard'),
                actions: [
                  FlatButton.icon(
                      onPressed: () => _showEditPanel(),
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      )),
                  FlatButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      icon: Icon(Icons.person, color: Colors.white),
                      label:
                          Text("Logout", style: TextStyle(color: Colors.white)))
                ],
              ),
              drawer: MyDrawer(),
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 280.0, 0.0),
                    child: Text(
                      'Hello ' + userData.starter + ',',
                      style: TextStyle(color: Colors.white70, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                      color: Colors.black45,
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 15.0, 0.0, 0.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text('Title: ' + userData.title,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18.0)),
                                      SizedBox(height: 5.0),
                                      Text(
                                          'Target: GH¢ ' +
                                              userData.target.toString(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18.0)),
                                      SizedBox(height: 5.0),
                                      Text(
                                          'Amount Raised: GH¢ ' +
                                              userData.currentAmount.toString(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18.0)),
                                      SizedBox(height: 5.0),
                                      Text('Started on: ' + userData.created,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18.0)),
                                      SizedBox(height: 5.0),
                                      Text('SearchID: ' + userData.searchID,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18.0)),
                                    ],
                                  ),
                                ),
                              ),
                              height: 180.0,
                            ),
                            // Expanded(...)
                          ],
                        ),
                      )),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                      ),
                      onPressed: () {
                        _showDialog();
                      },
                      child: Text('Delete Cause')),
                  SizedBox(height: 40.0),
                  new CircularPercentIndicator(
                    radius: 150.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: percentage,
                    center: new Text(
                      percentagestring.toString() + "%",
                      style: new TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    footer: new Text(
                      "\nRaised so far",
                      style: new TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.purple,
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddCause()));
                },
                label: Text('Add Cause'),
                icon: Icon(Icons.add),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Color(0xff21254A),
              appBar: AppBar(
                backgroundColor: Color(0xff21254A),
                title: Text('Dashboard'),
                actions: [
                  FlatButton.icon(
                      onPressed: () => _showEditPanel(),
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      )),
                  FlatButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      icon: Icon(Icons.person, color: Colors.white),
                      label:
                          Text("Logout", style: TextStyle(color: Colors.white)))
                ],
              ),
              body: Center(
                child: Text('No Causes Found, Create a cause',
                    style: TextStyle(color: Colors.white70, fontSize: 18.0)),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddCause()));
                },
                label: Text('Add Cause'),
                icon: Icon(Icons.add),
              ),
            );
          }
        });
  }
}
