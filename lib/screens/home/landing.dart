import 'package:flutter/material.dart';
import 'package:pyde/Animation/FadeAnimation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pyde/shared/flutter_button.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: FadeAnimation(
                  1,
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/1.png"),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                FadeAnimation(
                  1,
                  Text(
                    "Welcome to Pyde,\n A contribution platform",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HoverButton(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/add-cause',
                            (Route<dynamic> route) => false);
                      },
                      title: "Start a Cause",
                      titleSize: 20,
                      titleColor: Colors.purple[100],
                      spashColor: Colors.white,
                      tappedTitleColor: Colors.black,
                      fontWeight: FontWeight.bold,
                      borderColor: Colors.purple[100],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    HoverButton(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (Route<dynamic> route) => false);
                      },
                      title: "Contribute",
                      titleSize: 20,
                      titleColor: Colors.purple[100],
                      spashColor: Colors.white,
                      tappedTitleColor: Colors.black,
                      fontWeight: FontWeight.bold,
                      borderColor: Colors.purple[100],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
