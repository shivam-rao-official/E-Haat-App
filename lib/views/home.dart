import 'dart:ui';

import 'package:e_haat/components/GridView.dart';
import 'package:e_haat/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String _id;
String _name;
String _email;

class _HomeState extends State<Home> {
  SharedPreferences prefs;

  Future<void> getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = prefs.get('UID');
      _name = prefs.get('UNAME');
      _email = prefs.get('UEMAIL');
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: CustomAppBar(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: RefreshIndicator(
                onRefresh: refreshData,
                child: Productabs(id: _id),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> refreshData() async {
    await Future.delayed(
      Duration(
        milliseconds: 1000,
      ),
    );

    setState(() {
      Productabs(id: _id);
    });
  }
}
