import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pyde/models/user.dart';
import 'package:pyde/screens/home/home.dart';
import 'package:pyde/services/database.dart';
import 'package:pyde/shared/hexToColor.dart';
import 'package:pyde/shared/button.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class CheckoutMethodCard extends StatefulWidget {
  String searchID;
  CheckoutMethodCard({this.searchID});
  @override
  _CheckoutMethodCardState createState() => _CheckoutMethodCardState();
}

// Pay public key
class _CheckoutMethodCardState extends State<CheckoutMethodCard> {
  final _formKey = GlobalKey<FormState>();
  final paystack = PaystackPlugin();
  int _currentAmount;
  String _currentEmail;
  String searchID;

  @override
  void initState() {
    paystack.initialize(
        publicKey: "pk_test_121f560f6bc2725aa260b3cce14a66232925fd63");
    super.initState();
  }

  sendMail(receiver, name, title) async {
    //TODO send mail if target has been reached
    String username = 'stephentorku22@gmail.com';
    String password = 'Storku0506';

    //also use for gmail smtp
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, '@Pyde')
      ..recipients.add(receiver)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Pyde: Your target for ' +
          title +
          ' on the Pyde platform has been met'
      ..text = 'Hello ' + name + ' \nHurray!, your target has been met.';
    // ..html = "<h1>Pyde</h1>\n<p>Your #1 payment platform</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Dialog successDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_box,
                color: hexToColor("#41aa5e"),
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Payment has successfully',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'been made',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Your payment has been successfully",
                style: TextStyle(fontSize: 13),
              ),
              Text("processed.", style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }

  Dialog errorDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Failed to process payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Error in processing payment, please try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<bool> chargeCard() async {
    Charge charge = Charge()
      ..amount = _currentAmount * 100
      ..reference = _getReference()
      ..currency = 'GHS'
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = _currentEmail;
    CheckoutResponse response = await paystack.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      Stream<CauseData> stream =
          DetailsService(searchID: widget.searchID).amountRaised;
      if (stream != null) {
        CauseData causeData = await stream.first;
        int oldAmount = causeData.currentAmount;
        print(oldAmount);
        print(_currentAmount);
        DetailsService(searchID: widget.searchID)
            .updateCauseAmountRaised(oldAmount + _currentAmount);
      }

      Stream<CauseData> emailstream =
          DetailsService(searchID: widget.searchID).emailDetails;
      if (emailstream != null) {
        CauseData causeData = await emailstream.first;
        int target = causeData.target;
        int amountRaised = causeData.currentAmount;
        String notified = causeData.notified;
        if (amountRaised >= target && notified == 'n') {
          sendMail(causeData.email, causeData.starter, causeData.title);
          DetailsService(searchID: widget.searchID).updateNotifiedStatus('y');
        }
      }

      //TODO: update amount and send notification to starter
      _showDialog();
      Navigator.pop(context);
      return true;
    } else {
      _showErrorDialog();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text(
          "Confirm Payment",
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color: Colors.white70),
                        labelText: "Enter E-mail",
                      ),
                      // Only numbers can be entered
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your email' : null,
                      onChanged: (val) => setState(() => _currentEmail = val)),
                  TextFormField(
                      decoration: new InputDecoration(
                          labelStyle: TextStyle(color: Colors.white70),
                          labelText: "Enter Amount"),
                      keyboardType: TextInputType.number,
                      // Only numbers can be entered
                      validator: (val) =>
                          val.isEmpty ? 'Please enter an amount' : null,
                      onChanged: (val) =>
                          setState(() => _currentAmount = int.parse(val))),
                  Button(
                    child: Text(
                      "Pay",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onClick: () {
                      if (_formKey.currentState.validate()) {
                        chargeCard();
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
