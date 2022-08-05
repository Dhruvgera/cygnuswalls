import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: const <Widget>[
      Text(
        "CygnusOS",
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass',),
        textAlign: TextAlign.center,
      ),
      Text(
        " Walls",
        style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
      )
    ],
  );
}

Widget imageLoader(String imgURL, int index) =>
    Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Image.network(imgURL, fit: BoxFit.cover)
    );