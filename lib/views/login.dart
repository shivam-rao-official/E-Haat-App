import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String _name;
String _email;
String _passwd;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  ///
  ///  Setting up http module
  ///

  final url = "https://ehaat.herokuapp.com/smanagerapi/login";

  final _formKey = GlobalKey<FormState>();
  static var counter = 1;
  bool obscure = true;
  bool obscureCount() {
    counter++;
    return counter % 2 != 0 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          backGroundImage(context),
          heading(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.height / 2 - 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        emailField(),
                        SizedBox(
                          height: 30,
                        ),
                        /**
                         * Password Field
                         */
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
                            suffixIcon: IconButton(
                              icon: counter % 2 == 0
                                  ? Icon(Icons.panorama_fish_eye_outlined)
                                  : Icon(Icons.circle),
                              onPressed: () {
                                setState(() {
                                  obscure = obscureCount();
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          obscureText: obscure,
                          obscuringCharacter: '*',
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (val) {
                            _passwd = val;
                          },
                          onSaved: (val) {
                            _passwd = val;
                          },
                          // ignore: missing_return
                          validator: (val) {
                            if (val.isEmpty)
                              return 'Password is Required';
                            else if (val.length < 6)
                              return 'Password must be of length 6';
                          },
                        ), //Password Field Ends
                        SizedBox(
                          height: 80,
                        ),
                        MaterialButton(
                          onPressed: login,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              40,
                              10,
                              40,
                              10,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                          ),
                          color: Colors.greenAccent.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          splashColor: Colors.yellowAccent.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState.validate()) {
      storeDb();
    }
  }

  Future<void> storeDb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res =
        await http.post(url, body: {'email': _email, 'password': _passwd});
    if (res.statusCode == 200) {
      var jsRes = convert.jsonDecode(res.body);
      if (jsRes['token'] != null) {
        setState(() {
          prefs.setString('UID', jsRes['token']);
          prefs.setString('UNAME', jsRes['data']['name']);
          prefs.setString('UEMAIL', _email);
          Navigator.of(context).pushReplacementNamed('/home');
        });
      } else {
        return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error in Authencation'),
                content: Text(
                    'Email or Password you entered is incorrect, \nCredentials not matched'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Retry'),
                  ),
                ],
              );
            });
      }
    }
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
          image: AssetImage('images/VarietyLikeAMall.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget heading() {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, top: 25),
    child: Text(
      'Sign In...',
      style: TextStyle(
        color: Colors.white,
        fontSize: 66,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget nameField() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: 'Name',
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onChanged: (val) {
      _name = val;
    },
    onSaved: (val) {
      _name = val;
    },
    // ignore: missing_return
    validator: (val) {
      if (val.isEmpty) return 'Name is Required';
    },
  );
}

Widget emailField() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: 'Email Here',
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    onChanged: (val) {
      _email = val;
    },
    onSaved: (val) {
      _email = val;
    },
    // ignore: missing_return
    validator: (val) {
      if (val.isEmpty) return 'Email is Required';
    },
  );
}
