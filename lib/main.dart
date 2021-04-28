import 'package:flutter/material.dart';
import 'package:pyde/models/user.dart';
import 'package:pyde/screens/authenticate/signinpage.dart';
import 'package:pyde/screens/authenticate/signup_page.dart';
import 'package:pyde/screens/cause/search_cause.dart';
import 'package:pyde/screens/home/home.dart';
import 'package:pyde/screens/home/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:pyde/screens/wrapper.dart';
import 'package:pyde/services/auth.dart';
import 'package:pyde/services/paystack_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pyde/services/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Starter>.value(
      value: AuthService().user,
      child: MaterialApp(
        // home: Wrapper(),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/landing': (context) => Landing(),
          '/home': (context) => Home(),
          '/search': (context) => SearchCause(),
          '/add-cause': (context) => Wrapper(),
          '/signin': (context) => SignInPage(),
          '/signup': (context) => SignUpPage(),
          '/payment': (context) => CheckoutMethodCard(),
        },
      ),
    );
  }
}
