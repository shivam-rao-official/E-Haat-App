import 'package:e_haat/components/add_product.dart';
import 'package:e_haat/views/home.dart';
import 'package:e_haat/views/home_cart.dart';
import 'package:e_haat/views/login.dart';
import 'package:e_haat/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/update_product.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  var id = prefs.getString('UID');
  // ignore: unused_local_variable
  var name = prefs.getString('UNAME');
  // ignore: unused_local_variable
  var email = prefs.getString('UEMAIL');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => SignIn(),
        '/home': (BuildContext context) => Home(),
        '/homenew': (BuildContext context) => HomeCart(),
        '/addprod': (BuildContext context) => AddProduct(),
        '/updateprod': (BuildContext context) => UpdateProduct(
              prodname: "",
            ),
      },
      home: Splash(),
    ),
  );
}
