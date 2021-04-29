import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyde/models/user.dart';
import 'package:pyde/services/database.dart';
import 'package:pyde/shared/flutter_button.dart';

class EditCause extends StatefulWidget {
  @override
  _EditCauseState createState() => _EditCauseState();
}

class _EditCauseState extends State<EditCause> {
  final List<String> access = ['public', 'private'];
  String _currentAccess;
  String _currentTitle;
  String _currentName;
  String _currentDescription;
  String _currentEmail;
  int _currentTarget;
  final _formKey2 = GlobalKey<FormState>();
  final snackBarEdited = SnackBar(
    content: Text('Cause Edited!'),
  );

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Starter>(context);
    return StreamBuilder<CauseData>(
        stream: DetailsService(searchID: user.uid).causeData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CauseData userData = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                  key: _formKey2,
                  child: Column(
                    children: [
                      Text(
                        'Update your Cause details.',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.title,
                        decoration: InputDecoration(
                            hintText: 'Title', labelText: 'Title:'),
                        cursorColor: Colors.brown,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a title' : null,
                        onChanged: (val) => setState(() => _currentTitle = val),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.starter,
                        decoration: InputDecoration(
                            hintText: 'Your name', labelText: 'Name:'),
                        cursorColor: Colors.brown,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.description,
                        decoration: InputDecoration(
                            hintText: 'Description', labelText: 'Description:'),
                        cursorColor: Colors.brown,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a description' : null,
                        onChanged: (val) =>
                            setState(() => _currentDescription = val),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.email,
                        decoration: InputDecoration(
                            hintText: 'E-mail', labelText: 'E-mail:'),
                        cursorColor: Colors.brown,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter an email' : null,
                        onChanged: (val) => setState(() => _currentEmail = val),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.target.toString(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Target Amount',
                            labelText: 'Target amount:'),
                        cursorColor: Colors.brown,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter an amount' : null,
                        onChanged: (val) =>
                            setState(() => _currentTarget = int.parse(val)),
                      ),
                      SizedBox(height: 20.0),
                      Text('Select Access Type:'),
                      DropdownButtonFormField(
                        hint: Text('Select Access type'),
                        value: _currentAccess ?? userData.access,
                        items: access.map((view) {
                          return DropdownMenuItem(
                            value: view,
                            child: Text('$view Access'),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => _currentAccess = val),
                      ),
                      SizedBox(height: 20.0),
                      HoverButton(
                        title: "Update",
                        titleColor: Colors.black,
                        spashColor: Colors.black,
                        tappedTitleColor: Colors.white,
                        borderColor: Colors.black,
                        onTap: () {
                          if (_formKey2.currentState.validate()) {
                            DetailsService(searchID: user.uid)
                                .updateEditDetails(
                                    _currentTitle ?? userData.title,
                                    _currentName ?? userData.starter,
                                    _currentDescription ?? userData.description,
                                    _currentTarget ?? userData.target,
                                    _currentEmail ?? userData.email,
                                    _currentAccess ?? userData.access);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarEdited);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  )),
            );
          } else {
            return Center(child: Text('Cannot Edit, Add a Cause'));
          }
        });
  }
}
