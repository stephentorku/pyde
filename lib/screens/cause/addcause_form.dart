import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyde/models/user.dart';
import 'package:pyde/services/database.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:pyde/shared/flutter_button.dart';

class AddCause extends StatefulWidget {
  @override
  _AddCauseState createState() => _AddCauseState();
}

final DateTime now = DateTime.now();

class _AddCauseState extends State<AddCause> {
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  final _formKey = GlobalKey<FormState>();

  final List<String> access = ['public', 'private'];

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String currentDate = formatter.format(now);

  String _currentAccess;
  String _currentTitle;
  String _currentName;
  String _currentDescription;
  String _currentEmail;
  int _currentTarget;

  final snackBarAdded = SnackBar(
    content: Text('Cause Created!'),
  );
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Starter>(context);
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text('Add Cause'),
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              "Enter Cause Details",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              cursorColor: Colors.brown,
              validator: (val) => val.isEmpty ? 'Please enter a title' : null,
              onChanged: (val) => setState(() => _currentTitle = val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'Your name',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              cursorColor: Colors.brown,
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              cursorColor: Colors.brown,
              validator: (val) =>
                  val.isEmpty ? 'Please enter a description' : null,
              onChanged: (val) => setState(() => _currentDescription = val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'E-mail',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              cursorColor: Colors.brown,
              validator: (val) => val.isEmpty ? 'Please enter an email' : null,
              onChanged: (val) => setState(() => _currentEmail = val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                hintText: 'Target Amount',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              cursorColor: Colors.brown,
              validator: (val) => val.isEmpty ? 'Please enter an amount' : null,
              onChanged: (val) =>
                  setState(() => _currentTarget = int.parse(val)),
            ),
            SizedBox(height: 20.0),
            Text(
              'Select Access Type',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0),
            ),
            DropdownButtonFormField(
              dropdownColor: Colors.black45,
              value: _currentAccess ?? 'public',
              items: access.map((view) {
                return DropdownMenuItem(
                  value: view,
                  child: Text(
                    '   $view access',
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }).toList(),
              onChanged: (val) => setState(() => _currentAccess = val),
            ),
            SizedBox(height: 20.0),
            HoverButton(
              title: "Add Cause",
              titleColor: Colors.white,
              spashColor: Colors.black,
              tappedTitleColor: Colors.white,
              borderColor: Colors.white,
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  await DatabaseService(uid: user.uid).createCause(
                      _currentTitle,
                      _currentName,
                      _currentDescription,
                      _currentEmail,
                      _currentTarget,
                      0,
                      _currentAccess,
                      currentDate);
                  ScaffoldMessenger.of(context).showSnackBar(snackBarAdded);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
