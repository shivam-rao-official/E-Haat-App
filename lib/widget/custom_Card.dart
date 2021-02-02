import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomCard extends StatefulWidget {
  String prodName;

  int prodPrice, prodQuantity;
  CustomCard({
    @required this.prodName,
    @required this.prodPrice,
    this.prodQuantity,
  });
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 800,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
            )
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage(
                      'images/GreenSalad.jpg',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                prodName('${widget.prodName}'),
                prodPrice(widget.prodPrice),
                prodQuantity(widget.prodQuantity),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget prodName(String prodName) {
    return Text(
      '$prodName',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget prodPrice(int prodPrice) {
    return Text(
      'Price: Rs.$prodPrice',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget prodQuantity(int prodQuantity) {
    return prodQuantity == 0
        ? Text(
            'Available: OutStock',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              backgroundColor: Colors.red,
              color: Colors.white,
            ),
          )
        : Text(
            'Available: $prodQuantity kg',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          );
  }
}
