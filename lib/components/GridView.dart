import 'package:e_haat/widget/custom_Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Productabs extends StatefulWidget {
  String id;
  Productabs({@required this.id});
  @override
  _ProductabsState createState() => _ProductabsState();
}

class _ProductabsState extends State<Productabs> {
  Future<dynamic> fetchData() async {
    var url = "https://ehaat.herokuapp.com/smanagerapi/seeProducts";
    var res = await http.get(
      url,
      headers: {
        "authorization": widget.id,
      },
    );
    if (res.statusCode == 200) {
      var jsRes = convert.jsonDecode(res.body);
      return jsRes["data"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snap) {
        if (!snap.hasData)
          return Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text('Loading...Please Wait.')
              ],
            ),
          );
        if (snap.data == null)
          return Center(
            child: Column(
              children: [
                Text("Sorry... You have nothing in the Store."),
              ],
            ),
          );
        if (snap.hasError)
          return Center(
            child: Text("Oops!! Error Occured"),
          );
        if (snap.hasData)
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snap.data.length,
            itemBuilder: (context, i) {
              return CustomCard(
                prodName: snap.data[i]["product_name"],
                prodPrice: snap.data[i]["product_price"],
                prodQuantity: snap.data[i]["product_quantity"],
              );
            },
          );
      },
    );
  }
}
