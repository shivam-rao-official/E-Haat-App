import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

String _prodQuantity;
String _prodPrice;
bool _stock;

class UpdateProduct extends StatefulWidget {
  String prodname;
  UpdateProduct({this.prodname});
  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  ///
  /// Setting up the Http
  ///

  String prodname;
  _UpdateProductState({this.prodname});
  var url =
      "https://ehaat.herokuapp.com/smanagerapi/updateProduct/product(name)";
  final _updateKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          backGroundImage(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.7),
                ),
                child: Form(
                  key: _updateKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // prodName(),
                        SizedBox(
                          height: 40,
                        ),
                        prodQuantity(),
                        SizedBox(
                          height: 40,
                        ),
                        prodPrice(),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        MaterialButton(
                          onPressed: updateProduct,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                              top: 10.0,
                              right: 40,
                              bottom: 10.0,
                            ),
                            child: Text(
                              'Add Product',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          color: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
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

  Future<void> updateProduct() async {
    if (_updateKey.currentState.validate()) {
      productDB();
    }
  }

  Future<void> productDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await http.put(
      url,
      headers: {
        'authorization': prefs.get('UID'),
      },
      body: {
        'product_name': widget.prodname,
        'product_quantity': _prodQuantity,
        'product_price': _prodPrice,
        'inStock': _stock,
      },
    );

    var jsRes = await convert.jsonDecode(res.body);
    if (jsRes['success']) {
      return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Product Added'),
              content: Text('Product: ${jsRes['message']}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    } else {
      return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oops Error occured'),
              content: Text('Product: ${jsRes['message']}'),
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
          image: AssetImage('images/PickedWithCare.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget prodName() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: 'Product Name',
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    enabled: false,
  );
}

Widget prodQuantity() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: 'Quantity in Kg',
      suffix: Text('Kg'),
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onChanged: (val) {
      _prodQuantity = val;
    },
    onSaved: (val) {
      _prodQuantity = val;
    },
    // ignore: missing_return
    validator: (val) {
      if (val.isEmpty) return 'Product Price is Required';
    },
    keyboardType: TextInputType.number,
  );
}

Widget prodPrice() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: 'Price per kg',
      prefix: Text('Rs.'),
      suffix: Text('per Kg'),
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onChanged: (val) {
      _prodPrice = val;
    },
    onSaved: (val) {
      _prodPrice = val;
    },
    // ignore: missing_return
    validator: (val) {
      if (val.isEmpty) return 'Product Price is Required';
    },
    keyboardType: TextInputType.number,
  );
}
