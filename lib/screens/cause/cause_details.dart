import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyde/models/user.dart';
import 'package:pyde/screens/home/home.dart';
import 'package:pyde/services/database.dart';
import 'package:pyde/services/paystack_card.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pyde/shared/flutter_button.dart';

class CauseDetails extends StatelessWidget {
  final String
      searchID; //use this searchID to find document, then display details
  CauseDetails({this.searchID});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DetailsService(searchID: searchID).causeData,
        // value: DatabaseService().causeData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CauseData causeData = snapshot.data;

            double percentagestring =
                (causeData.currentAmount / causeData.target) * 100;
            double percentage = (causeData.currentAmount / causeData.target);
            String displayPercentage = percentagestring.toString() + '   ';

            return Scaffold(
              backgroundColor: Color(0xff21254A),
              appBar: AppBar(
                backgroundColor: Color(0xff21254A),
                elevation: 0.0,
                title: Text('Cause Details'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 40.0),
                          Card(
                              color: Colors.black45,
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            100.0, 15.0, 0.0, 0.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text('Title: ' + causeData.title,
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18.0)),
                                              SizedBox(height: 5.0),
                                              Text(
                                                  'Target: GH¢ ' +
                                                      causeData.target
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18.0)),
                                              SizedBox(height: 5.0),
                                              Text(
                                                  'Amount Raised: GH¢ ' +
                                                      causeData.currentAmount
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18.0)),
                                              SizedBox(height: 5.0),
                                              Text(
                                                  'Started on: ' +
                                                      causeData.created,
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18.0)),
                                              SizedBox(height: 5.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                      height: 130.0,
                                    ),

                                    // Expanded(...)
                                  ],
                                ),
                              )),
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
                                        child: Column(
                                          children: [
                                            Text('Description: ',
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 18.0)),
                                            Text(causeData.description,
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 18.0)),
                                            SizedBox(height: 5.0),
                                          ],
                                        ),
                                      ),
                                      height: 180.0,
                                    ),
                                    // Expanded(...)
                                  ],
                                ),
                              )),
                          SizedBox(height: 30.0),
                          HoverButton(
                            title: "Contribute",
                            titleColor: Colors.white,
                            spashColor: Colors.black45,
                            tappedTitleColor: Colors.black,
                            borderColor: Colors.white,
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CheckoutMethodCard(
                                            searchID: causeData.searchID,
                                          )));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    new CircularPercentIndicator(
                      radius: 150.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: percentage >= 1.0 ? 1.0 : percentage,
                      center: new Text(
                        displayPercentage.substring(0, 5) + "%",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      footer: new Text(
                        "\nRaised so far",
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.purple,
                    ),
                    SizedBox(height: 40.0),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 300.0,
                    ),
                    Text('Error, No Cause Found'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        },
                        child: Text('Click here to return to home'))
                  ],
                ),
              ),
            );
          }
        });
  }
}
