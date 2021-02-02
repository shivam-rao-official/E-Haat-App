import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var id;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.get('UID');
  }

  // ignore: must_call_super
  void initState() {
    getData();
    Timer(Duration(seconds: 7), () {
      if (id == null) {
        Navigator.of(context).pushReplacementNamed('/signin');
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          backGroundImage(context),
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              foreGroundImage(context),
              heading(context),
              subHeading(context),
              SizedBox(
                height: 80,
              ),
              progressIndicator(context),
            ],
          ),
        ],
      ),
    );
  }
}

Widget backGroundImage(BuildContext context) {
  return ImageFiltered(
    imageFilter: ImageFilter.blur(
      sigmaX: 5,
      sigmaY: 5,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        image: DecorationImage(
          image: AssetImage('images/FarmerWithFood.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget foreGroundImage(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 2 + 100,
    width: MediaQuery.of(context).size.width - 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: AssetImage('images/FarmerWithFood.jpg'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget heading(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0),
    child: Align(
      alignment: Alignment.topLeft,
      child: Text(
        'E-Haat',
        style: TextStyle(
          color: Colors.white,
          fontSize: 56,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    ),
  );
}

Widget subHeading(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0),
    child: Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Farmers own e-Store',
        style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.normal,
          letterSpacing: 1,
        ),
      ),
    ),
  );
}

Widget progressIndicator(BuildContext context) {
  return CircularProgressIndicator(
    backgroundColor: Colors.greenAccent.withOpacity(0.6),
    strokeWidth: 3,
  );
}
