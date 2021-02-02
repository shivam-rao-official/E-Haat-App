import 'package:e_haat/components/custom_appbar.dart';
import 'package:e_haat/components/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCart extends StatefulWidget {
  @override
  _HomeCartState createState() => _HomeCartState();
}

class _HomeCartState extends State<HomeCart> {
  String _name, _email;

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.get('UNAME');
      _email = prefs.get('UEMAIL');
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          name: _name,
          email: _email,
          icon: Icon(Icons.supervised_user_circle_outlined),
        ),
      ),
      body: CustomList(),
    );
  }
}
