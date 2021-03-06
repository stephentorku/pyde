import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyde/models/user.dart';
import 'package:pyde/screens/authenticate/authenticate.dart';
import 'package:pyde/screens/cause/addcause_form.dart';
import 'package:pyde/screens/home/dashboard.dart';
import 'package:pyde/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Starter>(context);

    if (user == null) {
      print('user is null');
      return Authenticate();
    } else {
      print('user: ');
      print(user);
      return Dashboard();
    }
  }
}
