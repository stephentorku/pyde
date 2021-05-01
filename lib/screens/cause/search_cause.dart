import 'package:flutter/material.dart';
import 'package:pyde/screens/cause/cause_details.dart';
import 'package:pyde/shared/drawer.dart';

class SearchCause extends StatefulWidget {
  @override
  _SearchCauseState createState() => _SearchCauseState();
}

class _SearchCauseState extends State<SearchCause> {
  final _formKey = GlobalKey<FormState>();
  String _searchID;
  final snackBarFound = SnackBar(
    content: Text('Cause Found'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        elevation: 0.0,
        title: Text('Search Cause'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200.0,
          ),
          Text(
            ' Search for Private Causes',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          SizedBox(
            height: 9.0,
          ),
          Text(
            'Enter SearchID',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() => _searchID = text);
                      },
                      cursorColor: Colors.brown,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a Search key' : null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBarFound);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CauseDetails(
                                              searchID: _searchID,
                                            )));
                              }
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
