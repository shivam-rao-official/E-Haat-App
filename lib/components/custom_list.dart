import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class CustomList extends StatefulWidget {
  @override
  _CustomListState createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  String id;
  Future getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.get('UID');
      print(id);
    });
  }

  void initState() {
    super.initState();
    getId();
  }

  Stream<dynamic> fetchData() async* {
    // print(id);
    var url = "https://ehaat.herokuapp.com/smanagerapi/seeProducts";
    var res = await http.get(
      url,
      headers: {
        "authorization": id,
      },
    );
    if (res.statusCode == 200) {
      var jsRes = convert.jsonDecode(res.body);
      yield jsRes["data"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.data == null) return CircularProgressIndicator();
        if (snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
              while (index + 4 != snapshot.data.length) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          child: Card(
                            elevation: 10,
                            borderOnForeground: true,
                            // color: Colors.blue,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  height: 150,
                                ),
                                productName(
                                    snapshot.data[index]["product_name"]),
                                productPrice(
                                    snapshot.data[index]["product_price"]),
                                productPrice(
                                    snapshot.data[index]["product_quantity"]),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          child: Card(
                            elevation: 10,
                            borderOnForeground: true,
                            // color: Colors.blue,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  height: 150,
                                ),
                                productName(
                                    snapshot.data[index + 1]["product_name"]),
                                productPrice(
                                    snapshot.data[index + 1]["product_price"]),
                                productPrice(snapshot.data[index + 1]
                                    ["product_quantity"]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }
            },
          );
        }
      },
      stream: fetchData(),
    );
  }

  Widget productName(String label) {
    return Text(
      "$label",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.black87,
      ),
    );
  }

  Widget productQuantity(int label) {
    return Text(
      "$label",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.black87,
      ),
    );
  }

  Widget productPrice(int label) {
    return Text(
      "$label",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.black87,
      ),
    );
  }
}
